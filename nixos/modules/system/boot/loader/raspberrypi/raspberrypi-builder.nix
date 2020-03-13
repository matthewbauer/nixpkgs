{ pkgs, configTxt, raspberrypifw ? pkgs.raspberrypifw }:

pkgs.substituteAll {
  src = ./raspberrypi-builder.sh;
  isExecutable = true;
  inherit (pkgs.buildPackages) bash;
  path = [pkgs.buildPackages.coreutils pkgs.buildPackages.gnused pkgs.buildPackages.gnugrep];
  firmware = raspberrypifw;
  inherit configTxt;
}
