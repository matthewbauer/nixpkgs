{ stdenv49
, lib, fetchurl, fetchFromGitHub

, which, findutils, m4, gawk
, python, openjdk, mono58, libressl
}:

let
  # hysterical raisins dictate a version of boost this old. however,
  # we luckily do not need to build anything, we just need the header
  # files.
  boost152 = stdenv49.mkDerivation rec {
    name = "boost-headers-1.52.0";

    src = fetchurl {
      url = "mirror://sourceforge/boost/boost_1_52_0.tar.bz2";
      sha256 = "14mc7gsnnahdjaxbbslzk79rc0d12h1i681cd3srdwr3fzynlar2";
    };

    configurePhase = ":";
    buildPhase = ":";
    installPhase = "mkdir -p $out/include && cp -R boost $out/include/";
  };

  makeFdb =
    { version
    , branch
    , sha256

    # the revision can be inferred from the fdb tagging policy
    , rev    ? "refs/tags/${version}"

    # in theory newer versions of fdb support newer compilers, but they
    # don't :( maybe one day
    , stdenv ? stdenv49

    # in theory newer versions of fdb support newer boost versions, but they
    # don't :( maybe one day
    , boost ? boost152
    }: stdenv.mkDerivation rec {
        name = "foundationdb-${version}";
        inherit version;

        src = fetchFromGitHub {
          owner = "apple";
          repo  = "foundationdb";
          inherit rev sha256;
        };

        nativeBuildInputs = [ gawk which m4 findutils mono58 ];
        buildInputs = [ python openjdk libressl boost ];

        patches =
          [ # For 5.2+, we need a slightly adjusted patch to fix all the ldflags
            (if lib.versionAtLeast version "5.2"
             then (if lib.versionAtLeast version "6.0"
                   then ./ldflags-6.0.patch
                   else ./ldflags-5.2.patch)
             else ./ldflags-5.1.patch)
          ] ++
          # for 6.0+, we do NOT need to apply this version fix, since we can specify
          # it ourselves. see configurePhase
          (lib.optional (!lib.versionAtLeast version "6.0") ./fix-scm-version.patch);

        postPatch = ''
          # note: this does not do anything for 6.0+
          substituteInPlace ./build/scver.mk \
            --subst-var-by NIXOS_FDB_VERSION_ID "${rev}" \
            --subst-var-by NIXOS_FDB_SCBRANCH   "${branch}"

          substituteInPlace ./Makefile \
            --replace 'shell which ccache' 'shell true' \
            --replace -Werror ""

          substituteInPlace ./Makefile \
            --replace libstdc++_pic libstdc++

          substituteInPlace ./build/link-validate.sh \
            --replace 'exit 1' '#exit 1'

          patchShebangs .
        '' + lib.optionalString (lib.versionAtLeast version "6.0") ''
          substituteInPlace ./Makefile \
            --replace 'TLS_LIBS +=' '#TLS_LIBS +=' \
            --replace 'LDFLAGS :=' 'LDFLAGS := -ltls -lssl -lcrypto'
        '';

        enableParallelBuilding = true;

        makeFlags = [ "all" "fdb_java" ]
          # Don't compile FDBLibTLS if we don't need it in 6.0 or later;
          # it gets statically linked in
          ++ lib.optional (!lib.versionAtLeast version "6.0") [ "fdb_c" ]
          # Needed environment overrides
          ++ [ "KVRELEASE=1" ];

        # on 6.0 and later, we can specify all this information manually
        configurePhase = lib.optionalString (lib.versionAtLeast version "6.0") ''
          export SOURCE_CONTROL=GIT
          export SCBRANCH="${branch}"
          export VERSION_ID="${rev}"
        '';

        installPhase = ''
          mkdir -vp $out/{bin,libexec/plugins} $lib/{lib,share/java} $dev/include/foundationdb

          cp -v ./lib/libfdb_c.so     $lib/lib
        '' + lib.optionalString (!lib.versionAtLeast version "6.0") ''
          cp -v ./lib/libFDBLibTLS.so $out/libexec/plugins/FDBLibTLS.so
        '' + ''

          cp -v ./bindings/c/foundationdb/fdb_c.h           $dev/include/foundationdb
          cp -v ./bindings/c/foundationdb/fdb_c_options.g.h $dev/include/foundationdb

          cp -v ./bindings/java/foundationdb-client.jar     $lib/share/java/fdb-java.jar

          for x in fdbbackup fdbcli fdbserver fdbmonitor; do
            cp -v "./bin/$x" $out/bin;
          done

          ln -sfv $out/bin/fdbbackup $out/bin/dr_agent
          ln -sfv $out/bin/fdbbackup $out/bin/fdbrestore
          ln -sfv $out/bin/fdbbackup $out/bin/fdbdr

          ln -sfv $out/bin/fdbbackup $out/libexec/backup_agent
        '';

        outputs = [ "out" "lib" "dev" ];

        meta = with stdenv.lib; {
          description = "Open source, distributed, transactional key-value store";
          homepage    = https://www.foundationdb.org;
          license     = licenses.asl20;
          platforms   = platforms.linux;
          maintainers = with maintainers; [ thoughtpolice ];
       };
    };

in with builtins; {

  foundationdb51 = makeFdb rec {
    version = "5.1.7";
    branch  = "release-5.1";
    sha256  = "1rc472ih24f9s5g3xmnlp3v62w206ny0pvvw02bzpix2sdrpbp06";
  };

  foundationdb52 = makeFdb rec {
    version = "5.2.6";
    branch  = "release-5.2";
    rev     = "refs/tags/v5.2.6"; # seemed to be tagged incorrectly
    sha256  = "1q3lq1hqq0f53n51gd4cw5cpayyw65dmkfplhsw1m5mghymzmskk";
  };

  foundationdb60 = makeFdb rec {
    version = "6.0.2pre2430_${substring 0 8 rev}";
    branch  = "release-6.0";
    rev     = "7938d247a5eaf886a176575de6592b76374df58c";
    sha256  = "0g8h2zs0f3aacs7x4hyjh0scybv33gjj6dqfb789h4n6r4gd7d9h";
  };
}
