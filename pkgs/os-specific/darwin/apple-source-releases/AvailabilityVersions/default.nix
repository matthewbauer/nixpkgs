{ appleDerivation, CoreOSMakefiles }:

appleDerivation {
  MAKEFILEPATH = "${CoreOSMakefiles}/share/Makefiles";
  DSTROOT = "$(out)";
  SRCROOT = "$(shell pwd)";
}
