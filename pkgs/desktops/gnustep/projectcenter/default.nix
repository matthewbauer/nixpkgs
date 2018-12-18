{ fetchurl, base, back, gsmakeDerivation, gui, gorm }:
gsmakeDerivation rec {
  pname = "projectcenter";
  version = "0.6.2";
  src = fetchurl {
    url = "ftp://ftp.gnustep.org/pub/gnustep/dev-apps/ProjectCenter-${version}.tar.gz";
    sha256 = "0wwlbpqf541apw192jb633d634zkpjhcrrkd1j80y9hihphll465";
  };

  buildInputs = [ base back gui gorm ];

  meta = {
    description = "GNUstep's integrated development environment";
  };
}
