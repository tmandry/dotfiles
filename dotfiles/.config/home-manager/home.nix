{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tyler";
  home.homeDirectory = "/home/tyler";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.light
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    # Requires installing a sway-session.desktop; see
    # https://github.com/swaywm/sway/wiki/Systemd-integration#warning--unsupported-instructions
    ".config/systemd/user/sway.service".text = ''
      [Unit]
      Description=sway - SirCmpwn's Wayland window manager
      Documentation=man:sway(5)
      BindsTo=graphical-session.target
      Wants=graphical-session-pre.target
      After=graphical-session-pre.target

      [Service]
      Type=simple
      EnvironmentFile=-%h/.config/sway/env
      # This line make you able to logout to dm and login into sway again
      # (didn't work; doesn't seem necessary)
      #ExecStartPre=systemctl --user unset-environment WAYLAND_DISPLAY DISPLAY
      ExecStart=/home/tyler/.nix-profile/bin/sway
      Restart=on-failure
      RestartSec=1
      TimeoutStopSec=10
    '';

    # Other quality of life stuff:
    # https://github.com/Drakulix/sway-gnome
    # https://github.com/petrstepanov/gnome-macos-remap-wayland
    # https://github.com/k0kubun/xremap.git
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/tyler/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  targets.genericLinux.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod1";
      # Use kitty as default terminal
      #terminal = "kitty";
      startup = [
        # Launch Firefox on start
        #{command = "firefox";}
      ];
      output = {
        "*" = {
            mode = "2560x1600@60Hz";
            scale = "1.0";
        };
      };
      fonts.names = [ "pango" ];
      fonts.size = 10.0;
      bars = [{
        fonts.names = [ "pango" ];
        fonts.size = 12.0;
        statusCommand = "${pkgs.i3status}/bin/i3status";
      }];
      input = {
        "*" = {
          xkb_options = "caps:escape";
        };
      };
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "${modifier}+Shift+q" = "kill";
        "${modifier}+minus" = "splitv";
        "${modifier}+backslash" = "splith";
        "${modifier}+s" = "layout stacking";
        "${modifier}+t" = "layout tabbed";
        "${modifier}+e" = "layout default";
        "${modifier}+d" = "exec ${pkgs.tofi}/bin/tofi-run | ${pkgs.findutils}/bin/xargs swaymsg exec --";
        "XF86MonBrightnessUp" = "exec ${pkgs.light} -A 10";
        "XF86MonBrightnessDown" = "exec ${pkgs.light} -U 10";
      };
    };
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
    #  export QT_AUTO_SCREN_SCALING_FACTOR=1
    #  export QT_QPA_PLATFORM=wayland
    #  export QT_WAYLAND_DISABLE_WINDOW_DECORATIONS=1
    #  export GDK_BACKEND=wayland
    #  export MOZ_ENABLE_WAYLAND=1
    #  export XDG_SESSION_TYPE=wayland
    #  export XDG_SESSION_DESKTOP=sway
    #  export XDG_CURRENT_DESKTOP=sway
    #  export _JAVA_AWT_WM_NONREPARENTING=1
    '';
  };
  programs.swaylock = {
    enable = true;
  };
}
