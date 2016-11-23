{ stdenv, fetchurl, lib, xcbuild, libIDL, pkgconfig, which
, openssl, curl, SDL, glib, libxslt, python, perl
, cf-private, DirectoryService
, qt5 }:

with stdenv.lib;

let
  buildType = "release";

  inherit (importJSON ./upstream-info.json) version main;

in stdenv.mkDerivation {
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
      -e 's|CC="gcc"|CC="clang"|' \
      -e 's|CXX="g++"|CXX="clang++"|' \
      -e 's|^check_gcc$|# check_gcc|' \
      -e 's|^LIBCRYPTO=".*"$|LIBCRYPTO="-L${openssl.out}/lib -lcrypto -lssl"|' \
      -e 's|^INCCRYPTO=""|INCCRYPTO="-I${openssl.dev}/include"|' \
      -e 's@MKISOFS --version@MKISOFS -version@' \
      -e 's@PYTHONDIR=.*@PYTHONDIR=${python}@' \
      configure

    substituteInPlace Config.kmk \
       --replace "/usr/bin/xcodebuild" "/bin/xcodebuild"
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

    PATH_QT5_X11_EXTRAS_LIB        := ${getLib qt5.qtx11extras}/lib
    PATH_QT5_X11_EXTRAS_INC        := ${getDev qt5.qtx11extras}/include
    TOOL_QT5_LRC                   := ${getDev qt5.qttools}/bin/lrelease

    LOCAL_CONFIG

    ./configure \
      --disable-hardening \
      --with-xcode-dir=${xcbuild}

    sed -e 's@PKG_CONFIG_PATH=.*@PKG_CONFIG_PATH=${libIDL}/lib/pkgconfig:${glib.dev}/lib/pkgconfig ${libIDL}/bin/libIDL-config-2@' \
        -i AutoConfig.kmk
  '';

  nativeBuildInputs = [ pkgconfig which xcbuild ];
  buildInputs = [ libIDL openssl curl SDL glib libxslt
                  python cf-private DirectoryService perl
                  qt5.qtbase qt5.qtx11extras ];

  dontUseXcbuild = true;

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
