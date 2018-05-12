{ stdenv, writeText, toolchainName, xcbuild, fetchurl
, bootstrap_cmds, yacc, flex, m4, unifdef, gperf, indent, ctags, makeWrapper }:

let

  ToolchainInfo = {
    Identifier = toolchainName;
  };

  # We could pull this out of developer_cmds but it adds an annoying loop if we want to bootstrap and
  # this is just a tiny script so I'm not going to bother
  mkdep-darwin-src = fetchurl {
    url        = "https://opensource.apple.com/source/developer_cmds/developer_cmds-63/mkdep/mkdep.sh";
    sha256     = "0n4wpqfslfjs5zbys5yri8pfi2awyhlmknsf6laa5jzqbzq9x541";
    executable = true;
  };
in

stdenv.mkDerivation {
  name = "nixpkgs.xctoolchain";
  buildInputs = [ xcbuild makeWrapper ];

  ## cctools should build on Linux but it doesn't currently

  buildCommand = ''
    mkdir -p $out
    plutil -convert xml1 -o $out/ToolchainInfo.plist ${writeText "ToolchainInfo.plist" (builtins.toJSON ToolchainInfo)}

    mkdir -p $out/usr/include
    mkdir -p $out/usr/lib
    mkdir -p $out/usr/libexec
    mkdir -p $out/usr/share

    mkdir -p $out/usr/bin
    cd $out/usr/bin

    ln -s ${stdenv.cc.bintools}/bin/ar
    ln -s ${stdenv.cc.bintools}/bin/ld
    ln -s ${stdenv.cc}/bin/cpp
    ln -s ${stdenv.cc}/bin/c++
    ln -s ${stdenv.cc}/bin/cc
    ln -s c++ clang++
    ln -s cc clang
    ln -s c++ g++
    ln -s cc gcc

    ln -s ${yacc}/bin/yacc
    ln -s ${yacc}/bin/bison
    ln -s ${flex}/bin/flex
    ln -s ${flex}/bin/flex++

    ln -s flex lex

    ln -s ${m4}/bin/m4
    ln -s m4 gm4

    ln -s ${unifdef}/bin/unifdef
    ln -s ${unifdef}/bin/unifdefall

    ln -s ${gperf}/bin/gperf
    ln -s ${indent}/bin/indent
    ln -s ${ctags}/bin/ctags

  '' + stdenv.lib.optionalString stdenv.cc.isClang ''
    ln -s ${bootstrap_cmds}/bin/mig
    ln -s ${stdenv.cc.bintools.bintools}/bin/lipo
    ln -s ${stdenv.cc.bintools.bintools}/bin/as
    ln -s ${stdenv.cc.bintools.bintools}/bin/nm
    ln -s ${stdenv.cc.bintools.bintools}/bin/nmedit
    ln -s ${stdenv.cc.bintools.bintools}/bin/libtool
    ln -s ${stdenv.cc.bintools.bintools}/bin/strings
    ln -s ${stdenv.cc.bintools.bintools}/bin/strip
    ln -s ${stdenv.cc.bintools.bintools}/bin/install_name_tool
    ln -s ${stdenv.cc.bintools.bintools}/bin/bitcode_strip
    ln -s ${stdenv.cc.bintools.bintools}/bin/codesign_allocate
    ln -s ${stdenv.cc.bintools.bintools}/bin/dsymutil
    ln -s ${stdenv.cc.bintools.bintools}/bin/dyldinfo
    ln -s ${stdenv.cc.bintools.bintools}/bin/otool
    ln -s ${stdenv.cc.bintools.bintools}/bin/unwinddump
    ln -s ${stdenv.cc.bintools.bintools}/bin/size
    ln -s ${stdenv.cc.bintools.bintools}/bin/segedit
    ln -s ${stdenv.cc.bintools.bintools}/bin/pagestuff
    ln -s ${stdenv.cc.bintools.bintools}/bin/ranlib
    ln -s ${stdenv.cc.bintools.bintools}/bin/redo_prebinding
  '';
}
