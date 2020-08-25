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
    rev = "4e91062562174aeb396650f566e1f8c0c5e4340c";
    sha256 = "1g31qz0x0lrac5a8qvgvxignxkm54x9hhf74839r51qsc66dv83n";
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
    homepage    = "https://www.hjdskes.nl/projects/cage/";
    license     = licenses.mit;
    platforms   = platforms.linux;
    maintainers = with maintainers; [ primeos ];
  };
}
