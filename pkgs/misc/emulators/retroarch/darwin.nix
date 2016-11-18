{ stdenv, fetchFromGitHub, makeDesktopItem, coreutils, which, pkgconfig
, ffmpeg, mesa, freetype, libxml2, python34
, libXdmcp ? null, SDL ? null, libpulseaudio ? null
, xcbuild
}:

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "retroarch-${version}";
  version = "1.3.6";

  src = fetchFromGitHub {
    owner = "libretro";
    repo = "RetroArch";
    sha256 = "0vq2pys0qd3zbfwzmg2q0fy9bq6zzkxgq9574qfjmqpmxw82jm6g";
    rev = "v${version}";
  };

  buildInputs = [ pkgconfig mesa freetype libxml2
                  coreutils python34 which SDL xcbuild];

  patches = [ ./no-xib.diff ];

  dontUseXcbuild = true;

  buildPhase = ''
    xcodebuild -project pkg/apple/RetroArch.xcodeproj OTHER_CFLAGS="$NIX_CFLAGS_COMPILE" OTHER_CPLUSPLUSFLAGS="$NIX_CFLAGS_COMPILE" OTHER_LDFLAGS="$NIX_LDFLAGS" build
  '';

  enableParallelBuilding = true;

  meta = {
    homepage = http://libretro.org/;
    description = "Multi-platform emulator frontend for libretro cores";
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = with maintainers; [ MP2E edwtjo matthewbauer ];
  };
}
