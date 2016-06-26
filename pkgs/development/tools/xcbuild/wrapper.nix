{ stdenv, callPackage, makeWrapper, writeText, CoreServices, cctools, clang }:

let

  toolchainName = "nix.nixpkgs.toolchain";
  platformName = "nix.nixpkgs.sdk";

  xcbuild = callPackage ./default.nix {
    inherit CoreServices;
  };

  toolchain = callPackage ./toolchain.nix {
    inherit cctools toolchainName clang;
  };

  sdk = callPackage ./sdk.nix {
    inherit toolchainName platformName;
  };

  platform = callPackage ./platform.nix {
    inherit sdk platformName;
  };

  developer = callPackage ./developer.nix {
    inherit platform toolchain;
  };

  xcconfig = writeText "nix.xcconfig" ''
SDKROOT=${platformName}
#CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES=YES
#FRAMEWORK_SEARCH_PATHS=""
  '';

in

stdenv.mkDerivation {
  name = "xcbuild-wrapper";

  buildInputs = [ xcbuild makeWrapper ];

  setupHook = ./setup-hook.sh;

  phases = [ "installPhase" "fixupPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cd ${xcbuild}/bin
    makeWrapper ${xcbuild}/bin/xcodebuild $out/bin/xcodebuild \
      --add-flags "-xcconfig ${xcconfig}" \
      --set DEVELOPER_DIR "${developer}"
  '';

  meta = {
  };
}
