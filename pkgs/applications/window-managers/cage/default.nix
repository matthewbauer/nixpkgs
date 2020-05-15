{ stdenv, fetchFromGitHub, fetchpatch
, meson, ninja, pkgconfig, makeWrapper
, wlroots, wayland, wayland-protocols, pixman, libxkbcommon
, systemd, libGL, libX11, runtimeShell
, xwayland ? null
}:

stdenv.mkDerivation rec {
  pname = "cage-unstable";
  version = "2020-05-15";

  src = fetchFromGitHub {
    owner = "matthewbauer";
    repo = "cage";
    rev = "70ecdcb02ea073561c831ba23cbb0ad8853cfca9";
    sha256 = "0vafg5kj216b5nawld5qh6lpb1762x9jk246ag854njzmhn3dwz8";
  };

  nativeBuildInputs = [ meson ninja pkgconfig makeWrapper wayland ];

  buildInputs = [
    wlroots wayland wayland-protocols pixman libxkbcommon
    # TODO: Not specified but required:
    systemd libGL libX11
  ];

  enableParallelBuilding = true;

  mesonFlags = [ "-Dxwayland=${stdenv.lib.boolToString (xwayland != null)}" ];

  postFixup = stdenv.lib.optionalString (xwayland != null) ''
    wrapProgram $out/bin/cage --prefix PATH : "${xwayland}/bin"
    sed -i 's,${stdenv.shell},${runtimeShell},' $out/bin/cage
  '';

  meta = with stdenv.lib; {
    description = "A Wayland kiosk";
    homepage    = https://www.hjdskes.nl/projects/cage/;
    license     = licenses.mit;
    platforms   = platforms.linux;
    maintainers = with maintainers; [ primeos ];
  };
}
