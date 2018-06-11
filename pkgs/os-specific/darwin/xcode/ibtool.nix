{ runCommand, xcode, lib }:

runCommand "ibtool" {
  meta = with lib; {
    homepage = https://developer.apple.com/downloads/;
    description = "Apple's Interface Builder Toolx";
    license = licenses.unfree;
    platforms = platforms.darwin;
  };
} ''
  install -D ${xcode}/Contents/Developer/usr/bin/ibtool $out/bin/ibtool
''
