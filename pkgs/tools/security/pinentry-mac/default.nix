{ fetchurl, stdenv, xcbuild }:

stdenv.mkDerivation rec {
  name = "pinentry-mac-0.9.4";

  src = fetchurl {
    url = "https://github.com/GPGTools/pinentry-mac/archive/v0.9.4.tar.gz";
    sha256 = "037ebb010377d3a3879ae2a832cefc4513f5c397d7d887d7b86b4e5d9a628271";
  };

  installPhase = ''
    mkdir -p $out/Applications
    mv build/Release/pinentry-mac.app $out/Applications
  '';

  buildInputs = [ xcbuild ];

  meta = {
    description = "Pinentry for GPG on Mac";
    license = stdenv.lib.licenses.gpl2Plus;
    homepage = "https://github.com/GPGTools/pinentry-mac";
    platforms = stdenv.lib.platforms.darwin;
  };
}
