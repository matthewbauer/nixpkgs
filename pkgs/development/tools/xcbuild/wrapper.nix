{ stdenv, buildPackages, makeWrapper, writeText, runCommand
, CoreServices, ImageIO, CoreGraphics }:

let

  toolchainName = "com.apple.dt.toolchain.XcodeDefault";
  platformName = "com.apple.platform.macosx";
  sdkName = "macosx10.10";

  xcbuild = buildPackages.callPackage ./default.nix {
    inherit CoreServices ImageIO CoreGraphics;
  };

  toolchains = buildPackages.callPackage ./toolchains.nix {
    inherit toolchainName;
  };

  sdks = buildPackages.callPackage ./sdks.nix {
    inherit toolchainName sdkName;
  };

  platforms = buildPackages.callPackage ./platforms.nix {
    inherit sdks platformName;
  };

  xcconfig = writeText "nix.xcconfig" ''
    SDKROOT=${sdkName}
  '';

  xcode-select = writeText "xcode-select" ''
#!/usr/bin/env sh
for arg in "$@"; do
    case "$1" in
         -h | --help) ;; # noop
         -s | --switch) shift;; # noop
         -r | --reset) ;; # noop
         -v | --version) echo xcode-select version 2349. ;;
         -p | --print-path) echo @DEVELOPER_DIR@;;
         --install) ;; # noop
    esac
    shift
done
  '';

  xcrun = writeText "xcrun" ''
#!/usr/bin/env sh
for arg in "$@"; do
    case "$1" in
         -sdk | --sdk) shift ;; # noop
         -find | --find) shift; command -v $1; break;;
         -log | --log) ;; # noop
         -verbose | --verbose) ;; # noop
         -no-cache | --no-cache) ;; # noop
         -kill-cache | --kill-cache) ;; # noop
         -show-sdk-path | --show-sdk-path) echo @SDK_PATH@; return ;;
         -show-sdk-platform-path | --show-sdk-platform-path) echo @SDK_PLATFORM_PATH@; return ;;
         *) break ;;
    esac
    shift
done
if ! [[ -z "$@" ]]; then
   echo running "$@"
   exec "$@"
fi
  '';

in

stdenv.mkDerivation {
  name = "xcbuild-wrapper-${xcbuild.version}";

  nativeBuildInputs = [ makeWrapper ];

  phases = [ "installPhase" "fixupPhase" ];

  installPhase = ''
    mkdir -p $out/bin

    mkdir -p $out/usr
    ln -s $out/bin $out/usr/bin

    mkdir -p $out/Library/Xcode
    ln -s ${xcbuild}/Library/Xcode/Specifications $out/Library/Xcode/Specifications

    ln -s ${platforms} $out/Platforms
    ln -s ${toolchains} $out/Toolchains

    makeWrapper ${xcbuild}/bin/xcodebuild $out/bin/xcodebuild \
      --add-flags "-xcconfig ${xcconfig}" \
      --add-flags "DERIVED_DATA_DIR=." \
      --set DEVELOPER_DIR "$out" \
      --set SDKROOT ${sdkName}

    substitute ${xcode-select} $out/bin/xcode-select \
      --subst-var-by DEVELOPER_DIR $out
    chmod +x $out/bin/xcode-select

    substitute ${xcrun} $out/bin/xcrun \
      --subst-var-by SDK_PATH $out \
      --subst-var-by SDK_PLATFORM_PATH $out/Platforms/nixpkgs.platform
    chmod +x $out/bin/xcrun

    for bin in PlistBuddy actool builtin-copy builtin-copyPlist \
               builtin-copyStrings builtin-copyTiff \
               builtin-embeddedBinaryValidationUtility \
               builtin-infoPlistUtility builtin-lsRegisterURL \
               builtin-productPackagingUtility builtin-validationUtility \
               lsbom plutil; do
      ln -s ${xcbuild}/bin/$bin $out/bin/$bin
    done
  '';

  inherit (xcbuild) meta;

  passthru = {
    raw = xcbuild;
  };

  preferLocalBuild = true;
}
