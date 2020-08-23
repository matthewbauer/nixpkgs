{ stdenv, fetchurl, meson, pkgconfig, libxkbcommon, libGL, ninja, libX11 }:

stdenv.mkDerivation rec {
  pname = "libwpe";
  version = "1.7.1";

  src = fetchurl {
    url = "https://wpewebkit.org/releases/${pname}-${version}.tar.xz";
    sha256 = "0h6kh8wy2b370y705pl2vp6vp18dkdsgdxh0243ji2v51kxbg157";
  };

  buildInputs = [ libxkbcommon libGL libX11 ];

  nativeBuildInputs = [ pkgconfig meson ninja ];

  meta = with stdenv.lib; {
    description = "General-purpose library for WPE WebKit";
    license = licenses.bsd2;
    homepage = "https://wpewebkit.org";
    maintainers = [ maintainers.matthewbauer ];
    platforms = platforms.linux;
  };
}
