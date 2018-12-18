{ back, base, gui, gsmakeDerivation, fetchurl, system_preferences }:
gsmakeDerivation rec {
  pname = "gworkspace";
  version = "0.9.4";
  src = fetchurl {
    url = "ftp://ftp.gnustep.org/pub/gnustep/usr-apps/gworkspace-${version}.tar.gz";
    sha256 = "0cjn83m7qmbwdpldlyhs239nwswgip3yaz01ahls130dq5qq7hgk";
  };
  buildInputs = [ back base gui system_preferences ];
  configureFlags = [ "--with-inotify" ];
  meta = {
    description = "A workspace manager for GNUstep";
  };
}
