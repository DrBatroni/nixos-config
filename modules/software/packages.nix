{ pkgs, ... }:

{
  # ── Unfree-Pakete erlauben ────────────────────────────────────────────────
  # Benötigt für: VSCode, Obsidian
  nixpkgs.config.allowUnfree = true;

  # ── Systemweite Pakete ────────────────────────────────────────────────────
  environment.systemPackages = with pkgs; [
    # ── Browser ──────────────────────────────────────────────────────────────
    firefox

    # ── Editoren & IDEs ───────────────────────────────────────────────────────
    vscode       # Unfree
    notepad-next    # Linux-Alternative zu Notepad++

    # ── Notizen ───────────────────────────────────────────────────────────────
    obsidian     # Unfree

    # ── Versionskontrolle ─────────────────────────────────────────────────────
    git

    # ── Terminal ──────────────────────────────────────────────────────────────
    kitty        # Hyprland-Standard-Terminal
    foot

    # ── Clipboard-Tools (auch in hyprland.nix – hier für Vollständigkeit) ─────
    wl-clipboard
    cliphist

    # ── System-Tools ──────────────────────────────────────────────────────────
    btop         # Ressourcen-Monitor
    fastfetch    # System-Info (neofetch-Nachfolger)
    unzip
    wget
    curl
  ];

  # ── Fonts systemweit aktivieren ───────────────────────────────────────────
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only      # Enthält alle App- & System-Icons
      material-symbols             # Google Material Icons für die Navigation
      noto-fonts
      noto-fonts-color-emoji
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" ];
        sansSerif = [ "Noto Sans" ];
      };
    };
  };
}

