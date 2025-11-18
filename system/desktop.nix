{ config, pkgs, ... }:

{
  programs.sway.enable = true;
  programs.niri.enable = true;
  programs.niri.package = pkgs.nixos25.niri;
  programs.xwayland.enable = true;

  # services.displayManager.ly = {
  #   enable = true;
  #   x11Support = true;
  # };

  services.xserver = {
    enable = true;
    autorun = false;

    # windowManager.i3 = {
    #   enable = true;
    #   package = pkgs.i3-gaps;
    # };

    # windowManager.xmonad = {
    #   enable = true;
    #   enableContribAndExtras = true;
    # };

    displayManager.startx.enable = true;
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-rime
    ];
  };

  environment.systemPackages = with pkgs; [
    mesa-demos
    vulkan-tools
  ];

  # REFS <https://yalter.github.io/niri/Important-Software.html#portals>
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
  };

  security.polkit.enable = true;
  security.soteria.enable = true;

  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XMODIFIERS = "@im=fcitx";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    QT_QPA_PLATFORM = "wayland";
    INPUT_METHOD = "fcitx";
    GLFW_IM_MODULE = "ibus"; # FIXME: to be verified
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    NIXOS_OZONE_WL = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
