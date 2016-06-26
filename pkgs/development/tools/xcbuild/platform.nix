{stdenv, sdk, writeText, platformName}:

let

Info = writeText "Info.plist" ''
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>Identifier</key>
<string>${platformName}</string>
<key>Name</key>
<string>${platformName}</string>
<key>Version</key>
<string>1.1</string>
<key>DefaultProperties</key>
<dict>
<key>DEFAULT_COMPILER</key>
<string>com.apple.compilers.llvm.clang.1_0</string>
<key>DEPLOYMENT_TARGET_CLANG_ENV_NAME</key>
<string>MACOSX_DEPLOYMENT_TARGET</string>
<key>DEPLOYMENT_TARGET_CLANG_FLAG_NAME</key>
<string>mmacosx-version-min</string>
<key>DEPLOYMENT_TARGET_SETTING_NAME</key>
<string>MACOSX_DEPLOYMENT_TARGET</string>
<key>EMBEDDED_PROFILE_NAME</key>
<string>embedded.provisionprofile</string>
</dict>
<key>DTCompiler</key>
<string>com.apple.compilers.llvm.clang.1_0</string>
</dict>
</plist>
'';

Version = writeText "version.plist" ''
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>BuildVersion</key>
<string>1</string>
<key>CFBundleShortVersionString</key>
<string>1.1</string>
<key>CFBundleVersion</key>
<string>10010</string>
<key>ProjectName</key>
<string>OSXPlatformSupport</string>
<key>SourceVersion</key>
<string>10010000000000000</string>
</dict>
</plist>
'';

in

stdenv.mkDerivation {
  name = "nixpkgs.platform";
  buildCommand = ''
    mkdir -p $out/
    cd $out/
    cp ${Info} ./Info.plist
    cp ${Version} ./version.plist

    mkdir -p $out/Developer/Library/Xcode/Specifications/

    # IMPURE!!!
    cp /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/Library/Xcode/Specifications/*.xcspec $out/Developer/Library/Xcode/Specifications/

    mkdir -p $out/Developer/SDKs/
    cd $out/Developer/SDKs/
    ln -s ${sdk}
  '';
}
