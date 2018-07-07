{ stdenv, lib, fetchFromGitHub, mcpp, bzip2, expat, openssl, db5
, darwin, libiconv, Security, xcbuild
}:

stdenv.mkDerivation rec {
  name = "zeroc-ice-${version}";
  version = "3.6.3";

  src = fetchFromGitHub {
    owner = "zeroc-ice";
    repo = "ice";
    rev = "v${version}";
    sha256 = "05xympbns32aalgcfcpxwfd7bvg343f16xpg6jv5s335ski3cjy2";
  };

  patches = [ ./makefile.patch ];

  buildInputs = [ mcpp bzip2 expat openssl db5 libiconv ]
    ++ lib.optional stdenv.isDarwin [ Security ];
  nativeBuildInputs = lib.optional stdenv.isDarwin [ xcbuild ];

  postUnpack = ''
    sourceRoot=$sourceRoot/cpp
  '';

  makeFlags = [ "prefix=$(out)" "OPTIMIZE=yes" ];

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    homepage = http://www.zeroc.com/ice.html;
    description = "The internet communications engine";
    license = licenses.gpl2;
    platforms = platforms.unix;
  };
}
