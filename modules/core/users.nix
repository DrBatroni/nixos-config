{ pkgs, ... }:

{
  # ── Benutzer: batroni ─────────────────────────────────────────────────────
  users.users.batroni = {
    isNormalUser = true;
    description  = "batroni";

    # Passwort wird nach der Installation manuell gesetzt:
    #   sudo passwd batroni
    # Danach kann diese Zeile entfernt oder durch hashedPassword ersetzt werden.
    initialPassword = "changeme";  # NUR für erstes Login – sofort ändern!

    extraGroups = [
      "wheel"          # sudo-Berechtigung
      "networkmanager" # Netzwerk via NetworkManager verwalten
      "audio"          # Audio-Zugriff
      "video"          # Video/GPU-Zugriff
      "input"          # Eingabegeräte (für Wayland)
    ];

    shell = pkgs.bash;
  };

  # sudo für wheel-Gruppe erlauben
  security.sudo.wheelNeedsPassword = true;
}

