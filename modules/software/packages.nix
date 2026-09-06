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

    # ── Clipboard-Tools (auch in hyprland.nix – hier für Vollständigkeit) ─────
    wl-clipboard
    cliphist

    # ── System-Tools ──────────────────────────────────────────────────────────
    btop         # Ressourcen-Monitor
    fastfetch    # System-Info (neofetch-Nachfolger)
    unzip
    wget
    curl

    # ── Fonts ─────────────────────────────────────────────────────────────────
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];

  # ── Fonts systemweit aktivieren ───────────────────────────────────────────
  fonts.fontconfig.enable = true;
}

