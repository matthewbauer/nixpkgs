{ stdenv, lib, fetchgit, fetchFromGitHub
, ninja, pythonPackages, xcbuild
, gperf
, Carbon }:

let

  version = "0.12.3";

   # a lot of these aren't needed but it's not exactly clear which
  deps = ( import ./deps-0.12.3.nix { inherit fetchgit; }) // {
    # nwjs own dependencies
    "content/nw" = fetchFromGitHub {
      owner = "nwjs";
      repo = "nw.js";
      rev = "nw-v${version}";
      sha256 = "0lfanx5vc9ajsgcmllykl60hycl1m9jvzx2g7qgb21gilj9wvafw";
    };
    "v8" = fetchFromGitHub {
      owner = "nwjs";
      repo = "v8";
      rev = "nw-v${version}";
      sha256 = "12mymxran63alx2kymppalmycnv6d1rvwwahdkfm5hj188hwg642";
    };
    "third_party/node" = fetchFromGitHub {
      owner = "nwjs";
      repo = "node";
      rev = "nw-v${version}";
      sha256 = "03cb2sljrkd11g8n9p9ir0dg9z2q4884alv9m82zhw48mgndi4zn";
    };
    "third_party/WebKit" = fetchFromGitHub {
      owner = "nwjs";
      repo = "blink";
      rev = "nw-v${version}";
      sha256 = "1avswyzv0hr2z8bp5cpl9zbk4gym7pps9n2yxq0c21r9i0nj52xs";
    };
    "breakpad/src" = fetchFromGitHub {
      owner = "nwjs";
      repo = "breakpad";
      rev = "nw-v${version}";
      sha256 = "0jj8bxz952irzlz1djlq7q4bl5dd0qkc3c6fzkm6nk87kiq29pjw";
    };
  };

  mkGypFlags =
    let
      sanitize = value:
        if value == true then "1"
        else if value == false then "0"
        else "${value}";
      toFlag = key: value: "-D${key}=${sanitize value}";
    in attrs: lib.concatStringsSep " " (lib.attrValues (lib.mapAttrs toFlag attrs));

  buildType = "Release";
  buildPath = "out/${buildType}";

  buildTargets = [ "nw" ];

  gypFlags = mkGypFlags ({
    use_cups = false;
    disable_nacl = true;
    nwjs_sdk = true;
    clang_use_chrome_plugins = false;
  });

in

stdenv.mkDerivation {
  name = "nwjs-${version}";

  src = fetchFromGitHub {
    owner = "nwjs";
    repo = "chromium.src";
    rev = "nw-v${version}";
    sha256 = "1mm0p9s1i7f0akhd2xl0xp185k40gq7dimj3birfs9jqmxkmvsd4";
  };

  postUnpack = ''
    ${lib.concatStringsSep "\n" (
      lib.mapAttrsToList (n: v: ''
        echo "Unpacking source repository to ${n}"
        mkdir -p $sourceRoot/${n}
        cp -r ${v}/* $sourceRoot/${n}
      '') deps)}
  '';

  patchPhase = ''
    echo "LASTCHANGE=0" > build/util/LASTCHANGE
    echo "LASTCHANGE=0" > build/util/LASTCHANGE.blink
    substituteInPlace content/nw/nw.gypi \
      --replace "'commit_id'," ""
    substituteInPlace third_party/libphonenumber/libphonenumber.gyp \
      --replace "src/resources/" "resources/" \
      --replace "src/phonenumbers/" "phonenumbers/"
  '';

  configurePhase = ''
    echo "Precompiling .py files to prevent race conditions..." >&2
    python -m compileall -q -f . > /dev/null 2>&1 || : # ignore errors

    ./build/gyp_chromium \
      -f ninja \
      --no-circular-check \
      --depth . \
      ${gypFlags} content/content.gyp
  '';

  buildPhase = let
    buildCommand = target: ''
      ninja -C "${buildPath}"  \
        -j$NIX_BUILD_CORES -l$NIX_BUILD_CORES \
        "${target}"
    '';
    commands = map buildCommand buildTargets;
  in lib.concatStringsSep "\n" commands;

  nativeBuildInputs = [
    pythonPackages.python pythonPackages.gyp pythonPackages.pyobjc
    ninja gperf
  ] ++ stdenv.lib.optionals stdenv.isDarwin [ xcbuild ];

  buildInputs = stdenv.lib.optionals stdenv.isDarwin [ Carbon ];

  meta = with stdenv.lib; {
    description = "An app runtime based on Chromium and node.js";
    homepage = http://nwjs.io/;
    platforms = platforms.unix;
    maintainers = [ maintainers.offline ];
    license = licenses.bsd3;
  };
}
