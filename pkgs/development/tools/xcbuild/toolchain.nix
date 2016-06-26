{stdenv, clang, cctools, llvm, writeText, toolchainName}:

let

  ToolchainInfo = writeText "ToolchainInfo.plist" ''
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Identifier</key>
	<string>${toolchainName}</string>
</dict>
</plist>
  '';

in

stdenv.mkDerivation {
  name = "nixpkgs.xctoolchain";
  propagatedBuildInputs = [ clang cctools llvm ];
  buildCommand = ''
    mkdir -p $out
    cp ${ToolchainInfo} $out/ToolchainInfo.plist

    mkdir -p $out/usr/include
    mkdir -p $out/usr/lib
    mkdir -p $out/usr/libexec
    mkdir -p $out/usr/share

    mkdir -p $out/usr/bin
    cd $out/usr/bin
    ln -s ${clang}/bin/clang
    ln -s ${clang}/bin/clang++
    ln -s ${clang}/bin/cpp
    ln -s clang++ c++
    ln -s clang cc

    ln -s ${cctools}/bin/ar
    ln -s ${cctools}/bin/as
    ln -s ${cctools}/bin/nm
    ln -s ${cctools}/bin/nmedit
    ln -s ${cctools}/bin/ld
    ln -s ${cctools}/bin/libtool
    ln -s ${cctools}/bin/strings
    ln -s ${cctools}/bin/strip
    ln -s ${cctools}/bin/install_name_tool
    ln -s ${cctools}/bin/bitcode_strip
    ln -s ${cctools}/bin/codesign_allocate
    ln -s ${cctools}/bin/dsymutil
    ln -s ${cctools}/bin/dyldinfo
    ln -s ${cctools}/bin/otool
    ln -s ${cctools}/bin/unwinddump
    ln -s ${cctools}/bin/size
    ln -s ${cctools}/bin/segedit
    ln -s ${cctools}/bin/pagestuff
    ln -s ${cctools}/bin/ranlib
    ln -s ${cctools}/bin/redo_prebinding

    ln -s ${llvm}/bin/llvm-cov
    ln -s ${llvm}/bin/llvm-dsymutil
    ln -s ${llvm}/bin/llvm-dwarfdump
    ln -s ${llvm}/bin/llvm-nm
    ln -s ${llvm}/bin/llvm-objdump
    ln -s ${llvm}/bin/llvm-otool
    ln -s ${llvm}/bin/llvm-profdata
    ln -s ${llvm}/bin/llvm-size
 '';
}

# other commands in /bin/
#   asa
#   bison
#   c89
#   c99
#   cmpdylib
#   ctags
#   ctf_insert
#   dwarfdump
#   flex
#   flex++
#   gcov
#   gm4
#   gperf
#   indent
#   lex
#   lipo
#   lorder
#   m4
#   mig
#   mkdep
#   rebase
#   rpcgen
#   swift
#   swift-compress
#   swift-demangle
#   swift-stdlib-tool
#   swift-update
#   swiftc
#   unifdef
#   unifdefall
#   what
#   yacc
