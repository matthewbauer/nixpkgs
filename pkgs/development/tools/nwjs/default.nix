{ stdenv, lib, fetchgit, fetchFromGitHub, ninja, pythonPackages, callPackage }:

let

  version = "0.14.0";
  node_version = "6.3.1";
  chromium_version = "52.0.2743.116";

  # a lot of these aren't needed but it's not exactly clear which
  deps = ( import ./deps.nix { inherit fetchgit; }) // {
    # nwjs own dependencies
    "content/nw" = fetchFromGitHub {
      owner = "nwjs";
      repo = "nw.js";
      rev = "v${version}";
      sha256 = "1bm1p1s98j46w3cv0q3ig404vlcg4pyzf8bpcmc17cckgya7zhs9";
    };
    "v8" = fetchFromGitHub {
      owner = "nwjs";
      repo = "v8";
      rev = "2a9e6e168da1d6c391ae4de883ae83a0d78069fc";
      sha256 = "0z0r7v2l21rpz5y9j165lzh9i5al1j7ckplkld65bs83zsdqf6kd";
    };
    "third_party/node" = fetchFromGitHub {
      owner = "nwjs";
      repo = "node";
      rev = "7af389e81e82cb2170a7df06f93107fa6c30965d";
      sha256 = "1gv63s95kg5qxjp3rn0qcgafv1jh8hq1qmg0hhq3fvp4f9qfkpl8";
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

  buildTargets = [ "nwjs" ];

  gypFlags = mkGypFlags ({
    use_cups = false;
    disable_nacl = true;
  });

in

stdenv.mkDerivation {
  name = "nwjs-${version}";

  src = fetchFromGitHub {
    owner = "nwjs";
    repo = "chromium.src";
    rev = "c6612225ec9254f73cf9654235824b85ab7b0f4a";
    sha256 = "0gssdm86k1zrm1gcp8kbkc8hr0hnpg4xxsfaa3hpypmm6q059din";
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

    python content/nw/tools/patcher.py \
      --patch-config content/nw/patch/patch.cfg

    # **IMPURE**
    substituteInPlace build/mac/find_sdk.py \
      --replace "'xcode-select'" "'/usr/bin/xcode-select'"
    substituteInPlace build/mac_toolchain.py \
      --replace "'xcode-select'" "'/usr/bin/xcode-select'"
  '';

  configurePhase = ''
    echo "Precompiling .py files to prevent race conditions..." >&2
    python -m compileall -q -f . > /dev/null 2>&1 || : # ignore errors

    python build/gyp_chromium.py -f ninja --depth . ${gypFlags}
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
    pythonPackages.python pythonPackages.gyp
    ninja
  ];

  meta = with lib; {
    description = "An app runtime based on Chromium and node.js";
    homepage = http://nwjs.io/;
    platforms = platforms.all;
    maintainers = with maintainers; [ matthewbauer ];
    license = licenses.bsd3;
  };
}
