{ stdenv, runCommand, callPackage, makeWrapper, writeText
, CoreServices, ImageIO, CoreGraphics
, cctools, bootstrap_cmds, binutils
, buildPackages }:

let

  toolchainName = "com.apple.dt.toolchain.XcodeDefault";
  platformName = "com.apple.platform.macosx";
  sdkName = "macosx10.10";

  xcbuild = callPackage ./default.nix {
    inherit CoreServices ImageIO CoreGraphics;
  };

  toolchain = callPackage ./toolchain.nix {
    inherit bootstrap_cmds toolchainName xcbuild runCommand;
    inherit (buildPackages.darwin) cctools;
    inherit (buildPackages) stdenv binutils;
  };

  sdk = callPackage ./sdk.nix {
    inherit toolchainName sdkName xcbuild;
  };

  platform = callPackage ./platform.nix {
    inherit sdk platformName xcbuild;
  };

  xcconfig = writeText "nix.xcconfig" ''
    SDKROOT=${sdkName}
  '';

in

runCommand "xcbuild-wrapper-${xcbuild.version}" {
  buildInputs = [ xcbuild makeWrapper ];

  setupHook = ./setup-hook.sh;

  inherit (xcbuild) meta;

  passthru = {
    raw = xcbuild;
  };

  preferLocalBuild = true;
} ''
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
''
