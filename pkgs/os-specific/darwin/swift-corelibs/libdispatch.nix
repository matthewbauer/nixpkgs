{ stdenv, xcbuild, fetchFromGitHub, libplatform, xnu }:

stdenv.mkDerivation {
  name = "libdispatch";
  nativeBuildInputs = [ xcbuild ];
  buildInputs = [ libplatform xnu ];
  NIX_CFLAGS_COMPILE = [
    "-isystem ${xnu}/Library/Frameworks/Kernel.framework/PrivateHeaders"
    "-I${libplatform}/include/os"
    "-I${xnu}/libkern/firehose"
  ];
  src = fetchFromGitHub {
    owner = "apple";
    repo = "swift-corelibs-libdispatch";
    rev = "44f67b23de92c8d37c4447c1fe38aaab1dea122c";
    sha256 = "1ygy786k071d6ia1b67msf98k2jmaf4plmd9njk400yddf703zzh";
  };
  xcbuildFlags = "-target libfirehose_kernel";
  postPatch = ''
    for f in os/object.h dispatch/dispatch.h os/voucher_activity_private.h \
             os/firehose_buffer_private.h os/voucher_private.h \
             private/private.h src/internal.h
      do substituteInPlace $f --replace os/availability.h availability.h
    done
  '';
}
