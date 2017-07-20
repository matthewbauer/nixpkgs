{ stdenv, lib, fetchgit, fetchurl, python, ninja, libevent
, darwin }:

let
  fetchFromChromium = { path, rev, sha256 }: fetchgit {
    url = "https://chromium.googlesource.com/chromium/${path}";
    inherit rev sha256;
  };
  srcs = {
    base = fetchFromChromium {
      path = "src/base";
      rev = "2be7904c9086c9e19445e7f87cb246e4528a7b4e";
      sha256 = "0nr3ncicn17j2r0ngidi8wkr25vc95alwy13szjv0q4gjnf42wv8";
    };
    build = fetchFromChromium {
      path = "src/build";
      rev = "62991968b87f1f26efebc6be3167a5aae841caa0";
      sha256 = "1cbws5j5hkrf3m8181wf07fws2197jsk4fbrcds7p75v9wda6rwm";
    };
    # config = fetchFromChromium {
    #   path = "build/config";
    #   rev = "26c397f83b3a0eeee0f9cd4065046de2b9733bfe";
    #   sha256 = "1klpbphrd4xlr0aii0d3iy56p2l0pg6m2jc0krvljg1i7bpqha7k";
    # };
    "tools/gn" = fetchFromChromium {
      path = "src/tools/gn";
      rev = "7355e57287da340d9ad31a47f96596ed30ebc883";
      sha256 = "067n762dnicw5s79bp40m2v2k4c91x5m3jxh75zx28cfjvn2y5l9";
    };
    "testing/gtest" = fetchFromChromium {
      path = "testing/gtest";
      rev = "585ec31ea716f08233a815e680fc0d4699843938";
      sha256 = "0csn1cza66851nmxxiw42smsm3422mx67vcyykwn0a71lcjng6rc";
    };
  };
in stdenv.mkDerivation {
  name = "gn";
  unpackPhase = ''
    mkdir -p chromium/src
    cd chromium/src
    ${lib.concatStringsSep "\n" (
      lib.mapAttrsToList (n: v: ''
        echo "unpacking to ${n}"
        mkdir -p ./${n}
        cp -r ${v}/* ./${n} # */
      '') srcs)}
  '';
  buildInputs = [ python ninja libevent ]
    ++ lib.optionals stdenv.isDarwin [
      darwin.apple_sdk.frameworks.CoreGraphics
      darwin.libobjc
    ];
  buildPhase = ''
    cd tools/gn
    python ./bootstrap/bootstrap.py -v -s --gn-gen-args 'use_system_libevent=1 use_allocator=none'
  '';
}
