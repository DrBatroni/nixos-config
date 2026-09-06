{ pkgs, config, ... }:

{
  # ── Hyprland Compositor aktivieren ───────────────────────────────────────
  programs.hyprland = {
    enable          = true;
    xwayland.enable = true;  # X11-Apps in Wayland-Session ermöglichen
  };

  # ── Wayland Umgebungsvariablen (System-weit) ──────────────────────────────
  environment.sessionVariables = {
    # VirtualBox / Software-Rendering Fixes
    WLR_NO_HARDWARE_CURSORS     = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";

    # Wayland-native Apps bevorzugen
    NIXOS_OZONE_WL = "1";  # Electron-Apps (VSCode, Obsidian) auf Wayland zwingen
    MOZ_ENABLE_WAYLAND = "1";  # Firefox auf Wayland
  };

  # ── XDG Desktop Portal (für Screen-Sharing, Dateidialoge etc.) ────────────
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    config.common.default = "*";
  };

  # ── GDM / Login Manager ───────────────────────────────────────────────────
  # Nutze greetd für einen schlanken Wayland-Login
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd start-hyprland";
        user    = "greeter";
      };
    };
  };

  # ── Benötigte Systemdienste für Wayland ───────────────────────────────────
  services.dbus.enable = true;
  security.polkit.enable = true;

  # Dateisystem-Dienste für Nautilus (Papierkorb, Mounten, Netzwerkfreigaben)
  services.gvfs.enable = true;

  # ── Zusätzliche Pakete für den Hyprland-Desktop ───────────────────────────
  environment.systemPackages = with pkgs; [
    # Wayland-Utilities
    wofi           # Application Launcher
    wl-clipboard   # Clipboard (wl-copy, wl-paste)
    cliphist       # Clipboard-Manager
    waybar         # Status-Bar (Fallback, falls Serpantinum nicht lädt)
    dunst          # Benachrichtigungen
    swww           # Animated Wallpaper Daemon

    # Screen-Lock & Idle
    swaylock
    swayidle

    # Screenshot
    grim
    slurp

    # Dateimanager
    nautilus

    # Polkit Agent
    polkit_gnome
  ];
}

