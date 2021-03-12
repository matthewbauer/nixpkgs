{ lib, stdenv, fetchFromGitHub, cmake, aws-c-cal, aws-c-common, s2n-tls, Security, fetchpatch }:

stdenv.mkDerivation rec {
  pname = "aws-c-io";
  version = "0.9.1";

  src = fetchFromGitHub {
    owner = "awslabs";
    repo = pname;
    rev = "v${version}";
    sha256 = "0lx72p9xmmnjkz4zkfb1lz0ibw0jsy52qpydhvn56bq85nv44rwx";
  };

  patches = [
    (fetchpatch {
      url = "https://github.com/matthewbauer/aws-c-io/commit/8c9b28a3ea2e9dc2892d9e1cdcb18b0d03b36c6d.patch";
      sha256 = "16pcr413b0d8xyb360dq2b64a6533r5d7kdi34zrnbkr3xvz97f9";
    })
  ];

  nativeBuildInputs = [ cmake ];

  buildInputs = [ aws-c-cal aws-c-common s2n-tls];

  propagatedBuildInputs = lib.optionals stdenv.hostPlatform.isDarwin [ Security ];

  cmakeFlags = [
    "-DBUILD_SHARED_LIBS=ON"
    "-DCMAKE_MODULE_PATH=${aws-c-common}/lib/cmake"
  ];

  NIX_CFLAGS_COMPILE = lib.optionalString stdenv.isDarwin "-Wno-error";

  meta = with lib; {
    description = "AWS SDK for C module for IO and TLS";
    homepage = "https://github.com/awslabs/aws-c-io";
    license = licenses.asl20;
    platforms = platforms.unix;
    maintainers = with maintainers; [ orivej ];
  };
}
