{ stdenv, lib, fetchFromGitHub, cmake, llvmPackages }:

stdenv.mkDerivation rec {
  name = "swift-${version}";
  version = "3.0";

  src = fetchFromGitHub {
    owner = "apple";
    repo = "swift";
    rev = "swift-${version}-RELEASE";
    sha256 = "1i5swqrnjfrfnh4prfwj2wm9mb03pm6gghv9a4d5bbmi098qhjas";
  };

  buildInputs = [ cmake llvmPackages.llvm llvmPackages.clang-unwrapped ];

  cmakeFlags = [
    "-DSWIFT_PATH_TO_LLVM_BUILD=${llvmPackages.llvm}"
    "-DLLVM_BUILD_LIBRARY_DIR=${llvmPackages.llvm}/lib"
    "-DLLVM_BUILD_MAIN_INCLUDE_DIR=${llvmPackages.llvm}/include"
    "-DLLVM_BUILD_BINARY_DIR=${llvmPackages.llvm}/bin"
  ];

  meta = with lib; {
    maintainers = with maintainers; [ matthewbauer ];
    license = licenses.asl20;
    platforms = platforms.unix;
  };
}
