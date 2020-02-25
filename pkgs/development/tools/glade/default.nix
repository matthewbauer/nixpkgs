{ stdenv
, gettext
, fetchurl
, pkg-config
, gtk3
, glib
, wrapGAppsHook
, itstool
, libxml2
, docbook-xsl-nons
, gnome3
, gdk-pixbuf
, libxslt
, gsettings-desktop-schemas
, enableIntrospection ? stdenv.hostPlatform == stdenv.buildPlatform, gobject-introspection
, enablePython ? stdenv.hostPlatform == stdenv.buildPlatform, python3
}:

stdenv.mkDerivation rec {
  pname = "glade";
  version = "3.36.0";

  src = fetchurl {
    url = "mirror://gnome/sources/glade/${stdenv.lib.versions.majorMinor version}/${pname}-${version}.tar.xz";
    sha256 = "023gx8rj51njn8fsb6ma5kz1irjpxi4js0n8rwy22inc4ysldd8r";
  };

  configureFlags =
       stdenv.lib.optional (!enablePython) "--disable-python"
    ++ stdenv.lib.optional (!enableIntrospection) "--disable-introspection";

  nativeBuildInputs = [
    pkg-config
    gettext
    itstool
    wrapGAppsHook
    docbook-xsl-nons
    libxslt
    libxml2
  ] ++ stdenv.lib.optional enableIntrospection gobject-introspection;

  buildInputs = [
    gtk3
    glib
    libxml2
    gsettings-desktop-schemas
    gdk-pixbuf
    gnome3.adwaita-icon-theme
  ] ++ stdenv.lib.optionals enablePython [ python3 python3.pkgs.pygobject3 ];

  enableParallelBuilding = true;

  passthru = {
    updateScript = gnome3.updateScript {
      packageName = pname;
    };
  };

  meta = with stdenv.lib; {
    homepage = "https://wiki.gnome.org/Apps/Glade";
    description = "User interface designer for GTK applications";
    maintainers = teams.gnome.members;
    license = licenses.lgpl2;
    platforms = platforms.linux;
  };
}
