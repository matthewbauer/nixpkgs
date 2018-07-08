{ appleDerivation, rsync, unifdef, gzip, gnutar }:

appleDerivation {
  DEVELOPER_DIR = "/share";
  DSTROOT = "$(out)";
  nativeBuildInputs = [ rsync unifdef ];
  prePatch = ''
    substituteInPlace Standard/Commands.in \
      --replace /usr/bin/gzip gzip \
      --replace /usr/bin/tar tar \
      --replace "xcrun -find" "command -v"
  '';
}
