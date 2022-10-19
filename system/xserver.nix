{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    autorun = false;

    # windowManager.i3 = {
    #   enable = true;
    #   package = pkgs.i3-gaps;
    # };

    displayManager.startx.enable = true;
  };

  services.xserver.videoDrivers = [ "modesetting" ];
  # services.xserver.useGlamor = true;
  # services.xserver.videoDrivers = [ "intel" ];
  # services.xserver.deviceSection = ''
  #   Option "DRI" "2"
  #   Option "TearFree" "true"
  # '';

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-ocl
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
}
