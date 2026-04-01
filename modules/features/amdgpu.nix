#/modules/features/amdgpu.nix
{ pkgs, ... }: {
#
#
#   AMD GPU tools ands and configs for 9070xt
#   AMD GPU tools and ROCm compute packages
  # Enable graphics and 32bit support (needed for Wine/Steam)
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];
  # OpenCL support via ROCm
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];

  # LACT — AMD GPU control daemon (fan curves, power limits, overclocking)
  # Replaces corectrl with a cleaner NixOS native service
  services.lact.enable = true;

  # AMD GPU tools and ROCm packages
  environment.systemPackages = with pkgs; [
    rocmPackages.clr
    rocmPackages.rocm-smi
    rocmPackages.rocminfo
    btop-rocm
    amdgpu_top
    radeontop
    clinfo              # verify OpenCL is working
    lact                # GPU control GUI
    blender-hip         # blender with AMD accel
    libva
    libva-utils
    mesa
  ];
}
