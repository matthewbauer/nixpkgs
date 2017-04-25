{ stdenv, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "xi-editor";
  name = "${pname}-${version}";
  version = "0.2.0";
  src = fetchFromGitHub {
    owner = "google";
    repo = pname;
    rev = "v${version}";
    sha256 = "1k4sfwm9k3z8ldhr94ap2pf3xk97ghj6yydwwdfhyjlcxixd197b";
  };
  depsSha256 = "0ih1np3vv682izpis9snmkawlvry5fhl182kdsvsnciwsxizhxc5";
  sourceRoot = "${pname}-v${version}-src/rust";
}
