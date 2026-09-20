{ inputs, pkgs, ... }:

{
  # Aktiviert Noctalia systemweit inklusive aller Laufzeitabhängigkeiten
  programs.noctalia = {
    enable = true;
  };
}