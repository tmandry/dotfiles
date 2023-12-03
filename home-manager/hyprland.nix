{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    lxqt.lxqt-policykit

    darkman
    dunst
    pipewire
    light
    wofi

    kitty
    gnome.gnome-terminal

    # firefox

    font-awesome
  ];

  programs.waybar = {
    enable = true;
    settings = [{
      height = 40;
      modules-left = [ "hyprland/workspaces" ];
      modules-right = [ "idle_inhibitor" "pulseaudio" "network" "cpu" "memory" "temperature" "backlight" "keyboard-state" "battery" "clock" "tray" ];
    }];
  };

  services.darkman = {
    enable = true;
    settings.usegeoclue = false;
    settings.lat = 37.758377;
    settings.lng = -122.388518;
  };
  home.file.".config/xdg-desktop-portal/portals.conf".text = ''
    [preferred]
    org.freedesktop.impl.portal.Settings=darkman
  '';

  fonts.fontconfig.enable = true;
}
