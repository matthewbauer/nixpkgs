#! /usr/bin/env bash
set -e

export NIX_CURL_FLAGS=-sS

if [ -d $HOME/.nix-profile ]; then
    source $HOME/.nix-profile/etc/profile.d/nix.sh
fi

while test -n "$1"; do
    echo -en "travis_fold:start:$1\r"

    case "$1" in

        install)
            echo "=== Installing Nix..."

            curl -sS https://nixos.org/nix/install | sh

            # Make sure we can use hydra's binary cache
            sudo mkdir /etc/nix
            echo "build-max-jobs = 4" | sudo tee /etc/nix/nix.conf

            if [ "$TRAVIS_OS_NAME" == "linux" ]; then
                sudo mount -o remount,exec /run
                sudo mount -o remount,exec /run/user
                sudo mount
            fi
            ;;

        verify)
            echo "=== Verifying that nixpkgs evaluates..."

            nix-env -f. -qa --json >/dev/null
            ;;

        check)
            echo "=== Checking NixOS options"

            nix-build nixos/release.nix -A options --show-trace
            ;;

	tarball)
            echo "=== Checking tarball creation"

            nix-build pkgs/top-level/release.nix -A tarball --show-trace
            ;;

        pr)
            if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
                echo "$0: pr: no pull request available from Travis!" >&2
            else
                echo "=== Building pull request #$TRAVIS_PULL_REQUEST"

		nix-env -f. -iA nox
                nox-review pr $TRAVIS_PULL_REQUEST
            fi
            ;;

        *)
            echo "$0: Unknown option $1" >&2
            ;;

    esac

    echo -en "travis_fold:end:$1\r"

    shift
done
