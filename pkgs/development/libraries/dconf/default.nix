{ stdenv
, fetchurl
, fetchpatch
, meson
, ninja
, python3
, libxslt
, pkg-config
, glib
, bash-completion
, dbus
, gnome3
, libxml2
, docbook-xsl-nons
, docbook_xml_dtd_42
, enableVapi ? stdenv.hostPlatform == stdenv.buildPlatform, vala
, enableDoc ? stdenv.hostPlatform == stdenv.buildPlatform, gtk-doc
}:

stdenv.mkDerivation rec {
  pname = "dconf";
  version = "0.36.0";

  outputs = [ "out" "lib" "dev" ] ++ stdenv.lib.optional enableDoc "devdoc";

  src = fetchurl {
    url = "mirror://gnome/sources/${pname}/${stdenv.lib.versions.majorMinor version}/${pname}-${version}.tar.xz";
    sha256 = "0bfs069pjv6lhp7xrzmrhz3876ay2ryqxzc6mlva1hhz34ibprlz";
  };

  patches = [
    # Fix bash-completion installation
    # https://gitlab.gnome.org/GNOME/dconf/merge_requests/58
    (fetchpatch {
      url = "https://gitlab.gnome.org/GNOME/dconf/commit/b3c9423c6151f3c28e526083ea2f04987a780fdf.patch";
      sha256 = "zrIPKmgEpa1iIGUKv03+z+GNwJwgdf2hDATgP3i8qk0=";
    })
  ];

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    python3
    libxslt
    libxml2
    glib
    docbook-xsl-nons
    docbook_xml_dtd_42
  ] ++ stdenv.lib.optional enableVapi vala
    ++ stdenv.lib.optional enableDoc gtk-doc;

  buildInputs = [
    glib
    bash-completion
    dbus
  ];

  mesonFlags = [
    "--sysconfdir=/etc"
    "-Dgtk_doc=${if enableDoc then "true" else "false"}"
  ] ++ stdenv.lib.optional (!enableVapi) "-Dvapi=false";

  doCheck = !stdenv.isAarch32 && !stdenv.isAarch64 && !stdenv.isDarwin;

  postPatch = ''
    chmod +x meson_post_install.py tests/test-dconf.py
    patchShebangs meson_post_install.py
    patchShebangs tests/test-dconf.py
  '';

  passthru = {
    updateScript = gnome3.updateScript {
      packageName = pname;
    };
  };

  meta = with stdenv.lib; {
    homepage = "https://wiki.gnome.org/Projects/dconf";
    license = licenses.lgpl21Plus;
    platforms = platforms.unix;
    maintainers = teams.gnome.members;
  };
}
