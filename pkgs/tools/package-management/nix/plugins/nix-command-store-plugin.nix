{ stdenv, fetchFromGitHub, nix, pkgconfig, cmake, boost }:

let version = "0.0.1";
in stdenv.mkDerivation {
  name = "nix-command-store-plugin-${version}";
  nativeBuildInputs = [  pkgconfig cmake ];
  buildInputs = [ nix boost ];
  src = fetchFromGitHub {
    owner = "puffnfresh";
    repo = "nix-command-store-plugin";
    rev = "v${version}";
    sha256 = "1k86avz1vqya9ya6l7dnschfa4fsqhdhcham764cqzp9qg1dzj0g";
  };

  meta = with stdenv.lib; {
    description = "Nix 2.0 plugin to create a command:// store.";
    homepage = "https://github.com/puffnfresh/nix-command-store-plugin";
    license = licenses.lgpl;
    platforms = platforms.unix;
  };
}
