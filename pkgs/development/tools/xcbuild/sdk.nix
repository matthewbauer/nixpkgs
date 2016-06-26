{ stdenv, writeText, toolchainName, platformName }:

let

SDKSettings = writeText "SDKSettings.plist" ''
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>CanonicalName</key>
<string>${platformName}</string>
<key>DisplayName</key>
<string>${platformName}</string>
<key>Toolchains</key>
<array>
<string>${toolchainName}</string>
</array>
<key>Version</key>
<string>10.9</string>
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
