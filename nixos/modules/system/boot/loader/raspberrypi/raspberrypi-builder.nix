{ pkgs, configTxt, raspberrypifw ? pkgs.raspberrypifw }:

pkgs.substituteAll {
  src = ./raspberrypi-builder.sh;
  isExecutable = true;
  inherit (pkgs) bash;
  path = with pkgs; [coreutils gnused gnugrep];
  firmware = raspberrypifw;
  inherit configTxt;
}
