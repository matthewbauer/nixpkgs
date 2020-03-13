{ pkgs, configTxt, raspberrypifw ? pkgs.raspberrypifw }:

pkgs.substituteAll {
  src = ./raspberrypi-builder.sh;
  isExecutable = true;
  inherit (pkgs.buildPackages) bash;
  path = with pkgs.buildPackages; [coreutils gnused gnugrep];
  firmware = raspberrypifw;
  inherit configTxt;
}
