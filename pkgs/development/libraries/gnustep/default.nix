{ pkgs, newScope }:

let
  callPackage = newScope self;

  self = rec {
    stdenv = pkgs.clangStdenv;
    mkDerivation = callPackage ./make/gsmakeDerivation.nix {};

    libobjc = callPackage ./libobjc2 {};
    gorm = callPackage ./gorm {};
    projectcenter = callPackage ./projectcenter {};
    system_preferences = callPackage ./systempreferences {};
    make = callPackage ./make {};
    back = callPackage ./back {};
    base = callPackage ./base { giflib = pkgs.giflib_4_1; };
    gui = callPackage ./gui {};
    gworkspace = callPackage ./gworkspace {};
  };

in self
