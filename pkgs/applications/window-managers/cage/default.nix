{ stdenv, fetchFromGitHub
, meson, ninja, pkg-config, wayland, scdoc, makeWrapper
, wlroots, wayland-protocols, pixman, libxkbcommon
, systemd, libGL, libX11
, xwayland ? null
, nixosTests
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

  depsBuildBuild = [ pkg-config ];

  nativeBuildInputs = [ meson ninja pkg-config makeWrapper wayland scdoc ];

  buildInputs = [
    wlroots wayland wayland-protocols pixman libxkbcommon
    systemd libGL libX11
  ];

  mesonFlags = [ "-Dxwayland=${stdenv.lib.boolToString (xwayland != null)}" ];

  postFixup = stdenv.lib.optionalString (xwayland != null) ''
    wrapProgram $out/bin/cage --prefix PATH : "${xwayland}/bin"
  '';

  # Tests Cage using the NixOS module by launching xterm:
  passthru.tests.basic-nixos-module-functionality = nixosTests.cage;

  meta = with stdenv.lib; {
    description = "A Wayland kiosk that runs a single, maximized application";
    homepage    = "https://www.hjdskes.nl/projects/cage/";
    license     = licenses.mit;
    platforms   = platforms.linux;
    maintainers = with maintainers; [ primeos ];
  };
}
