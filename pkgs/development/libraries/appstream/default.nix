{ stdenv, fetchurl, cmake, pkgconfig, gettext, intltool
, xmlto, docbook_xsl, docbook_xml_dtd_45
, glib, xapian, libxml2, libyaml, gobjectIntrospection, itstool
}:

stdenv.mkDerivation {
  name = "appstream-0.10.6";

  src = fetchurl {
    url = "https://github.com/ximion/appstream/archive/APPSTREAM_0_10_6.tar.gz";
    sha256 = "0i4l9g4fj84yvlnygld05rlfidrb1zw2lwvmcgq4vnjy6xmgij6a";
  };

  nativeBuildInputs = [
    cmake pkgconfig gettext intltool
    xmlto docbook_xsl docbook_xml_dtd_45
    gobjectIntrospection
  ];

  buildInputs = [ glib xapian libxml2 libyaml itstool ];

  # todo: add libstemmer to nixpkgs
  cmakeFlags = [ "-DSTEMMING=NO" ];

  meta = with stdenv.lib; {
    description = "Software metadata handling library";
    homepage    = "http://www.freedesktop.org/wiki/Distributions/AppStream/Software/";
    longDescription =
    ''
      AppStream is a cross-distro effort for building Software-Center applications
      and enhancing metadata provided by software components.  It provides
      specifications for meta-information which is shipped by upstream projects and
      can be consumed by other software.
    '';
    license     = licenses.lgpl21Plus;
    platforms   = platforms.linux;
 };
}
