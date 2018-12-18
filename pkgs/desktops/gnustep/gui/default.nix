{ gsmakeDerivation, fetchurl, base, libtiff, libjpeg, libpng
, libungif, aspell, cups, libicns, audiofile, portaudio }:
gsmakeDerivation rec {
  pname = "gui";
  version = "0.26.2";
  src = fetchurl {
    url = "ftp://ftp.gnustep.org/pub/gnustep/core/gnustep-gui-${version}.tar.gz";
    sha256 = "1dsbkifnjha3ghq8xx55bpsbbng0cjsni3yz71r7342ax2ixcvxc";
  };
  buildInputs = [
    base libtiff libjpeg libpng libungif aspell cups libicns audiofile portaudio
  ];
  patches = [ ./fixup-all.patch ];
  meta = {
    description = "A GUI class library of GNUstep";
  };
}
