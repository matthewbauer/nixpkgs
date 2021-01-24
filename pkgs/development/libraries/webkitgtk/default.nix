{ stdenv
, fetchurl
, fetchpatch
, perl
, python3
, ruby
, bison
, gperf
, cmake
, ninja
, pkg-config
, gettext
, gobject-introspection
, libnotify
, gnutls
, libgcrypt
, gtk3
, wayland
, libwebp
, enchant2
, xorg
, libxkbcommon
, epoxy
, at-spi2-core
, libxml2
, libsoup
, libsecret
, libxslt
, harfbuzz
, libpthreadstubs
, pcre
, nettle
, libtasn1
, p11-kit
, libidn
, libedit
, readline
, libGL
, libGLU
, libintl
, openjpeg
, enableGeoLocation ? true
, geoclue2
, sqlite
, enableGLES ? true
, gst-plugins-base
, gst-plugins-bad
, woff2
, bubblewrap
, libseccomp
, systemd
, xdg-dbus-proxy
, substituteAll
, glib
, libwpe
, libwpe-fdo
}:

assert enableGeoLocation -> geoclue2 != null;

with stdenv.lib;

stdenv.mkDerivation rec {
  pname = "webkitgtk";
  version = "2.30.3";

  outputs = [ "out" "dev" ];

  separateDebugInfo = stdenv.hostPlatform.isLinux;

  src = fetchurl {
    url = "https://webkitgtk.org/releases/${pname}-${version}.tar.xz";
    sha256 = "0zsy3say94d9bhaan0l6mfr59z03a5x4kngyy8b2i20n77q19skd";
  };

  patches = optionals stdenv.hostPlatform.isLinux [
    (substituteAll {
      src = ./fix-bubblewrap-paths.patch;
      inherit (builtins) storeDir;
    })
    ./libglvnd-headers.patch
  ] ++ optional stdenv.hostPlatform.isDarwin [
    (fetchpatch {
      name = "use_apple_icu_as_fallback.patch";
      url = "https://bug-220081-attachments.webkit.org/attachment.cgi?id=416707&action=diff&format=raw";
      excludes = [ "ChangeLog" "Source/WTF/ChangeLog" ];
      sha256 = "000was24gskf3m1i23rx6k98vn77n4d49qr54rdf2nb1b1fjmf42";
    })
  ];

  preConfigure = stdenv.lib.optionalString (stdenv.hostPlatform != stdenv.buildPlatform) ''
    # Ignore gettext in cmake_prefix_path so that find_program doesn't
    # pick up the wrong gettext. TODO: Find a better solution for
    # this, maybe make cmake not look up executables in
    # CMAKE_PREFIX_PATH.
    cmakeFlags+=" -DCMAKE_IGNORE_PATH=${getBin gettext}/bin"
  '';

  nativeBuildInputs = [
    bison
    cmake
    gettext
    gobject-introspection
    gperf
    ninja
    perl
    pkg-config
    python3
    ruby
    glib # for gdbus-codegen
  ] ++ stdenv.lib.optionals stdenv.isLinux [
    wayland # for wayland-scanner
  ];

  buildInputs = [
    at-spi2-core
    enchant2
    epoxy
    gnutls
    gst-plugins-bad
    gst-plugins-base
    harfbuzz
    libGL
    libGLU
    libgcrypt
    libidn
    libintl
    libnotify
    libpthreadstubs
    libsecret
    libtasn1
    libwebp
    libxkbcommon
    libxml2
    libxslt
    nettle
    openjpeg
    p11-kit
    pcre
    sqlite
    woff2
  ] ++ (with xorg; [
    libXdamage
    libXdmcp
    libXt
    libXtst
  ]) ++ optionals stdenv.hostPlatform.isDarwin [
    libedit
    readline
  ] ++ optionals stdenv.hostPlatform.isLinux [
    libwpe
    libwpe-fdo
    bubblewrap
    libseccomp
    systemd
    wayland
    xdg-dbus-proxy
  ] ++ optional enableGeoLocation geoclue2;

  propagatedBuildInputs = [
    gtk3
    libsoup
  ];

  cmakeFlags = [
    "-DENABLE_INTROSPECTION=ON"
    "-DPORT=GTK"
    "-DUSE_LIBHYPHEN=OFF"
  ] ++ optionals stdenv.hostPlatform.isDarwin [
    "-DENABLE_GRAPHICS_CONTEXT_GL=OFF"
    "-DENABLE_GTKDOC=OFF"
    "-DENABLE_MINIBROWSER=OFF"
    "-DENABLE_QUARTZ_TARGET=ON"
    "-DENABLE_VIDEO=ON"
    "-DENABLE_WEBGL=OFF"
    "-DENABLE_WEB_AUDIO=OFF"
    "-DENABLE_X11_TARGET=OFF"
    "-DUSE_SYSTEM_MALLOC=ON"
    "-DUSE_SYSTEMD=OFF"
    "-DUSE_APPLE_ICU=OFF"
    "-DENABLE_WEB_CRYPTO=OFF"
  ] ++ optional (stdenv.hostPlatform.isLinux && enableGLES) "-DENABLE_GLES2=ON";

  postPatch = ''
    patchShebangs .
  ''
    # can’t find malloc_size & malloc_good_size otherwise
   + optionalString stdenv.hostPlatform.isDarwin ''
    sed -i '1i#include<malloc/malloc.h>' Source/WTF/wtf/FastMalloc.cpp
  '';

  meta = {
    description = "Web content rendering engine, GTK port";
    homepage = "https://webkitgtk.org/";
    license = licenses.bsd2;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = teams.gnome.members;
  };
}
