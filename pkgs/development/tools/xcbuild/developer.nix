{stdenv, platform, toolchain}:

stdenv.mkDerivation {
  name = "Xcode.app";
  buildCommand = ''
    mkdir -p $out/Contents/PlugIns/

    # IMPURE!!!
    cp -r /Applications/Xcode.app/Contents/PlugIns/Xcode3Core.ideplugin/ $out/Contents/PlugIns/

    mkdir -p $out/Contents/Developer/usr/bin/
    cd $out/Contents/Developer/usr/bin/

    # IMPURE!!!
    ln -s /Applications/Xcode.app/Contents/Developer/usr/bin/ibtool

    mkdir -p $out/Contents/Developer/Platforms/
    cd $out/Contents/Developer/Platforms/
    ln -s ${platform}

    mkdir -p $out/Contents/Developer/Toolchains/
    cd $out/Contents/Developer/Toolchains/
    ln -s ${toolchain}
  '';
}
