{ mkDerivation, fetchurl, back, base, gui}:

let
  version = "1.1.0";
in

mkDerivation {
  name = "system_preferences-${version}";
  src = fetchurl {
    url = "ftp://ftp.gnustep.org/pub/gnustep/usr-apps/SystemPreferences-${version}.tar.gz";
    sha256 = "1q68bs8rlq0dxkar01qs5wfyas4iivddnama371jd7ll6cxzmpy7";
  };
  buildInputs = [ back base gui ];
  meta = {
    description = "The settings manager for the GNUstep environment and its applications";
  };
}
