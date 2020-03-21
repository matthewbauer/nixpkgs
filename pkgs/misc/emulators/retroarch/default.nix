{ stdenv, fetchFromGitHub, which, pkgconfig, makeWrapper
, ffmpeg, libGLU, libGL, freetype, libxml2, python3
, libobjc, AppKit, Foundation
, alsaLib ? null
, libdrm ? null
, libpulseaudio ? null
, libv4l ? null
, libX11 ? null
, libXdmcp ? null
, libXext ? null
, libXxf86vm ? null
, mesa ? null
, SDL2 ? null
, udev ? null
, enableNvidiaCgToolkit ? false, nvidia_cg_toolkit ? null
, withVulkan ? stdenv.isLinux, vulkan-loader ? null
, fetchurl
, wayland
, libxkbcommon
, withX11 ? true
}:

with stdenv.lib;

stdenv.mkDerivation rec {
  pname = "retroarch-bare";
  version = "1.8.5";

  src = fetchFromGitHub {
    owner = "libretro";
    repo = "RetroArch";
    sha256 = "1pg8j9wvwgrzsv4xdai6i6jgdcc922v0m42rbqxvbghbksrc8la3";
    rev = "v${version}";
  };

  postUnpack = ''
    cp -r ${fetchFromGitHub {
      owner = "libretro";
      repo = "retroarch-assets";
      rev = "00dd598cb363838296582147da1c59e428d29068";
      sha256 = "0f27cxljycs30q4ib70fpqa2bhpmi88x3za6wci7g6k925kj297l";
    }} source/media/assets
  '';

  patches = [
    ./lookup-prefix-assets.patch
  ];

  nativeBuildInputs = [ pkgconfig wayland ]
                      ++ optional withVulkan makeWrapper;

  buildInputs = [ ffmpeg freetype libxml2 libGLU libGL python3 SDL2 which ]
                ++ optional enableNvidiaCgToolkit nvidia_cg_toolkit
                ++ optional withVulkan vulkan-loader
                ++ optionals stdenv.isDarwin [ libobjc AppKit Foundation ]
                ++ optionals stdenv.isLinux [ alsaLib libdrm libpulseaudio libv4l libX11
                                              libXdmcp libXext libXxf86vm mesa udev
                                              wayland libxkbcommon ];

  # we use prefix-less pkg-config
  PKG_CONF_PATH = "pkg-config";

  enableParallelBuilding = true;

  configureFlags = stdenv.lib.optionals stdenv.hostPlatform.isLinux [ "--enable-kms" "--enable-egl" ]
                ++ stdenv.lib.optional (!withX11) "--disable-x11";

  postInstall = ''
    cp -r ${fetchFromGitHub {
      owner = "libretro";
      repo = "retroarch-joypad-autoconfig";
      rev = "652bfed517970427b2b65ebe7da49ebaa8397617";
      sha256 = "179rq687b82nbgxyazmggal1a84104jx4hp9jprd9vfmalq9442v";
    }} $out/share/retroarch/autoconfig
    cp -r ${fetchFromGitHub {
      owner = "libretro";
      repo = "libretro-core-info";
      rev = "0ee1a1caa741bf9e031c34161a1fae2473ccf31b";
      sha256 = "0gzm2qjldv0fnlsk1vp63w9flhy6i53mz4sr78c5xdkm5brqjly2";
    }} $out/share/retroarch/cores
    cp -r ${fetchFromGitHub {
      owner = "libretro";
      repo = "libretro-database";
      rev = "9d00ee5b7f0146791e6ac20248bc514d3a3e5cc5";
      sha256 = "1kqsmaxkfsn67rb9sh57bakr2rpmlal6l185w4lsidiz46nsqkcn";
    }} $out/share/retroarch/databases
  '' + optionalString withVulkan ''
    wrapProgram $out/bin/retroarch --prefix LD_LIBRARY_PATH ':' ${vulkan-loader}/lib
  '';

  preFixup = "rm $out/bin/retroarch-cg2glsl";

  meta = {
    homepage = https://libretro.com;
    description = "Multi-platform emulator frontend for libretro cores";
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = with maintainers; [ MP2E edwtjo matthewbauer kolbycrouch ];
  };
}
