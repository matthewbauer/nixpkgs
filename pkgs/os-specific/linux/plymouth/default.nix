{ stdenv, fetchFromGitLab
, pkgconfig, autoreconfHook, libxslt, docbook_xsl, intltool
, gtk3, udev, systemd
, withLabelFt ? true, freetype ? null
}:

assert withLabelFt -> freetype != null;

stdenv.mkDerivation rec {
  pname = "plymouth";
  version = "2020-04-07";

  src = fetchFromGitLab {
    domain = "gitlab.freedesktop.org";
    owner = "plymouth";
    repo = "plymouth";
    rev = "6ca4b5b24d02242e85a3a5a4727aa195d4008210";
    sha256 = "1l25wqr6wwbiy7ivnl766prj1ndfc9xdprw9ya7i67yhrdi429cz";
  };

  nativeBuildInputs = [
    pkgconfig autoreconfHook
    libxslt docbook_xsl intltool
  ];

  buildInputs = [
    gtk3 udev systemd freetype
  ];

  patches = [
    # https://build.opensuse.org/package/show/openSUSE%3AFactory/plymouth
    ./manpages.patch
    # ./only_use_fb_for_cirrus_bochs.patch
  ] ++ stdenv.lib.optionals withLabelFt [
    # https://gitlab.freedesktop.org/plymouth/plymouth/-/issues/45
    ./v3-0001-ply-label-Don-t-crash-if-label-plugin-fails.patch
    ./v3-0002-Add-label-ft-plugin.patch
    ./v3-0004-Add-HiDPI-support-to-label-ft-plugin.patch
  ];

  postPatch = ''
    sed -i \
      -e "s#plymouththemedir=.*#plymouththemedir=/etc/plymouth/themes#" \
      -e "s#plymouthplugindir=.*#plymouthplugindir=/etc/plymouth/plugins/#" \
      -e "s#plymouthpolicydir=.*#plymouthpolicydir=/etc/plymouth/#" \
      -e "s#plymouthconfdir=.*#plymouthconfdir=/etc/plymouth/#" \
      configure.ac

    sed -i "s#%{_localstatedir}/run/plymouth#%{_plymouthruntimedir}#" scripts/plymouth.spec
    sed -i "s#plymouthdrundir = .*#plymouthdrundir = \$(plymouthruntimedir)#" src/Makefile.am
  '' + stdenv.lib.optionals withLabelFt ''
    sed -i \
      -e "s@/usr/share@/etc@" \
      -e "s@/usr/bin/fc-match@fc-match@" \
      src/plugins/controls/label-ft/plugin.c
  '';

  configurePlatforms = [ "host" ];

  configureFlags = [
    "--localstatedir=/var"
    "--with-runtimedir=/run"
    "--with-systemdunitdir=${placeholder "out"}/etc/systemd/system"

    "--with-logo=/etc/plymouth/logo.png"
    "--with-release-file=/etc/os-release"

    "--with-background-color=0x000000"
    "--with-background-start-color-stop=0x000000"
    "--with-background-end-color-stop=0x000000"

    "--without-rhgb-compat-link"
    "--without-system-root-install"

    "--enable-drm"
    "--enable-gtk"
    "--enable-pango"
    "--enable-tracing"
    "--enable-freetype"
    "--enable-documentation"
    "--enable-systemd-integration"
  ];

  installFlags = [
    "plymouthd_defaultsdir=$(out)/share/plymouth"
    "plymouthd_confdir=$(out)/etc/plymouth"
  ];

  meta = with stdenv.lib; {
    homepage = https://www.freedesktop.org/wiki/Software/Plymouth/;
    description = "Boot splash and boot logger";
    license = licenses.gpl2;
    maintainers = [ maintainers.goibhniu ];
    platforms = platforms.linux;
  };
}
