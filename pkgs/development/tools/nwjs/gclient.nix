{ stdenv, lib }:

let

base = rec {
  deps = {};
  buildTargets = [];
  gypFlags = {};

  postUnpack = ''
    ${lib.concatStringsSep "\n" (
      lib.mapAttrsToList (n: v: ''
        mkdir -p $sourceRoot/${n}
        cp -r ${v}/* $sourceRoot/${n}
      '') deps)}
  '';

  configurePhase = ''
    echo "Precompiling .py files to prevent race conditions..." >&2
    python -m compileall -q -f . > /dev/null 2>&1 || : # ignore errors

    python build/gyp_chromium -f ninja --depth . ${mkGypFlags gypFlags}
  '';

  buildPhase = let
    buildCommand = target: ''
      ninja -C "${buildPath}"  \
        -j$NIX_BUILD_CORES -l$NIX_BUILD_CORES \
        "${target}"
    '';
    commands = map buildCommand buildTargets;
  in concatStringsSep "\n" commands;

  nativeBuildInputs = [
    pythonPackages.python pythonPackages.gyp pythonPackages.ply pythonPackages.jinja2
    ninja
  ];
};

in stdenv.mkDerivation base
