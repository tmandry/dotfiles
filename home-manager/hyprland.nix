{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    lxqt.lxqt-policykit

    dunst
    pipewire
    light
    wofi

    kitty
    gnome.gnome-terminal

    # firefox

    pkgs.font-awesome
  ];

  programs.waybar = {
    enable = true;
    settings = [{
      height = 40;
      modules-left = [ "hyprland/workspaces" ];
      modules-right = [ "idle_inhibitor" "pulseaudio" "network" "cpu" "memory" "temperature" "backlight" "keyboard-state" "battery" "clock" "tray" ];
    }];
  };

  fonts.fontconfig.enable = true;
}
