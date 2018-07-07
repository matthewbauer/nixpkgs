{ buildNodejs, enableNpm ? true }:

buildNodejs {
  inherit enableNpm;
  version = "6.14.3";
  sha256 = "1jbrfk875aimm65wni059rrydmhp4z0hrxskq3ci6jvykxr8gwg3";
}
