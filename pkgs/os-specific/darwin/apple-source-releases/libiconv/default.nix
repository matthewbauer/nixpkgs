{ stdenv, appleDerivation }:

appleDerivation {
  preConfigure = "cd libiconv";

  configureFlags = [ "--enable-static" ];

  meta = {
    platforms = stdenv.lib.platforms.darwin;
  };
}
