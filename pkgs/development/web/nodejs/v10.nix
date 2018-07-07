{ buildNodejs, enableNpm ? true }:

buildNodejs {
  inherit enableNpm;
  version = "10.5.0";
  sha256 = "1g1kdcrhahdsrkazfl9wj25abgjvkncgwwcm2ppgj3avfi1wam3v";
}
