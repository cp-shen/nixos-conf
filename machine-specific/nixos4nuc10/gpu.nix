# Credit: https://github.com/NixOS/nixos-hardware/blob/master/common/gpu/intel.nix
{ config, lib, pkgs, ... }:

{
  services.xserver.videoDrivers = lib.mkBefore [ "modesetting" ];

  boot.initrd.kernelModules = [ "i915" ];

  environment.variables = {
    VDPAU_DRIVER = lib.mkIf config.hardware.opengl.enable (lib.mkDefault "va_gl");
  };

  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    vaapiIntel
    libvdpau-va-gl
    intel-media-driver
  ];
}
