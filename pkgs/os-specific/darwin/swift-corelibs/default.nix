{ newScope, darwin }:

let
  callPackage = newScope (packages // darwin);

  packages = rec {
    corefoundation = callPackage ./corefoundation.nix {};
    libdispatch = callPackage ./libdispatch.nix {
      xnu = darwin.xnu-full.override { headersOnly = true; };
    };
  };

in packages
