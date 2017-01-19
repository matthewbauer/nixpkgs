{ stdenv, fetchFromGitHub, lib
, intltool, glib, pkgconfig, polkit, python, sqlite, systemd
, gobjectIntrospection, vala_0_23, gtk_doc, autoreconfHook, autoconf-archive
# TODO: set enableNixBackend to true, as soon as it builds
, nix, enableNixBackend ? true, boost
, enableCommandNotFound ? false
, enableBashCompletion ? false, bash-completion ? null }:

stdenv.mkDerivation rec {
  name = "packagekit-${version}";
  version = "194f132";

  src = fetchFromGitHub {
    owner = "matthewbauer";
    repo = "PackageKit";
    rev = "88154a650c147c2c91f57c72cbe09d9c91f92c47";
    sha256 = "0rrj5z3isqk5h51icywyarm8lssgwp3lwx1jfzs37g6m839977q0";
  };

  buildInputs = [ glib polkit systemd python gobjectIntrospection vala_0_23 ]
                  ++ lib.optional enableBashCompletion bash-completion;
  propagatedBuildInputs = [ sqlite nix.dev boost ];
  nativeBuildInputs = [ intltool pkgconfig autoreconfHook autoconf-archive gtk_doc ];

  preAutoreconf = ''
    gtkdocize
    intltoolize
  '';

  configureFlags = [
    "--enable-systemd"
    "--disable-dummy"
    "--disable-cron"
    "--disable-introspection"
    "--disable-offline-update"
    "--localstatedir=/var"
    "--sysconfdir=/etc"
    "--with-dbus-sys=$(out)/etc/dbus-1/system.d"
    "--with-systemdsystemunitdir=$(out)/lib/systemd/system/"
  ]
  ++ lib.optional enableNixBackend "--enable-nix"
  ++ lib.optional (!enableBashCompletion) "--disable-bash-completion"
  ++ lib.optional (!enableCommandNotFound) "--disable-command-not-found";

  enableParallelBuilding = true;

  installFlags = [
    "sysconfdir=\${out}/etc"
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
    homepage = http://www.packagekit.org/;
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ nckx matthewbauer ];
  };
}
