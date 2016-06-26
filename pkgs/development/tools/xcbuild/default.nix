{ stdenv, fetchgit, cmake, libxml2, CoreServices }:

stdenv.mkDerivation {
  name = "xcbuild";

  src = fetchgit {
    url = "https://github.com/facebook/xcbuild.git";
    rev = "9243b08df488d3435a940a58b3986998f748665e";
    sha256 = "0kn02k6r5nv5xlhg05jq6hy83gksj4qkqhnbcdk72v72gsamy11f";
  };

  buildInputs = [ cmake libxml2 ]
    ++ stdenv.lib.optional stdenv.isDarwin CoreServices;

  postInstall = ''
    mv $out/usr/* $out/
    rmdir $out/usr/
  '';
  
  meta = with stdenv.lib; {
    description = "Xcode-compatible build tool.";
    license = licenses.bsd2;
    platforms = platforms.unix;
    maintainers = with maintainers; [ matthewbauer ];
  };
}
