{ runCommand, lib, toolchainName, sdkName, writeText }:

let
  inherit (lib.generators) toPlist;

  # TODO: expose MACOSX_DEPLOYMENT_TARGET in nix so we can use it here.
  version = "10.10";

  SDKSettings = {
    CanonicalName = sdkName;
    DisplayName = sdkName;
    Toolchains = [ toolchainName ];
    Version = version;
    MaximumDeploymentTarget = version;
    isBaseSDK = "YES";
  };

  SystemVersion = {
    ProductName = "Mac OS X";
    ProductVersion = version;
  };
in

runCommand "SDKs" {
  inherit version;
} ''
  sdk=$out/MacOSX.sdk
  install -D ${writeText "SDKSettings.plist" (toPlist {} SDKSettings)} $sdk/SDKSettings.plist
  install -D ${writeText "SystemVersion.plist" (toPlist {} SystemVersion)} $sdk/System/Library/CoreServices/SystemVersion.plist
  ln -s $sdk $out/MacOSX${version}.sdk
''
