# Antigravity Task-Liste

## Phase 1: Flake & Host-Setup ✅
- [x] Erstelle `flake.nix` mit den Inputs `nixpkgs` (unstable), `home-manager` und `serpantinum`.
- [x] Definiere den Host `vm` (`nixosConfigurations.vm`) mit Referenzen zu `hosts/vm/configuration.nix` und den jeweiligen Modulen.
- [x] Erstelle `hosts/vm/configuration.nix`:
  - Bootloader: `systemd-boot`
  - Locale: `de_DE.UTF-8`
  - Timezone: `Europe/Berlin`
  - Einbinden von `hardware-configuration.nix`

## Phase 2: Dendritische Module erstellen ✅
- [x] **Core-Module (`modules/core/`):**
  - `nix.nix`: Experimentelle Features aktivieren (`nix-command`, `flakes`).
  - `users.nix`: Benutzer `batroni` anlegen mit `sudo`/`wheel`-Berechtigung.
- [x] **Hardware-Modul (`modules/hardware/virtualbox.nix`):**
  - VirtualBox Guest Additions aktivieren.
- [x] **Desktop-Module (`modules/desktop/`):**
  - `hyprland.nix`: Hyprland aktivieren, Display-Variablen für VMs definieren, Autostart-Einträge für Serpantinum und Clipboard hinterlegen.
  - `serpantinum.nix`: Overlay-basierte Paket-Integration für die Serpantinum-Shell.
- [x] **Software-Modul (`modules/software/packages.nix`):**
  - `allowUnfree = true` gesetzt.
  - Pakete hinzugefügt: `firefox`, `vscode`, `notepadqq`, `obsidian`, `git`, `kitty`, `wl-clipboard`, `cliphist`.
- [x] **Home-Manager (`modules/software/home.nix`):**
  - Hyprland-Konfiguration mit Keybindings, Animationen, Autostart-Hooks.
  - Kitty-Terminal mit JetBrainsMono Nerd Font.
  - Git-Konfiguration.
  - Bash-Aliases (`nrs`, `update`, `gc`, ...).

## Phase 3: Validierung ✅
- [x] Keine zyklischen Abhängigkeiten zwischen den Modulen.
- [x] Alle in `flake.nix` referenzierten Dateipfade stimmen mit der Verzeichnisstruktur überein.
- [x] `.gitignore` erstellt (hardware-configuration.nix ausgeschlossen).
- [x] README mit vollständiger Installationsanleitung erstellt.

## Nächste Schritte (manuell auf dem NixOS-System)
- [ ] `nixos-generate-config --root /mnt` ausführen
- [ ] `hardware-configuration.nix` nach `hosts/vm/` kopieren
- [ ] `nixos-install --flake /pfad/zu/nixos-config#vm` ausführen
- [ ] Nach erstem Login: `passwd batroni` ausführen
- [ ] `modules/desktop/serpantinum.nix` bei Bedarf anpassen (falls Build-Fehler)
- [ ] Git-E-Mail in `modules/software/home.nix` eintragen