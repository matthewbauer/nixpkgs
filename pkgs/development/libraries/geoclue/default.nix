{ stdenv, fetchFromGitLab, intltool, meson, ninja, pkgconfig, gtk-doc, docbook_xsl, docbook_xml_dtd_412, glib, json-glib, libsoup, libnotify, gdk-pixbuf
, modemmanager, avahi, glib-networking, python3, wrapGAppsHook, gobject-introspection, vala
, withDemoAgent ? false
, withModemManager ? stdenv.hostPlatform == stdenv.buildPlatform && !stdenv.hostPlatform.isDarwin
, withIntrospection ? stdenv.hostPlatform == stdenv.buildPlatform
, withDoc ? stdenv.hostPlatform == stdenv.buildPlatform
}:

with stdenv.lib;

stdenv.mkDerivation rec {
  pname = "geoclue";
  version = "2.5.6";

  src = fetchFromGitLab {
    domain = "gitlab.freedesktop.org";
    owner = pname;
    repo = pname;
    rev = version;
    sha256 = "13fk6n4j74lvcsrg3kwbw1mkxgcr3iy9dnysmy0pclfsym8z5m5m";
  };

  patches = [
    ./add-option-for-installation-sysconfdir.patch
  ];

  outputs = [ "out" "dev" ] ++ stdenv.lib.optional withDoc "devdoc";

  nativeBuildInputs = [
    pkgconfig intltool meson ninja wrapGAppsHook python3 vala
    glib
    # devdoc
  ] ++ optionals withDoc [ gtk-doc docbook_xsl docbook_xml_dtd_412 ]
    ++ optional withIntrospection gobject-introspection;

  depsBuildBuild = [ pkgconfig ];

  buildInputs = [
    glib json-glib libsoup avahi
  ] ++ optionals withDemoAgent [
    libnotify gdk-pixbuf
  ] ++ optionals withModemManager [ modemmanager ];

  propagatedBuildInputs = [ glib glib-networking ];

  mesonFlags = [
    "-Dsystemd-system-unit-dir=${placeholder "out"}/etc/systemd/system"
    "-Ddemo-agent=${if withDemoAgent then "true" else "false"}"
    "--sysconfdir=/etc"
    "-Dsysconfdir_install=${placeholder "out"}/etc"
    "-Ddbus-srv-user=geoclue"
    "-Ddbus-sys-dir=${placeholder "out"}/share/dbus-1/system.d"
  ] ++ optionals (!withModemManager) [
    "-D3g-source=false"
    "-Dcdma-source=false"
    "-Dmodem-gps-source=false"
    "-Dnmea-source=false"
  ] ++ optional (!withIntrospection) "-Dintrospection=false"
    ++ optional (!withDoc) "-Dgtk-doc=false";

  postPatch = ''
    chmod +x demo/install-file.py
    patchShebangs demo/install-file.py
  '';

  meta = with stdenv.lib; {
    description = "Geolocation framework and some data providers";
    homepage = "https://gitlab.freedesktop.org/geoclue/geoclue/wikis/home";
    maintainers = with maintainers; [ raskin ];
    platforms = with platforms; linux ++ darwin;
    license = licenses.lgpl2;
  };
}
