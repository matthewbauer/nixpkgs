{ stdenv, callPackage, makeWrapper, writeText, CoreServices, cctools}:

let

  toolchainName = "com.apple.dt.toolchain.XcodeDefault";
  platformName = "com.apple.platform.macosx";
  sdkName = "macosx10.9";

  xcbuild = callPackage ./default.nix {
    inherit CoreServices;
  };

  toolchain = callPackage ./toolchain.nix {
    inherit cctools toolchainName;
    cc = stdenv.cc;
  };

  sdk = callPackage ./sdk.nix {
    inherit toolchainName sdkName;
  };

  platform = callPackage ./platform.nix {
    inherit sdk platformName;
  };

  developer = callPackage ./developer.nix {
    inherit platform toolchain;
  };

  xcconfig = writeText "nix.xcconfig" ''
SDKROOT=${sdkName}
  '';

in

stdenv.mkDerivation {
  name = "xcbuild-wrapper";

  buildInputs = [ xcbuild makeWrapper ];

  setupHook = ./setup-hook.sh;

  phases = [ "installPhase" "fixupPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cd $out/bin/

    for file in ${xcbuild}/bin/*; do
      ln -s $file
    done

    wrapProgram $out/bin/xcodebuild \
      --add-flags "-xcconfig ${xcconfig}" \
      --set DEVELOPER_DIR "${developer}"
  '';

  preferLocalBuild = true;
}
