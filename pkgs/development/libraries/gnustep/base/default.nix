{ aspell, audiofile
, gsmakeDerivation
, cups
, fetchurl
, gmp, gnutls
, libffi
, libjpeg, libtiff, libpng, giflib, libungif
, libxml2, libxslt, libiconv
, libobjc2, libgcrypt
, icu
, pkgconfig, portaudio
}:
let
  version = "1.24.7";
in
gsmakeDerivation {
  name = "gnustep-base-${version}";
  src = fetchurl {
    url = "ftp://ftp.gnustep.org/pub/gnustep/core/gnustep-base-1.24.7.tar.gz";
    sha256 = "0qhphw61ksyzf04a4apmvx8000alws6d92x8ila1mi5bapcpv41s";
  };
  nativeBuildInputs = [ pkgconfig ];
  propagatedBuildInputs = [
    aspell audiofile
    cups
    gmp gnutls
    libffi
    libjpeg libtiff libpng giflib libungif
    libxml2 libxslt libiconv
    libobjc2 libgcrypt
    icu
    portaudio
  ];
  patches = [ ./fixup-paths.patch ];
  meta = {
    description = "GNUstep-base is an implementation of AppKit and Foundation libraries of OPENSTEP and Cocoa.";
  };
}
