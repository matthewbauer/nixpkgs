{ stdenv
, callPackage
, fetchgit
, bootPkgs
, alex
, happy
, stage0
, haskellLib
, cabal-install
, nodejs
, makeWrapper
, xorg
, gmp
, pkgconfig
, gcc
, lib
, nodePackages
, ghcjsDepOverrides ? (_:_:{})
, haskell
}:

let
  bootPkgs = bootPkgs.extend (lib.foldr lib.composeExtensions (_:_:{}) [
    (self: _: import stage0 {
      inherit configuredSrc;
      inherit (self) callPackage;
    })

    (callPackage ./common-overrides.nix { inherit haskellLib alex happy; })
    ghcjsDepOverrides
  ]);

  libexec = "${bootGhcjs}/libexec/${builtins.replaceStrings ["darwin" "i686"] ["osx" "i386"] stdenv.system}-${bootPkgs.ghc.name}/${bootGhcjs.name}";

in stdenv.mkDerivation {
    name = bootGhcjs.name;
    src = configuredSrc;
    nativeBuildInputs = [
      bootPkgs.ghcjs
      bootPkgs.ghc
      cabal-install
      nodejs
      makeWrapper
      gmp
      pkgconfig
      perl
      autoconf
      automake
      python3
      happy
      alex
    ] ++ lib.optionals stdenv.isDarwin [
      gcc # https://github.com/ghcjs/ghcjs/issues/663
    ];
    configurePhase = ''
      export HOME=$(pwd)
      mkdir $HOME/.cabal
      touch $HOME/.cabal/config

      # TODO: Find a better way to avoid impure version numbers
      sed -i 's/RELEASE=NO/RELEASE=YES/' ghc/configure.ac

      # TODO: How to actually fix this?
      # Seems to work fine and produce the right files.
      touch ghc/includes/ghcautoconf.h

      patchShebangs .
      ./utils/makePackages.sh copy
    '';
    dontInstall = true;
    buildPhase = ''
      export HOME=$TMP
      mkdir $HOME/.cabal
      touch $HOME/.cabal/config
      cd lib/boot

      mkdir -p $out/bin
      mkdir -p $out/lib/${bootGhcjs.name}
      for bin in ${libexec}/*; do
        ln -s $bin $out/bin
      done

      wrapProgram $out/bin/ghcjs --add-flags "-B$out/lib/${bootGhcjs.name}"
      wrapProgram $out/bin/haddock-ghcjs --add-flags "-B$out/lib/${bootGhcjs.name}"
      wrapProgram $out/bin/ghcjs-pkg --add-flags "--global-package-db=$out/lib/${bootGhcjs.name}/package.conf.d"

      env PATH=$out/bin:$PATH $out/bin/ghcjs-boot -j1 --with-ghcjs-bin $out/bin
    '';

    # We hard code -j1 as a temporary workaround for
    # https://github.com/ghcjs/ghcjs/issues/654
    # enableParallelBuilding = true;

    passthru = {
      targetPrefix = "";
      inherit bootGhcjs;
      inherit (bootGhcjs) version;
      isGhcjs = true;

      enableShared = true;

      inherit bootPkgs;

      socket-io = nodePackages."socket.io";

      # Relics of the old GHCJS build system
      stage1Packages = [];
      mkStage2 = { callPackage }: {
        # https://github.com/ghcjs/ghcjs-base/issues/110
        # https://github.com/ghcjs/ghcjs-base/pull/111
        ghcjs-base = haskell.lib.dontCheck (haskell.lib.doJailbreak (callPackage ./ghcjs-base.nix {}));
      };

      haskellCompilerName = "ghcjs-${bootGhcjs.version}";
    };

    meta.platforms = passthru.bootPkgs.ghc.meta.platforms;
  }
