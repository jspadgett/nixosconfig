# /modules/features/amdgpu.nix
{ pkgs, inputs, ... }:
let
  unstable = import inputs.nixpkgs-unstable {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in
{
  # AMD GPU — 9070 XT (RDNA4 / gfx1201)

  # Enable graphics and 32-bit support (Wine/Steam/Proton)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    # Track unstable Mesa for latest RADV on RDNA4.
    # Both 64-bit and 32-bit must match to avoid Proton mismatches.
    package = unstable.mesa;
    package32 = unstable.pkgsi686Linux.mesa;
    # OpenCL via ROCm
    extraPackages = [ unstable.rocmPackages.clr.icd ];
  };

  # Unlock full sysfs power management + overdrive bit.
  # Module default ppfeaturemask is 0xfffd7fff (overdrive on, GFXOFF +
  # stutter-mode off) — identical to the old manual kernelParam, so the
  # anti-stutter GFXOFF-disable is preserved. This is the mask LACT expects.
  hardware.amdgpu.overdrive.enable = true;

  # LACT re-introduced for undervolt + memory OC. Runs lactd via systemd;
  # GUI is `lact gui`. NOTE: previously pulled due to the apply_settings_timer
  # display feedback loop — raise that timer in /etc/lact/config.yaml.
  services.lact.enable = true;

  environment.systemPackages = with pkgs; [
    rocmPackages.clr
    rocmPackages.rocm-smi
    rocmPackages.rocminfo
    btop-rocm
    amdgpu_top
    radeontop
    clinfo
    blender-hip
    libva-utils
    # vainfo diagnostic; libva itself ships via Mesa
  ];
}
