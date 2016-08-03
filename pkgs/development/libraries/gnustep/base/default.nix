{ mkDerivation, stdenv
, aspell, audiofile
, cups
, fetchurl
, gmp, gnutls
, libffi
, libjpeg, libtiff, libpng, giflib, libungif
, libxml2, libxslt, libiconv
, libobjc, libgcrypt
, icu
, pkgconfig, portaudio
}:

let
  version = "1.24.9";
in

mkDerivation {
  name = "gnustep-base-${version}";
  src = fetchurl {
    url = "ftp://ftp.gnustep.org/pub/gnustep/core/gnustep-base-${version}.tar.gz";
    sha256 = "1vvjlbqmlwr82b4pf8c62rxjgz475bmg0x2yd0bbkia6yvwhk585";
  };
  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [
    aspell audiofile
    gmp gnutls
    libffi
    libjpeg libtiff libpng giflib libungif
    libxml2 libxslt libiconv
    libgcrypt
    icu
    portaudio
  ] ++ stdenv.lib.optionals stdenv.isLinux [ cups ];
  patches = [ ./fixup-paths.patch ];
  meta = {
    description = "An implementation of AppKit and Foundation libraries of OPENSTEP and Cocoa";
  };
}
