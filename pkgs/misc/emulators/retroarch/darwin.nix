{ stdenv, fetchFromGitHub, zlib
, xcbuild
, CoreAudio, Foundation, AudioUnit, OpenGL, AppKit, CoreVideo, IOKit, AVFoundation, CoreLocation
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

  buildInputs = [ zlib xcbuild
                  CoreAudio Foundation AudioUnit OpenGL CoreVideo
                  CoreLocation AVFoundation AppKit];

  patches = [ ./no-xib.diff ];

  configureScript = "true";
  dontUseXcbuild = true;

  # remove once xcbuild flag issues are resolved
  NIX_LDFLAGS = " -F${CoreAudio}/Library/Frameworks -F${AudioUnit}/Library/Frameworks -F${OpenGL}/Library/Frameworks -F${Foundation}/Library/Frameworks -F${AppKit}/Library/Frameworks -F${CoreVideo}/Library/Frameworks -F${IOKit}/Library/Frameworks -F${AVFoundation}/Library/Frameworks -F${CoreLocation}/Library/Frameworks";

  DEFINES = ''
    -DHAVE_GRIFFIN
    -DHAVE_UPDATE_ASSETS
    -DHAVE_LANGEXTRA
    -DHAVE_CHEEVOS
    -DHAVE_IMAGEVIEWER
    -DHAVE_IOHIDMANAGER
    -DHAVE_CORETEXT
    -DHAVE_RGUI
    -DHAVE_MENU
    -DOSX
    -DHAVE_OPENGL
    -DHAVE_FBO
    -DHAVE_GLSL
    -DINLINE=inline
    -D__LIBRETRO__
    -DHAVE_COREAUDIO
    -DHAVE_DYNAMIC
    -DHAVE_OVERLAY
    -DHAVE_ZLIB
    -DHAVE_RPNG
    -DHAVE_RJPEG
    -DHAVE_RBMP
    -DHAVE_RTGA
    -DHAVE_COCOA
    -DHAVE_MAIN
    -DSINC_LOWER_QUALITY
    -DHAVE_NETWORKGAMEPAD
    -DHAVE_NETWORKING
		-DRARCH_INTERNAL
		-DHAVE_THREADS
		-DHAVE_DYLIB
		-DHAVE_7ZIP
		-DHAVE_MATERIALUI
		-DHAVE_HID
		-DHAVE_XMB
    -DHAVE_SHADERPIPELINE
    -DHAVE_MMAP
	  -DHAVE_LIBRETRODB
  '';

  buildPhase = ''
    runHook preBuild

    xcodebuild -verbose -configuration Release -target RetroArch -project pkg/apple/RetroArch.xcodeproj OTHER_CFLAGS="$NIX_CFLAGS_COMPILE $DEFINES" OTHER_LDFLAGS="$NIX_LDFLAGS" DERIVED_DATA_DIR=`pwd` build

    runHook postBuild
  '';

  installPhase = ''
    mkdir -p $out/Applications
    cp -r RetroArch-*/Build/Products/Release/RetroArch.app $out/Applications
  '';

  enableParallelBuilding = true;

  meta = {
    homepage = http://libretro.org/;
    description = "Multi-platform emulator frontend for libretro cores";
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = with maintainers; [ matthewbauer ];
  };
}
