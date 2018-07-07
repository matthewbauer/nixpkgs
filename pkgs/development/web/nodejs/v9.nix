{ buildNodejs, enableNpm ? true }:

buildNodejs {
  inherit enableNpm;
  version = "9.11.2";
  sha256 = "04y2dnbf6jl8j0ykfkdwhir09h274d13k843d7lqfz3bgyn4wj06";
}
