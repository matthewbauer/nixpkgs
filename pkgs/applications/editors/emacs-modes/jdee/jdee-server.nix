{ stdenv, lib, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "jdee-server-446b262b";

  src = fetchFromGitHub {
    owner = "jdee-emacs";
    repo = "jdee-server";
    rev = "446b262bdacb88e68f81af601a2ee0adfea41e24";
    sha256 = "0qakixx9cvd7m1dsilmwq99gk3g10mfxvf19pqkq24vvixavd8w5";
  };

  buildInputs = [ maven ];

  buildPhase = ''
    mvn -DskipTests=true -Dmaven.repo.local=$(pwd) assembly:assembly
  '';

  installPhase = ''
    mkdir $out
    cp target/jdee-bundle-*.jar $out
  '';
  meta = with lib; {
    description = "Java backend for Emacs JDEE";
    maintainers = with maintainers; [ matthewbauer ];
    platforms = with platforms; unix;
  };
}
