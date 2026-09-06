{ pkgs, serpantinum, ... }:

{
  home.username      = "batroni";
  home.homeDirectory = "/home/batroni";

  # ── Home-Manager State Version ────────────────────────────────────────────
  # Nicht ändern nach erstmaliger Aktivierung!
  home.stateVersion = "25.05";

  # ── Hyprland Konfiguration ────────────────────────────────────────────────
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";

    settings = {
      # ── Monitor ────────────────────────────────────────────────────────────
      monitor = [
        "Virtual-1, 1920x1080@60, 0x0, 1"
      ];
      #",preferred,auto,1";

      # ── Autostart ──────────────────────────────────────────────────────────
      exec-once = [
        # Clipboard-Dienste
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        # Serpantinum Shell starten
        "serpantinumd start"
        # Polkit-Agent
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        # Wallpaper-Daemon
        "swww-daemon"
      ];

      # ── Allgemeine Einstellungen ────────────────────────────────────────────
      general = {
        gaps_in   = 5;
        gaps_out  = 10;
        border_size = 2;
        "col.active_border"   = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };

      # ── Dekorationen ───────────────────────────────────────────────────────
      decoration = {
        rounding = 10;
        shadow = {
          enabled = true; # Tipp: In einer VM kannst du hier 'false' setzen, um Grafik-Lags zu vermeiden
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        blur = {
          enabled = true;
          size    = 3;
          passes  = 1;
        };
      };

      # ── Animationen ────────────────────────────────────────────────────────
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # ── Eingabe ────────────────────────────────────────────────────────────
      input = {
        kb_layout  = "de";
        follow_mouse = 1;
        touchpad.natural_scroll = false;
      };

      # ── Dwindle Layout ─────────────────────────────────────────────────────
      dwindle = {
        preserve_split  = true;
      };

      # ── Keybindings ────────────────────────────────────────────────────────
      "$mod" = "SUPER";

      bind = [
        # Basics
        "$mod, Return, exec, foot"
        "$mod, Q, killactive"
        "$mod, M, exit"
        "$mod, E, exec, nautilus"
        "$mod, F, togglefloating"
        "$mod, Space, exec, wofi --show drun"
        "$mod, P, pseudo"   # dwindle
        # "$mod, J, togglesplit" # dwindle

        # Screenshot
        ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"

        # Clipboard-Verlauf
        "$mod, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"

        # Fokus bewegen
        "$mod, left,  movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up,    movefocus, u"
        "$mod, down,  movefocus, d"

        # Workspaces wechseln
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Fenster zu Workspace verschieben
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Scratchpad
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"
      ];

      # Maus + Float-Bewegen
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };

  # ── Kitty Terminal Konfiguration ──────────────────────────────────────────
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    settings = {
      background_opacity = "0.95";
      confirm_os_window_close = 0;
    };
    # theme = "Tokyo Night";
  };

  # ── Git Konfiguration ─────────────────────────────────────────────────────
  programs.git = {
    enable    = true;
    settings = {
      user = {
        name  = "batroni";
        email = "dein@email.com";  # Hier deine E-Mail eintragen
      };
    };
  };

  # ── Bash / Shell ──────────────────────────────────────────────────────────
  programs.bash = {
    enable = true;
    shellAliases = {
      ll       = "ls -la";
      nrs      = "sudo nixos-rebuild switch --flake ~/.config/nixos-config#vm";
      nrb      = "sudo nixos-rebuild boot --flake ~/.config/nixos-config#vm";
      update   = "nix flake update ~/.config/nixos-config";
      gc       = "sudo nix-collect-garbage -d";
    };
    initExtra = ''
      # Fastfetch beim Terminal-Start
      fastfetch
    '';
  };

  # ── Home-Manager aktivieren ────────────────────────────────────────────────
  programs.home-manager.enable = true;
}

