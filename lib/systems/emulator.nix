final: pkgs:

let

  qemu-user = pkgs.qemu.override {
    smartcardSupport = false;
    spiceSupport = false;
    openGLSupport = false;
    virglSupport = false;
    vncSupport = false;
    gtkSupport = false;
    sdlSupport = false;
    pulseSupport = false;
    smbdSupport = false;
    seccompSupport = false;
    hostCpuTargets = ["${final.qemuArch}-linux-user"];
  };

  wine-name = "wine${toString final.parsed.cpu.bits}";
  wine = (pkgs.winePackagesFor wine-name).minimal;

in if final.parsed.kernel.name == pkgs.stdenv.hostPlatform.parsed.kernel.name &&
      (final.parsed.cpu.name == pkgs.stdenv.hostPlatform.parsed.cpu.name ||
      (final.platform.isi686 && pkgs.stdenv.hostPlatform.isx86_64))
   then pkgs.runtimeShell
   else if final.isWindows then "${wine}/bin/${wine-name}"
   else if final.isLinux && pkgs.stdenv.hostPlatform.isLinux
   then "${qemu-user}/bin/qemu-${final.qemuArch}"
   else throw "Don't know how to run ${final.config} executables"
