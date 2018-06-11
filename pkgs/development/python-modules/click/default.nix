{ stdenv, buildPythonPackage, fetchPypi, substituteAll, glibc, pytest }:

buildPythonPackage rec {
  pname = "click";
  version = "6.7";

  src = fetchPypi {
    inherit pname version;
    sha256 = "02qkfpykbq35id8glfgwc38yc430427yd05z1wc5cnld8zgicmgi";
  };

  patches = stdenv.lib.optionals (stdenv.isLinux && !stdenv.hostPlatform.isMusl)
    (substituteAll {
      src = ./fix-paths.patch;
      locale = "${glibc.bin}/bin/locale";
    });

  buildInputs = [ pytest ];

  checkPhase = ''
    py.test tests
  '';

  # https://github.com/pallets/click/issues/823
  doCheck = false;

  meta = with stdenv.lib; {
    homepage = http://click.pocoo.org/;
    description = "Create beautiful command line interfaces in Python";
    longDescription = ''
      A Python package for creating beautiful command line interfaces in a
      composable way, with as little code as necessary.
    '';
    license = licenses.bsd3;
  };
}
