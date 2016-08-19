{ stdenv, lib, fetchgit, fetchFromGitHub, ninja, pythonPackages, callPackage }:

let

  version = "0.16.1";

  # a lot of these aren't needed but it's not exactly clear which
  deps = ( import ./deps.nix { inherit fetchgit; }) // {
    # nwjs own dependencies
    "content/nw" = fetchFromGitHub {
      owner = "nwjs";
      repo = "nw.js";
      rev = "1d6387ea8a51e9ef7e290b5d4a7277fe45ffe376";
      sha256 = "15xx54yyf0q2bwq3ivd2fqm7x6i0srwpmhmlykp85bkgr9s73pr9";
    };
    "v8" = fetchFromGitHub {
      owner = "nwjs";
      repo = "v8";
      rev = "53e928e4905f64279cc2873c1881720cb042c266";
      sha256 = "0i24qja0kb32d7sv3sans8vfvy1md7kavap6lipcdxdj7p9idgbs";
    };
    "third_party/node" = fetchFromGitHub {
      owner = "nwjs";
      repo = "node";
      rev = "80ede2065782db05f7ebcc7af5e5870068411548";
      sha256 = "1bf14mxr8c3lzj4sh2lzz3wm2g5j9mxajs0pbd2ar8zxj4nimx4l";
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
    proprietary_codecs = false;
    use_cups = false;
    disable_nacl = true;
  });

in

stdenv.mkDerivation {
  name = "nwjs-${version}";

  src = fetchFromGitHub {
    owner = "nwjs";
    repo = "chromium.src";
    rev = "f529e82ad7009a4196321e7851c448e73da3b50f";
    sha256 = "156dxc852izkd1q7206v5nq5wwkg678gf56pvqkbpjq5b90ial7l";
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

    python build/gyp_chromium.py -f ninja --depth . ${gypFlags} --no-parallel
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
