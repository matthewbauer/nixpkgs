{ appleDerivation, buildPackages, bootstrap_cmds
, file_cmds, runCommand, dtrace, libdispatch
, flex, bison, m4
, lib, unifdef
, headersOnly ? false }:

let

  # TODO make this a lib function
  singleBinary = drv: cmd: runCommand "${cmd}-${drv.name}" {} ''
    install -D ${drv}/bin/${cmd} $out/bin/${cmd}
  '';

in appleDerivation {
  nativeBuildInputs = [ (singleBinary file_cmds "install")
                        unifdef bootstrap_cmds dtrace
                        flex bison m4];
  buildInputs = lib.optional (!headersOnly) libdispatch;

  dontBuild = headersOnly;
  installTargets = if headersOnly then "installhdrs" else "install";

  DSTROOT = "$(out)";
  PLATFORM = "MacOSX";
  SDKVERSION = "10.11";
  CC = "cc";
  CXX = "c++";
  MIG = "mig";
  MIGCOM = "${buildPackages.darwin.bootstrap_cmds}/libexec/migcom";
  MIGCC = "cc";
  STRIP = "strip";
  LIPO = "lipo";
  LIBTOOL = "libtool";
  NM = "nm";
  UNIFDEF = "unifdef";
  DSYMUTIL = "dsymutil";
  CTFCONVERT = "ctfconvert";
  CTFMERGE = "ctfmerge";
  CTFINSERT = "ctfinsert";
  NMEDIT = "nmedit";
  HOST_OS_VERSION = "10.11";
  HOST_CC = "cc";
  HOST_FLEX = "flex";
  HOST_BISON = "bison";
  HOST_GM4 = "m4";
  HOST_CODESIGN = "true";
  HOST_CODESIGN_ALLOCATE = "true";
  BUILD_WERROR = "0";

  makeFlags = [
    "INCDIR=/include"
    "MANDIR=/share/man"
    "LCLDIR=/include"
    "FRAMEDIR=/Library/Frameworks"
    "INSTALL_SHARE_MISC_DIR=/share/misc"
    "INSTALL_DTRACE_SCRIPTS_DIR=/lib/dtrace"
    "INSTALL_DTRACE_LIBEXEC_DIR=/libexec/dtrace"
  ];

  postPatch = ''
    substituteInPlace makedefs/MakeInc.cmd \
      --replace "/usr/bin/" "" \
      --replace "/bin/" ""

    # This is a bit of a hack...
    mkdir -p sdk/usr/local/libexec

    export SDKROOT_RESOLVED="$PWD/sdk"
    export HOST_SDKROOT_RESOLVED="$PWD/sdk"
    cat > sdk/usr/local/libexec/availability.pl <<EOF
      #!$SHELL
      if [ "\$1" == "--macosx" ]; then
        echo 10.0 10.1 10.2 10.3 10.4 10.5 10.6 10.7 10.8 10.9 10.10 10.11
      elif [ "\$1" == "--ios" ]; then
        echo 2.0 2.1 2.2 3.0 3.1 3.2 4.0 4.1 4.2 4.3 5.0 5.1 6.0 6.1 7.0 8.0 9.0
      fi
    EOF
    chmod +x sdk/usr/local/libexec/availability.pl
  '';
}
