{ stdenv, fetchFromGitHub, lib
, intltool, glib, pkgconfig, polkit, python3, sqlite
, gobject-introspection, vala, gtk-doc
, nix, boost, meson, ninja, nlohmann_json
, libxslt, libxml2, gst_all_1, gtk3
, enableCommandNotFound ? false
, enableBashCompletion ? false, bash-completion ? null
, enableSystemd ? stdenv.isLinux, systemd }:

stdenv.mkDerivation rec {
  pname = "packagekit";
  version = "1.2.0";

  outputs = [ "out" "dev" ];

  src = fetchFromGitHub {
    owner = "matthewbauer";
    repo = "PackageKit";
    rev = "268db6315c71ae106d5e865f7b6d4e5bb281b336";
    sha256 = "161bvr8q6in48mba7s0yvg77pyr8vzfyvg1fcnmbbz5qicq1f5ki";
  };

  buildInputs = [
    glib
    polkit
    python3
    gobject-introspection
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gtk3
    nlohmann_json
  ] ++ lib.optional enableSystemd systemd
    ++ lib.optional enableBashCompletion bash-completion;
  propagatedBuildInputs = [
    sqlite
    boost
    nix
  ];
  nativeBuildInputs = [
    vala
    intltool
    pkgconfig
    gtk-doc
    meson
    libxslt
    libxml2
    ninja
  ];

  mesonFlags = [
    (if enableSystemd then "-Dsystemd=true" else "-Dsystem=false")
    "-Dpackaging_backend=nix"
    "-Ddbus_sys=${placeholder "out"}/share/dbus-1/system.d"
    "-Ddbus_services=${placeholder "out"}/share/dbus-1/system-services"
    "-Dsystemdsystemunitdir=${placeholder "out"}/lib/systemd/system"
    "-Dcron=false"
    "-Dman_pages=false"
  ]
  ++ lib.optional (!enableBashCompletion) "-Dbash_completion=false"
  ++ lib.optional (!enableCommandNotFound) "-Dbash_command_not_found=false";

  enableParallelBuilding = true;

  installFlags = [
    "sysconfdir=${placeholder "out"}/etc"
    "localstatedir=\${TMPDIR}"
  ];

  meta = with lib; {
    description = "System to facilitate installing and updating packages";
    longDescription = ''
      PackageKit is a system designed to make installing and updating software
      on your computer easier. The primary design goal is to unify all the
      software graphical tools used in different distributions, and use some of
      the latest technology like PolicyKit. The actual nuts-and-bolts distro
      tool (dnf, apt, etc) is used by PackageKit using compiled and scripted
      helpers. PackageKit isn't meant to replace these tools, instead providing
      a common set of abstractions that can be used by standard GUI and text
      mode package managers.
    '';
    homepage = "http://www.packagekit.org/";
    license = licenses.gpl2Plus;
    platforms = platforms.unix;
    maintainers = with maintainers; [ matthewbauer ];
  };
}
