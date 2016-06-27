{ stdenv, writeText, toolchainName, sdkName }:

let

SDKSettings = writeText "SDKSettings.plist" ''
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>CanonicalName</key>
<string>${sdkName}</string>
<key>DisplayName</key>
<string>${sdkName}</string>
<key>Toolchains</key>
<array>
<string>${toolchainName}</string>
</array>
<key>Version</key>
<string>10.9</string>
	<key>MaximumDeploymentTarget</key>
	<string>10.9</string>
	<key>MinimalDisplayName</key>
	<string>10.9</string>
	<key>MinimumSupportedToolsVersion</key>
	<string>3.2</string>
	<key>SupportedBuildToolComponents</key>
	<array>
		<string>com.apple.compilers.gcc.headers.4_2</string>
	</array>
	<key>isBaseSDK</key>
	<string>YES</string>
</dict>
</plist>
'';

SystemVersion = writeText "SystemVersion.plist" ''
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>ProductBuildVersion</key>
	<string>15E60</string>
	<key>ProductName</key>
	<string>Mac OS X</string>
	<key>ProductVersion</key>
	<string>10.9</string>
</dict>
</plist>
'';

in

stdenv.mkDerivation {
  name = "nix.nixpkgs.sdk";
  buildCommand = ''
    mkdir -p $out/
    cp ${SDKSettings} $out/SDKSettings.plist

    mkdir -p $out/System/Library/CoreServices/
    cp ${SystemVersion} $out/System/Library/CoreServices/SystemVersion.plist
  '';
}
