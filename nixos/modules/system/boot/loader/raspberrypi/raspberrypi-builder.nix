{ pkgs, configTxt, raspberrypifw ? pkgs.raspberrypifw }:

pkgs.substituteAll {
  src = ./raspberrypi-builder.sh;
  isExecutable = true;
  inherit (pkgs) bash;
  path = [pkgs.coreutils pkgs.gnused pkgs.gnugrep];
  firmware = raspberrypifw;
  inherit configTxt;
}
