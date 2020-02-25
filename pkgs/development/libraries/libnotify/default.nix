{ stdenv
, fetchurl
, meson
, ninja
, pkgconfig
, libxslt
, docbook-xsl-ns
, glib
, gdk-pixbuf
, enableIntrospection ? stdenv.hostPlatform == stdenv.buildPlatform, gobject-introspection
, gnome3
}:

stdenv.mkDerivation rec {
  pname = "libnotify";
  version = "0.7.9";

  outputs = [ "out" "man" "dev" ];

  src = fetchurl {
    url = "mirror://gnome/sources/${pname}/${stdenv.lib.versions.majorMinor version}/${pname}-${version}.tar.xz";
    sha256 = "ZsBRftFt968ljoMgj6r1Bpcn39ZplcS7xRwWlU1nR2E=";
  };

  mesonFlags = [
    # disable tests as we don't need to depend on GTK (2/3)
    "-Dtests=false"
    "-Ddocbook_docs=disabled"
    "-Dgtk_doc=false"
  ] ++ stdenv.lib.optional (!enableIntrospection) "-Dintrospection=disabled";

  nativeBuildInputs = [
    meson
    ninja
    pkgconfig
    libxslt
    docbook-xsl-ns
    glib
  ] ++ stdenv.lib.optional enableIntrospection gobject-introspection;

  propagatedBuildInputs = [
    gdk-pixbuf
    glib
  ];

  passthru = {
    updateScript = gnome3.updateScript {
      packageName = pname;
      versionPolicy = "none";
    };
  };

  meta = with stdenv.lib; {
    homepage = "https://developer.gnome.org/notification-spec/";
    description = "A library that sends desktop notifications to a notification daemon";
    platforms = platforms.unix;
    maintainers = teams.gnome.members;
    license = licenses.lgpl21;
  };
}
