{ stdenv, fetchurl, gnustep-make, unzip, clang, Foundation, libobjc }:

stdenv.mkDerivation rec {
  name = "${pname}-${version}";
  pname = "unar";
  version = "1.10.1";

  src = fetchurl {
    url = "http://unarchiver.c3.cx/downloads/${pname}${version}_src.zip";
    sha256 = "0aq9zlar5vzr5qxphws8dm7ax60bsfsw77f4ciwa5dq5lla715j0";
  };

  buildInputs = [
    gnustep-make unzip Foundation libobjc
  ];

  postPatch = ''
    substituteInPlace Makefile.linux \
      --replace "gcc" "cc" \
      --replace "g++" "c++"
  '';

  makefile = "Makefile.linux";

  sourceRoot = "./The Unarchiver/XADMaster";

  meta = with stdenv.lib; {
    homepage = http://unarchiver.c3.cx/unarchiver;
    description = "an archive unpacker program";
    longDescription = ''
      The Unarchiver is an archive unpacker program with support for the popular \
      zip, RAR, 7z, tar, gzip, bzip2, LZMA, XZ, CAB, MSI, NSIS, EXE, ISO, BIN, \
      and split file formats, as well as the old Stuffit, Stuffit X, DiskDouble, \
      Compact Pro, Packit, cpio, compress (.Z), ARJ, ARC, PAK, ACE, ZOO, LZH, \
      ADF, DMS, LZX, PowerPacker, LBR, Squeeze, Crunch, and other old formats.
    '';
    license = licenses.lgpl21Plus;
  };
}
