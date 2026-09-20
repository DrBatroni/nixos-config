{ inputs, pkgs, ... }:

{
  imports = [
    # Bindet das offizielle NixOS-Modul von Noctalia ein
    inputs.noctalia.nixosModules.default
  ];

  # Aktiviert Noctalia systemweit inklusive aller Laufzeitabhängigkeiten
  programs.noctalia = {
    enable = true;
  };
}