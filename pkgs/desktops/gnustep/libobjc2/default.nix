{ stdenv, lib, fetchFromGitHub, cmake }:
stdenv.mkDerivation rec {
  name = "libobjc2-${version}";
  version = "1.9";

  src = fetchFromGitHub {
    owner = "gnustep";
    repo = "libobjc2";
    rev = "cb13e5307f913bd540363483206a73d94a4d7c68";
    sha256 = "15k1j498mxc61n2dcsd9f78ynf48pgylx0hdzhf9c1bha2318dbg";
  };

  nativeBuildInputs = [ cmake ];

  meta = with lib; {
    description = "Objective-C runtime for use with GNUstep";
    homepage = http://gnustep.org/;
    license = licenses.mit;
    maintainers = with maintainers; [ ashalkhakov matthewbauer ];
    platforms = platforms.unix;
    badPlatforms = [ "aarch64-linux" ];
  };
}
