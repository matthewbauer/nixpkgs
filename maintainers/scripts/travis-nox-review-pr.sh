#! /usr/bin/env bash
set -e

export NIX_CURL_FLAGS=-sS
export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

##
## HARDCODED, needs to be updated with Nix
NIX_VERSION=1.11.2
case "$TRAVIS_OS_NAME" in
    linux)
	nix="/nix/store/4z8srway6dl128dxzn5r0wwdvglz3m61-nix-1.11.2"
	cacert="/nix/store/4fh4nwd11frn1a3rifrdv6kdifrxrfwn-nss-cacert-3.21"
	;;
    osx)
	nix="/nix/store/g7wllqq33dc8a8dsb6r71wrbd6mz3ykf-nix-1.11.2"
	cacert="/nix/store/brfzgc99w9zyqj68i14w5jhyybg6j1sf-nss-cacert-3.21"
	;;
esac
##
##

while test -n "$1"; do
    echo -en "travis_fold:start:$1\r"

    case $1 in
        install)

            # Make sure we can use hydra's binary cache
            if [ ! -d /etc/nix/ ]; then
                sudo mkdir -p /etc/nix
                echo "build-max-jobs = 4" | sudo tee /etc/nix/nix.conf > /dev/null
            fi

            if [ ! -d /nix/ ]; then
                echo "=== Installing Nix..."

                case $TRAVIS_OS_NAME in
                    linux) system=x86_64-linux ;;
                    osx) system=x86_64-darwin ;;
                esac

                unpack=$HOME/nix-$NIX_VERSION-$system
                if [ ! -d $unpack/store/ ]; then
                    tarball=$HOME/nix-$NIX_VERSION-$system.tar.bz2
                    if [ ! -e $tarball ]; then
                        url="https://nixos.org/releases/nix/nix-$NIX_VERSION/nix-$NIX_VERSION-$system.tar.bz2"
                        echo "Downloading $url"
                        curl -sSL $url -o $tarball
                    fi

                    echo "Extracting $tarball"
                    < $tarball bzcat | tar -x -C $HOME

                    echo "Cleaning up"
                    rm -f $tarball
                fi

                sudo mkdir -m 0755 /nix/
                sudo chown $USER /nix/

                mkdir /nix/store/
                echo -n "Copying to nix store"
                for i in $(cd $unpack/store/ > /dev/null && echo *); do
                    echo -n "."
                    i_tmp="/nix/store/$i.$$"
                    if [ -e "$i_tmp" ]; then
                        rm -rf "$i_tmp"
                    fi
                    if ! [ -e "/nix/store/$i" ]; then
                        cp -Rp "$unpack/store/$i" "$i_tmp"
                        chmod -R a-w "$i_tmp"
                        chmod +w "$i_tmp"
                        mv "$i_tmp" "/nix/store/$i"
                        chmod -w "/nix/store/$i"
                    fi
                done
                echo

                echo "Initialising the database"
                $nix/bin/nix-store --init

                echo "Loading the database from the closure"
                $nix/bin/nix-store --load-db < $unpack/.reginfo
            else
                echo "=== Using Nix from cache"
            fi
            ;;

        verify)
            echo "=== Verifying that nixpkgs evaluates..."

            $nix/bin/nix-env --file $TRAVIS_BUILD_DIR --query --available --json > /dev/null
            ;;

        check)
            echo "=== Checking NixOS options"

            $nix/bin/nix-build $TRAVIS_BUILD_DIR/nixos/release.nix --attr options --show-trace
            ;;

	tarball)
            echo "=== Checking tarball creation"

            $nix/bin/nix-build $TRAVIS_BUILD_DIR/pkgs/top-level/release.nix --attr tarball --show-trace
            ;;

        pr)
            if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
                echo "$0: pr: no pull request available from Travis!" >&2
            else
                echo "=== Building pull request #$TRAVIS_PULL_REQUEST"

                $nix/bin/nix-shell --packages nox git python3 --run "nox-review pr $TRAVIS_PULL_REQUEST" -I nixpkgs=$TRAVIS_BUILD_DIR
            fi
            ;;

        *)
            echo "$0: Unknown option $1" >&2
            ;;
    esac

    echo -en "travis_fold:end:$1\r"
    shift
done
