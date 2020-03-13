{ pkgs, configTxt }:

pkgs.substituteAll {
  src = ./raspberrypi-builder.sh;
  isExecutable = true;
  inherit (pkgs.buildPackages) bash;
  path = [pkgs.buildPackages.coreutils pkgs.buildPackages.gnused pkgs.buildPackages.gnugrep];
  firmware = pkgs.raspberrypifw;
  inherit configTxt;
}
