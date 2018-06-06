{ stdenv, appleDerivation }:

appleDerivation {
  preConfigure = "cd libiconv";

  preFixup = ''
    rm -f $out/include/libcharset.h $out/include/localcharset.h
  '';

  configureFlags = [ "--enable-static" ];

  meta = {
    platforms = stdenv.lib.platforms.darwin;
  };
}
