{ stdenv, fetchFromGitHub, fetchpatch
, meson, ninja, pkgconfig, makeWrapper
, wlroots, wayland, wayland-protocols, pixman, libxkbcommon
, systemd, libGL, libX11, runtimeShell
, scdoc
, xwayland ? null
}:

stdenv.mkDerivation rec {
  pname = "cage";
  version = "0.1.2.1";

  src = fetchFromGitHub {
    owner = "matthewbauer";
    repo = "cage";
    rev = "9ac72a7d3f65922a90ef3896a5cebb002f96a1b3";
    sha256 = "13pqvp6c7gdysqx006l57mrbsrmllb6pk1p9jv8hmnks58m8lxdd";
  };

  nativeBuildInputs = [ meson ninja pkgconfig makeWrapper wayland scdoc ];

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
