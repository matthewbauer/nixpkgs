{ callPackage, darwin, openssl_1_1_0 }:

let
  buildNodejs = callPackage ./nodejs.nix {
    inherit (darwin.apple_sdk.frameworks) CoreServices ApplicationServices;
  };
in rec {
  nodejs-6_x = callPackage ./v6.nix { inherit buildNodejs; };
  nodejs-slim-6_x = nodejs-6_x.override { enableNpm = false; };

  nodejs-8_x = callPackage ./v8.nix { inherit buildNodejs; };
  nodejs-slim-8_x = nodejs-8_x.override { enableNpm = false; };

  nodejs-9_x = callPackage ./v9.nix { inherit buildNodejs; };
  nodejs-slim-9_x = nodejs-slim-9_x.override { enableNpm = false; };

  nodejs-10_x = callPackage ./v10.nix {
    inherit buildNodejs;
    openssl = openssl_1_1_0;
  };
  nodejs-slim-10_x = nodejs-slim-9_x.override {
    enableNpm = false;
  };
}
