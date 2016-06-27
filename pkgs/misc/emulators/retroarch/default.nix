{ stdenv, fetchFromGitHub, makeDesktopItem, coreutils, which, pkgconfig
, ffmpeg, mesa, freetype, libxml2, python34
, enableNvidiaCgToolkit ? false, nvidia_cg_toolkit ? null
, alsaLib ? null, libv4l ? null
, udev ? null, libX11 ? null, libXext ? null, libXxf86vm ? null
, libXdmcp ? null, SDL ? null, libpulseaudio ? null
, xcbuild ? null
}:

with stdenv.lib;

let
  desktopItem = makeDesktopItem {
    name = "retroarch";
    exec = "retroarch";
    icon = "retroarch";
    comment = "Multi-Engine Platform";
    desktopName = "RetroArch";
    genericName = "Libretro Frontend";
    categories = "Game;Emulator;";
    #keywords = "multi;engine;emulator;xmb;";
  };
in

stdenv.mkDerivation rec {
  name = "retroarch-bare-${version}";
  version = "1.3.4";

  src = fetchFromGitHub {
    owner = "libretro";
    repo = "RetroArch";
    sha256 = "0ccp17580w0884baxj5kcynlm03jgd7i62dprz1ajxbi2s7b3mi3";
    rev = "v${version}";
  };

  buildInputs = [ pkgconfig ffmpeg mesa freetype libxml2 coreutils python34 which SDL ]
                ++ optional enableNvidiaCgToolkit nvidia_cg_toolkit
                ++ optionals stdenv.isLinux [ udev alsaLib libX11 libXext libXxf86vm libXdmcp libv4l libpulseaudio ]
		++ optionals stdenv.isDarwin [ xcbuild ];

  configureScript = "sh configure";

  patchPhase = ''
    export GLOBAL_CONFIG_DIR=$out/etc
    sed -e 's#/bin/true#${coreutils}/bin/true#' -i qb/qb.libs.sh
  '';

  buildPhase = if stdenv.isDarwin then ''
      make
      xcodebuild -verbose -target RetroArch -configuration Release -project pkg/apple/RetroArch.xcodeproj DERIVED_DATA_DIR=`pwd`
  '' else null;

  postInstall = ''
    mkdir -p $out/share/icons/hicolor/scalable/apps
    cp -p -T ./media/retroarch.svg $out/share/icons/hicolor/scalable/apps/retroarch.svg

    mkdir -p "$out/share/applications"
    cp ${desktopItem}/share/applications/* $out/share/applications
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
