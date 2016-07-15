{ gsmakeDerivation
, cairo
, fetchurl
, base, gui
, xlibs
, x11
, freetype
, pkgconfig
}:
let
  version = "0.24.0";
in
gsmakeDerivation {
  name = "gnustep-back-${version}";
  src = fetchurl {
    url = "ftp://ftp.gnustep.org/pub/gnustep/core/gnustep-back-0.24.0.tar.gz";
    sha256 = "0qixbilkkrqxrhhj9hnp7ygd5gs23b3qbbgk3gaxj73d0xqfvhjz";
  };
  buildInputs = [ cairo base gui freetype pkgconfig x11 ];
  meta = {
    description = "GNUstep-back is a generic backend for GNUstep.";
  };
}
