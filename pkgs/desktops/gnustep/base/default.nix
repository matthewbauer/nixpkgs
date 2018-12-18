{ aspell, audiofile, gsmakeDerivation, lib, fetchurl, gnutls, libffi
, libxml2, libxslt, libiconv, libobjc, icu, pkgconfig, stdenv, libbfd }:
gsmakeDerivation rec {
  pname = "base";
  version = "1.25.1";
  src = fetchurl {
    url = "ftp://ftp.gnustep.org/pub/gnustep/core/gnustep-base-${version}.tar.gz";
    sha256 = "17mnilg28by74wc08nkwp6gi06x3j2nrcf05wg64nrw5ljffp2zj";
  };
  nativeBuildInputs = [ pkgconfig ];
  propagatedBuildInputs = [ libobjc ];
  buildInputs = [ aspell gnutls libxml2 icu libffi libbfd libiconv libxslt ];
  patches = [ ./fixup-paths.patch ];
  meta = {
    description = "An implementation of AppKit and Foundation libraries of OPENSTEP and Cocoa";
  };
}
