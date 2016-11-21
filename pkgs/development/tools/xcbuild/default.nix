{ stdenv, cmake, fetchFromGitHub, zlib, libxml2, libpng, CoreServices, CoreGraphics, ImageIO, ninja }:

let
  googletest = fetchFromGitHub {
    owner  = "google";
    repo   = "googletest";
    rev    = "43359642a1c16ad3f4fc575c7edd0cb935810815";
    sha256 = "0y4xaah62fjr3isaryc3vfz3mn9xflr00vchdimj8785milxga4q";
  };

  linenoise = fetchFromGitHub {
    owner  = "antirez";
    repo   = "linenoise";
    rev    = "c894b9e59f02203dbe4e2be657572cf88c4230c3";
    sha256 = "0wasql7ph5g473zxhc2z47z3pjp42q0dsn4gpijwzbxawid71b4w";
  };
in stdenv.mkDerivation rec {
  name    = "xcbuild-${stdenv.lib.substring 0 8 version}";
  version = "157e4a2cde365cc32845eb766d6da0e34d935157";

  src = fetchFromGitHub {
    owner  = "facebook";
    repo   = "xcbuild";
    rev    = version;
    sha256 = "0cp23rxp4dclpz3f9nqfflz6x93x7wvvikvi9h153z39fpazsyb2";
  };

  prePatch = ''
    rmdir ThirdParty/*
    cp -r --no-preserve=all ${googletest} ThirdParty/googletest
    cp -r --no-preserve=all ${linenoise} ThirdParty/linenoise
  '';

  enableParallelBuilding = true;

  # TODO: instruct cmake not to put it in /usr, rather than cleaning up
  postInstall = ''
    mv $out/usr/* $out
    rmdir $out/usr
  '';

  buildInputs = [ cmake zlib libxml2 libpng ninja ]
    ++ stdenv.lib.optionals stdenv.isDarwin [ CoreServices CoreGraphics ImageIO ];
}
