{ pkgs, serpantinum, ... }:

{
  # ── Serpantinum: Wayland Shell ────────────────────────────────────────────
  # Serpantinum ist eine modulare Shell für Wayland-Compositors.
  # Dokumentation: https://github.com/ilyamiro/serpantinum
  #
  # HINWEIS: Falls der Build mit einem Fehler wie
  #   "attribute 'nixosModules' missing"
  # fehlschlägt, ist die NixOS-Modul-API von Serpantinum noch nicht
  # stabilisiert. In dem Fall diese Datei auf das Paket-basierte Overlay
  # umstellen (siehe Kommentare unten).

  # Methode A: NixOS-Modul (bevorzugt, falls vom Upstream unterstützt)
  # imports = [ serpantinum.nixosModules.default ];
  # programs.serpantinum.enable = true;

  # Methode B: Paket aus dem Serpantinum-Overlay installieren
  nixpkgs.overlays = [
    (final: prev: {
      serpantinum = serpantinum.packages.${prev.system}.default or
                    (builtins.throw ''
                      Serpantinum stellt kein 'packages.${prev.system}.default'
                      bereit. Bitte prüfe https://github.com/ilyamiro/serpantinum
                      und passe modules/desktop/serpantinum.nix entsprechend an.
                    '');
    })
  ];

  environment.systemPackages = [
    pkgs.serpantinum
  ];
}

