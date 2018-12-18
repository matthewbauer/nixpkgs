{ gsmakeDerivation, cairo, fetchurl, base, gui, xlibsWrapper, freetype
, pkgconfig, libXmu }:
gsmakeDerivation rec {
  pname = "back";
  version = "0.26.2";
  src = fetchurl {
    url = "ftp://ftp.gnustep.org/pub/gnustep/core/gnustep-back-${version}.tar.gz";
    sha256 = "012gsc7x66gmsw6r5w65a64krcigf7rzqzd5x86d4gv94344knlf";
  };
  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ cairo base gui freetype xlibsWrapper libXmu ];
  meta = {
    description = "A generic backend for GNUstep";
  };
}
