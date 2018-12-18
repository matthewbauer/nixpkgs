{ back, base, gui, gsmakeDerivation, fetchurl }:
gsmakeDerivation rec {
  pname = "system_preferences";
  version = "1.2.0";
  src = fetchurl {
    url = "ftp://ftp.gnustep.org/pub/gnustep/usr-apps/SystemPreferences-${version}.tar.gz";
    sha256 = "1fg7c3ihfgvl6n21rd17fs9ivx3l8ps874m80vz86n1callgs339";
  };
  buildInputs = [ base back gui ];
  meta = {
    description = "The settings manager for the GNUstep environment and its applications";
  };
}
