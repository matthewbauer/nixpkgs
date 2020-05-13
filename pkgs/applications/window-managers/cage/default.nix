{ lib, stdenv, fetchFromGitHub
, meson, ninja, pkg-config, wayland, scdoc, makeWrapper
, wlroots, wayland-protocols, pixman, libxkbcommon
, systemd, libGL, libX11, mesa, runtimeShell
, xwayland ? null
, nixosTests
}:

stdenv.mkDerivation rec {
  pname = "cage";
  version = "0.1.4";

  src = fetchFromGitHub {
    owner = "matthewbauer";
    repo = "cage";
    rev = "f13d9b218c1de6958c177154e44852278b761e3f";
    sha256 = "16550h2pyckrkpjhm839i092yvy4kgbmxa6rvma763vf9iarp690";
  };

  depsBuildBuild = [ pkg-config ];

  nativeBuildInputs = [ meson ninja pkg-config makeWrapper wayland scdoc ];

  buildInputs = [
    wlroots wayland wayland-protocols pixman libxkbcommon
    mesa # for libEGL headers
    systemd libGL libX11
  ];

  mesonFlags = [ "-Dxwayland=${lib.boolToString (xwayland != null)}" ];

  postFixup = lib.optionalString (xwayland != null) ''
    wrapProgram $out/bin/cage --prefix PATH : "${xwayland}/bin"
    sed -i 's,${stdenv.shell},${runtimeShell},' $out/bin/cage
  '';

  # Tests Cage using the NixOS module by launching xterm:
  passthru.tests.basic-nixos-module-functionality = nixosTests.cage;

  meta = with lib; {
    description = "A Wayland kiosk that runs a single, maximized application";
    homepage    = "https://www.hjdskes.nl/projects/cage/";
    license     = licenses.mit;
    platforms   = platforms.linux;
    maintainers = with maintainers; [ primeos ];
  };
}
