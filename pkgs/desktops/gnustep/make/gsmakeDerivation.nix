{ stdenv, lib, make, makeWrapper, which }:

{ nativeBuildInputs ? [], ...} @ args:

stdenv.mkDerivation (args // {
  name = "gnustep-${args.pname}-${args.version}";

  nativeBuildInputs = [ makeWrapper make which ] ++ nativeBuildInputs;

  builder = ./builder.sh;
  setupHook = ./setup-hook.sh;

  GNUSTEP_MAKEFILES = "${make}/share/GNUstep/Makefiles";

  hardeningDisable = [ "format" ];

  meta = {
    homepage = http://gnustep.org/;

    license = stdenv.lib.licenses.lgpl2Plus;

    maintainers = with stdenv.lib.maintainers; [ ashalkhakov matthewbauer ];
    platforms = stdenv.lib.platforms.unix;
  } // (if builtins.hasAttr "meta" args then args.meta else {});
})
