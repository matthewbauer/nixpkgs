{ stdenv, callPackage, makeWrapper, writeText, CoreServices, ImageIO, CoreGraphics
, bootstrap_cmds }:

let

  toolchainName = "com.apple.dt.toolchain.XcodeDefault";
  platformName = "com.apple.platform.macosx";
  sdkName = "macosx10.10";

  xcbuild = callPackage ./default.nix {
    inherit CoreServices ImageIO CoreGraphics;
  };

  toolchain = callPackage ./toolchain.nix {
    inherit bootstrap_cmds toolchainName xcbuild stdenv;
  };

  sdk = callPackage ./sdk.nix {
    inherit toolchainName sdkName xcbuild toolchain;
  };

  platform = callPackage ./platform.nix {
    inherit sdk platformName xcbuild;
  };

  xcconfig = writeText "nix.xcconfig" ''
    SDKROOT=${sdkName}
  '';

in

stdenv.mkDerivation {
  name = "xcbuild-wrapper-${xcbuild.version}";

  buildInputs = [ xcbuild makeWrapper ];

  setupHook = ./setup-hook.sh;

  phases = [ "installPhase" "fixupPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cd $out/bin/

    for file in ${xcbuild}/bin/*; do
      ln -s $file
    done

    mkdir $out/usr
    ln -s $out/bin $out/usr/bin

    mkdir -p $out/Library/Xcode/
    ln -s ${xcbuild}/Library/Xcode/Specifications $out/Library/Xcode/Specifications

    mkdir -p $out/Platforms/
    ln -s ${platform} $out/Platforms/nixpkgs.platform

    mkdir -p $out/Toolchains/
    ln -s ${toolchain} $out/Toolchains/nixpkgs.xctoolchain
    ln -s $out/Toolchains/nixpkgs.xctoolchain \
          $out/Toolchains/XcodeDefault.xctoolchain

    ln -s $out $out/Developer

    wrapProgram $out/bin/xcodebuild \
      --add-flags "-xcconfig ${xcconfig}" \
      --add-flags "DERIVED_DATA_DIR=." \
      --set DEVELOPER_DIR "$out" \
      --set SDKROOT ${sdkName}
    wrapProgram $out/bin/xcrun \
      --set DEVELOPER_DIR "$out" \
      --set SDKROOT ${sdkName}
    wrapProgram $out/bin/xcode-select \
      --set DEVELOPER_DIR "$out" \
      --set SDKROOT ${sdkName}
  '';

  inherit (xcbuild) meta;

  passthru = {
    raw = xcbuild;
    inherit sdk;
  };

  preferLocalBuild = true;
}
