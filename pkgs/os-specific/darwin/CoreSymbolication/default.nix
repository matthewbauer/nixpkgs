{ fetchFromGitHub, stdenv }:

# Reverse engineered CoreSymbolication to make dtrace buildable

stdenv.mkDerivation rec {
  name = "CoreSymbolication";

  src = fetchFromGitHub {
    repo = name;
    owner = "matthewbauer";
    rev = "24c87c23664b3ee05dc7a5a87d647ae476a680e4";
    sha256 = "08dm3d55gpizi4xx5b15lc7nwg1kkk11iw5jzbs16dhyvsmwnfrz";
  };

  makeFlags = [ "PREFIX=$(out)" "CFLAGS=-fblocks" ];
}
