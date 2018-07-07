{ stdenv, lib, fetchurl
, jdk, zip, unzip, bash, coreutils
, makeWrapper, which, python

# Always assume all markers valid (don't redownload dependencies).
# Also, don't clean up environment variables. Unfortunately this is
# necessary on macOS- but still optional on Linux.
, enableNixHacks ? stdenv.isDarwin

# Apple dependencies
, xcbuild, libcxx, CoreServices, Foundation
}:

assert stdenv.isDarwin -> enableNixHacks;

stdenv.mkDerivation rec {

  version = "0.13.0";

  meta = with stdenv.lib; {
    homepage = "https://github.com/bazelbuild/bazel/";
    description = "Build tool that builds code quickly and reliably";
    license = licenses.asl20;
    maintainers = [ maintainers.mboes ];
    platforms = platforms.linux ++ platforms.darwin;
  };

  name = "bazel-${version}";

  src = fetchurl {
    url = "https://github.com/bazelbuild/bazel/releases/download/${version}/bazel-${version}-dist.zip";
    sha256 = "143nd9dmw2x88azf8spinl2qnvw9m8lqlqc765l9q2v6hi807sc2";
  };

  sourceRoot = ".";

  patches = lib.optional enableNixHacks ./nix-hacks.patch;

  postPatch = ''
    find src/main/java/com/google/devtools -type f -print0 | while IFS="" read -r -d "" path; do
      substituteInPlace "$path" \
        --replace /bin/bash ${bash}/bin/bash \
        --replace /usr/bin/env ${coreutils}/bin/env
    done
    patchShebangs .
  '' + lib.optionalString stdenv.isDarwin ''
    for f in scripts/bootstrap/compile.sh \
             src/tools/xcode/realpath/BUILD \
             src/tools/xcode/stdredirect/BUILD \
             tools/osx/BUILD; do
      substituteInPlace $f \
        --replace /usr/bin/xcrun xcrun \
        --replace /usr/bin/xcode-select xcode-select \
        --replace /usr/bin/xcodebuild xcodebuild
    done
  '';

  NIX_CFLAGS_COMPILE = stdenv.lib.optionalString stdenv.isDarwin
                       "-I${libcxx}/include/c++/v1";

  buildInputs = [
    jdk
  ] ++ lib.optionals stdenv.isDarwin [
    CoreServices
    Foundation
  ];

  nativeBuildInputs = [
    zip
    python
    unzip
    makeWrapper
    which
  ] ++ lib.optional stdenv.isDarwin xcbuild;

  # If TMPDIR is in the unpack dir we run afoul of blaze's infinite symlink
  # detector (see com.google.devtools.build.lib.skyframe.FileFunction).
  # Change this to $(mktemp -d) as soon as we figure out why.

  buildPhase = ''
    export TMPDIR=/tmp
    ./compile.sh
    ./output/bazel build //scripts:bash_completion \
      --output_user_root=$(pwd) \
      --spawn_strategy=standalone \
      --genrule_strategy=standalone
    cp bazel-bin/scripts/bazel-complete.bash output/
  '';

  # Build the CPP and Java examples to verify that Bazel works.
  doCheck = true;
  checkPhase = ''
    export TEST_TMPDIR=$(pwd)
    ./output/bazel test --test_output=errors \
        examples/cpp:hello-success_test \
        examples/java-native/src/test/java/com/example/myproject:hello
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv output/bazel $out/bin
    wrapProgram "$out/bin/bazel" --set JAVA_HOME "${jdk}"
    mkdir -p $out/share/bash-completion/completions
    mkdir -p $out/share/zsh/site-functions
    mv output/bazel-complete.bash $out/share/bash-completion/completions/
    cp scripts/zsh_completion/_bazel $out/share/zsh/site-functions/
  '';
}
