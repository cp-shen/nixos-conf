{ config, pkgs, ... }:

{
  programs.sway.enable = true;
  # programs.niri.enable = true;
  # programs.niri.package = pkgs.nixos25.niri;
  programs.xwayland.enable = true;

  services.displayManager.ly = {
    enable = true;
    x11Support = false;
  };

  services.desktopManager.plasma6 = {
    enable = true;
    enableQt5Integration = true;
  };

  services.displayManager.environment = {
    QT_QPA_PLATFORM = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    XDG_SESSION_TYPE = "wayland";
    NIXOS_OZONE_WL = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

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
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-rime
      ];
    };
  };

  # REFS
  #  <https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland#TL.3BDR_Do_we_still_need_XMODIFIERS.2C_GTK_IM_MODULE_and_QT_IM_MODULE.3F>
  #  <https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/i18n/input-method/fcitx5.nix>
  # environment.variables = {
  # XMODIFIERS = "@im=fcitx";
  # GTK_IM_MODULE = "fcitx";
  # QT_IM_MODULE = "fcitx";
  # INPUT_METHOD = "fcitx";
  # };

  environment.systemPackages = with pkgs; [
    mesa-demos
    vulkan-tools
  ];

  # REFS <https://github.com/flatpak/xdg-desktop-portal/issues/986>
  # Using the default DBus impl makes waybar wait forerver to start.
  services.dbus = {
    implementation = "broker";
  };

  # REFS <https://yalter.github.io/niri/Important-Software.html#portals>
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr = {
      enable = true;
    };
    # extraPortals = with pkgs; [
    # xdg-desktop-portal-gtk
    # xdg-desktop-portal-gnome # recommended by niri
    # ];
    # REFS
    #   <https://github.com/YaLTeR/niri/blob/main/resources/niri-portals.conf>
    #   <https://github.com/NixOS/nixpkgs/blob/nixos-25.05/nixos/modules/programs/wayland/sway.nix>
    config.niri = {
      # Use xdg-desktop-portal-gtk for every portal interface...
      default = [ "gtk" ];
      # ... except for the ScreenCast, Screenshot and Secret
      "org.freedesktop.impl.portal.ScreenCast" = "wlr";
      "org.freedesktop.impl.portal.Screenshot" = "wlr";
      # ignore inhibit bc gtk portal always returns as success,
      # despite sway/the wlr portal not having an implementation,
      # stopping firefox from using wayland idle-inhibit
      "org.freedesktop.impl.portal.Inhibit" = "none";
    };
  };

  security.polkit.enable = true;
  # security.soteria.enable = true;
}
