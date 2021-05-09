{ stdenv
, fetchurl
, pkg-config
, glib
, python3
, systemd
, libgudev
, enableIntrospection ? stdenv.hostPlatform == stdenv.buildPlatform
, gobject-introspection
}:

stdenv.mkDerivation rec {
  pname = "libmbim";
  version = "1.24.2";

  src = fetchurl {
    url = "https://www.freedesktop.org/software/libmbim/${pname}-${version}.tar.xz";
    sha256 = "1r41d4yddp8rgccxrkz9vg5lbrj3dr5vy71d8igrr147k44qq69j";
  };

  outputs = [ "out" "dev" "man" ];

  configureFlags = [
    "--with-udev-base-dir=${placeholder "out"}/lib/udev"
  ] ++ stdenv.lib.optional enableIntrospection "--enable-introspection";

  nativeBuildInputs = [
    pkg-config
    python3
  ] ++ stdenv.lib.optional enableIntrospection gobject-introspection;

  buildInputs = [
    glib
    libgudev
    systemd
  ];

  doCheck = true;

  meta = with stdenv.lib; {
    homepage = "https://www.freedesktop.org/wiki/Software/libmbim/";
    description = "Library for talking to WWAN modems and devices which speak the Mobile Interface Broadband Model (MBIM) protocol";
    platforms = platforms.linux;
    license = licenses.gpl2;
  };
}
