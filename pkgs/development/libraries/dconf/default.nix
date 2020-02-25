{ stdenv, fetchurl, meson, ninja, python3, libxslt, pkgconfig, glib, bash-completion, dbus, gnome3
, libxml2, docbook_xsl, docbook_xml_dtd_42, fetchpatch
, enableVapi ? stdenv.hostPlatform == stdenv.buildPlatform, vala
, enableDoc ? stdenv.hostPlatform == stdenv.buildPlatform, gtk-doc }:

let
  pname = "dconf";
in
stdenv.mkDerivation rec {
  name = "${pname}-${version}";
  version = "0.36.0";

  src = fetchurl {
    url = "mirror://gnome/sources/${pname}/${stdenv.lib.versions.majorMinor version}/${name}.tar.xz";
    sha256 = "0bfs069pjv6lhp7xrzmrhz3876ay2ryqxzc6mlva1hhz34ibprlz";
  };

  postPatch = ''
    chmod +x meson_post_install.py tests/test-dconf.py
    patchShebangs meson_post_install.py
    patchShebangs tests/test-dconf.py
  '';

  outputs = [ "out" "lib" "dev" ] ++ stdenv.lib.optional enableDoc "devdoc";

  nativeBuildInputs = [ meson ninja pkgconfig python3 libxslt libxml2 glib docbook_xsl docbook_xml_dtd_42 ]
    ++ stdenv.lib.optional enableVapi vala
    ++ stdenv.lib.optional enableDoc gtk-doc;
  buildInputs = [ glib bash-completion dbus ];

  mesonFlags = [
    "--sysconfdir=/etc"
    "-Dgtk_doc=${if enableDoc then "true" else "false"}"
  ] ++ stdenv.lib.optional (!enableVapi) "-Dvapi=false";

  doCheck = !stdenv.isAarch32 && !stdenv.isAarch64 && !stdenv.isDarwin;

  passthru = {
    updateScript = gnome3.updateScript {
      packageName = pname;
    };
  };

  meta = with stdenv.lib; {
    homepage = https://wiki.gnome.org/Projects/dconf;
    license = licenses.lgpl21Plus;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = gnome3.maintainers;
  };
}
