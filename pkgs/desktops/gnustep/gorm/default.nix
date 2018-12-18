{ fetchurl, base, back, gsmakeDerivation, gui }:
gsmakeDerivation rec {
  pname = "gorm";
  version = "1.2.23";

  src = fetchurl {
    url = "ftp://ftp.gnustep.org/pub/gnustep/dev-apps/gorm-${version}.tar.gz";
    sha256 = "18pf9vvzvdk8bg4lhjb96y1kdkmb9ahmvrqv2581vn45pjxmmlnb";
  };
  buildInputs = [ base back gui ];

  meta = {
    description = "Graphical Object Relationship Modeller is an easy-to-use interface designer for GNUstep";
  };
}
