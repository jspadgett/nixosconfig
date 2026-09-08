# /modules/features/amdgpu.nix
{ pkgs, ... }:
{
  # AMD GPU — 9070 XT (RDNA4 / gfx1201)

  # Enable graphics and 32-bit support (Wine/Steam/Proton)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    # Mesa comes from stable. This previously overrode package/package32 with
    # unstable Mesa to "track latest RADV on RDNA4" — but RDNA4/gfx1201 landed
    # in Mesa 25.0 and stable now ships 26.1.8, so the override bought one
    # point release (26.2.1) at the cost of a complete second Mesa stack,
    # 64-bit and 32-bit. If it is ever reinstated, override BOTH or NEITHER:
    # a mismatched pair is the Proton breakage the old comment warned about.
    #
    # OpenCL via ROCm. Taken from pkgs, not unstable — both channels ship
    # 7.2.3, and sourcing the ICD from a different instantiation than the
    # rocmPackages.clr below pulled in a second full multi-GB ROCm closure.
    extraPackages = [ pkgs.rocmPackages.clr.icd ];
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
    pkgs.blender
    libva-utils
    # vainfo diagnostic; libva itself ships via Mesa
  ];
}
