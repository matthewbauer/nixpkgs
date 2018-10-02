{ appleDerivation, lib

# Eventually we can actually build this source
, headersOnly ? true
}:

appleDerivation {
  installPhase = lib.optionalString headersOnly ''
    mkdir -p $out/include/hfs
    cp -r core/hfs_*.h $out/include/hfs
  '';
}
