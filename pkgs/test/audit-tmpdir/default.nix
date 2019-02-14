{ stdenv, writeText }:

let
  test = writeText "test.c" ''
    int test_function() {
      return 0;
    }
  '';

  exe = writeText "exe.c" ''
    int test_function();
    int main() {
      int i = test_function();
      return 0;
    }
  '';


in stdenv.mkDerivation {
  name = "audit-tmpdir-test";
  buildCommand = ''
    source $stdenv/setup

    exit_1() {
      echo Succeeded
      exit 0
    }
    trap exit_1 EXIT

    cc -c -fpic -o test.o ${test}
    cc -shared -o libtest${stdenv.hostPlatform.extensions.sharedLibrary} test.o

  '' + stdenv.lib.optionalString stdenv.isDarwin ''
    install_name_tool -id $PWD/libtest${stdenv.hostPlatform.extensions.sharedLibrary} libtest${stdenv.hostPlatform.extensions.sharedLibrary}
  '' + ''

    mkdir -p $out/bin
    cc -o $out/bin/exe ${exe} -Wl,-rpath -Wl,. -L. -ltest

    auditTmpdir $out

    trap - EXIT

    echo Failure - audit-tmpdir.sh did not find $TMPDIR
    exit 1
  '';
}
