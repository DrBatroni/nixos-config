{ ... }:

{
  # ── Nix Flakes & experimentelle Features ──────────────────────────────────
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];

    # Binary Cache für schnellere Downloads
    substituters = [
      "https://cache.nixos.org"
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  # ── Automatische Garbage Collection ───────────────────────────────────────
  nix.gc = {
    automatic = true;
    dates     = "weekly";
    options   = "--delete-older-than 14d";
  };

  # ── Store optimieren (Deduplizierung) ─────────────────────────────────────
  nix.settings.auto-optimise-store = true;
}

