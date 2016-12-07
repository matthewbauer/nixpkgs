{ stdenv, fetchurl, lib, xcbuild, libIDL, pkgconfig, which
, openssl, curl, SDL, glib, libxslt, python, perl
, cf-private, DirectoryService
, qt5
, runCommand }:

with stdenv.lib;

let
  buildType = "release";

  inherit (importJSON ./upstream-info.json) version main;

  # we need to modify qt dir to get build working
  qt-plus = runCommand "qt-plus" {} ''
    mkdir -p $out/Frameworks
    ln -s \
      ${qt5.qtbase}/lib/* \
      ${qt5.qtmacextras}/lib/QtMacExtras.framework \
      $out/Frameworks
    ln -s ${qt5.qtbase}/lib/qt5/* $out/Frameworks
    ln -s ${qt5.qtbase}/* $out
  '';

in stdenv.mkDerivation rec {
  name = "virtualbox-${version}";

  src = fetchurl {
    url = "http://download.virtualbox.org/virtualbox/${version}/VirtualBox-${version}.tar.bz2";
    sha256 = main;
  };

  enableParallelBuilding = true;

  patches = [ ./sierra.patch ];

  prePatch = ''
    export USER=nix

    sed -i \
      -e 's|CC="gcc"|CC="cc"|' \
      -e 's|CXX="g++"|CXX="c++"|' \
      -e 's|^check_gcc$|# check_gcc|' \
      -e 's|^LIBCRYPTO=".*"$|LIBCRYPTO="-L${openssl.out}/lib -lcrypto -lssl"|' \
      -e 's|^INCCRYPTO=""|INCCRYPTO="-I${openssl.dev}/include"|' \
      -e 's@MKISOFS --version@MKISOFS -version@' \
      -e 's@PYTHONDIR=.*@PYTHONDIR=${python}@' \
      -e 's@TOOLQT5BIN=.*@TOOLQT5BIN="${getDev qt5.qtbase}/bin"@' \
      configure

    substituteInPlace Config.kmk \
       --replace "/usr/bin/xcodebuild" "/bin/xcodebuild"

    sed -i \
       -e 's|typedef _Bool bool;|#undef bool\ntypedef _Bool bool;|g' \
       include/iprt/types.h
  '';

  configurePhase = ''
    cat >> LocalConfig.kmk <<LOCAL_CONFIG
    VBOX_WITH_TESTCASES            :=
    VBOX_WITH_TESTSUITE            :=
    VBOX_WITH_VALIDATIONKIT        :=
    VBOX_WITH_DOCS                 :=
    VBOX_WITH_WARNINGS_AS_ERRORS   :=

    VBOX_WITH_ORIGIN               :=
    VBOX_PATH_APP_PRIVATE_ARCH_TOP := $out/share/virtualbox
    VBOX_PATH_APP_PRIVATE_ARCH     := $out/libexec/virtualbox
    VBOX_PATH_SHARED_LIBS          := $out/libexec/virtualbox
    VBOX_WITH_RUNPATH              := $out/libexec/virtualbox
    VBOX_PATH_APP_PRIVATE          := $out/share/virtualbox
    VBOX_PATH_APP_DOCS             := $out/doc

    VBOX_WITH_NEW_XCODE            :=
    VBOX_PATH_MACOSX_DEVEL_ROOT    := ${xcbuild}
    VBOX_PATH_MACOSX_SDK_ROOT      := ${xcbuild.platform}/Developer//SDKs
    VBOX_PATH_MACOSX_TOOLCHAIN_ROOT:= ${xcbuild.toolchain}

    TOOL_GXX4MACHO_PREFIX          :=
    TOOL_GXX4MACHO_SUFFIX          :=
    TOOL_GCC4MACHO_PREFIX          :=
    TOOL_GCC4MACHO_SUFFIX          :=

    TOOL_GXX32_CC := cc
    TOOL_GXX32_CXX := c++

    LOCAL_CONFIG

    ./configure \
      --disable-hardening \
      --with-xcode-dir=${xcbuild} \
      --enable-qt5 \
      --with-qt-dir=${qt-plus}

    sed -e 's@PKG_CONFIG_PATH=.*@PKG_CONFIG_PATH=${libIDL}/lib/pkgconfig:${glib.dev}/lib/pkgconfig ${libIDL}/bin/libIDL-config-2@' \
        -i AutoConfig.kmk
  '';

  nativeBuildInputs = [ pkgconfig which xcbuild ];
  buildInputs = [ libIDL openssl curl SDL glib libxslt
                  python cf-private DirectoryService perl
                  qt5.qtbase qt5.qtmacextras qt5.qttools.dev ];

  dontUseXcbuild = true;

  NIX_CFLAGS_COMPILE = " -DRT_OS_DARWIN ";

  buildPhase = ''
    export NIX_CFLAGS_COMPILE=" -F${cf-private}/Library/Frameworks $NIX_CFLAGS_COMPILE"

    source env.sh
    kmk -j $NIX_BUILD_CORES BUILD_TYPE="${buildType}"
  '';

  meta = {
    description = "PC emulator";
    homepage = http://www.virtualbox.org/;
    maintainers = [ lib.maintainers.matthewbauer ];
    platforms = lib.platforms.darwin;
  };
}
