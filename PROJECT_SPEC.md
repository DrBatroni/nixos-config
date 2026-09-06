# Projekt-Spezifikation: Modular NixOS Configuration (Dendritic Style)

## 1. Ziel des Projekts
Erstellung einer vollständigen, reproduzierbaren und modularen NixOS-Konfiguration basierend auf Nix Flakes. 
Die Konfiguration soll im Dendritic Style (nach Vimjoyer) strukturiert werden und initial in einer VirtualBox-VM lauffähig sein (mit einfacher Übertragbarkeit auf physische Hardware).

## 2. Kern-Technologien & Stack
- Betriebssystem: NixOS (Channel: nixos-unstable)
- Paket- & Systemverwaltung: Nix Flakes
- User-Environment: Home-Manager (als Flake-Modul integriert)
- Display Server / Compositor: Wayland / Hyprland
- Shell / UI-Layer: Serpantinum (github:ilyamiro/serpantinum) als Wayland-Shell
- Virtualisierungsumgebung: Oracle VirtualBox (Gast-System)

## 3. Architektur: Dendritic Style Verzeichnisbaum
Die Konfiguration muss strikt modular aufgeteilt sein:

```text
nixos-config/
├── flake.nix
├── flake.lock
├── hosts/
│   └── vm/
│       ├── configuration.nix          # Basissystem & VM-spezifische Host-Settings
│       └── hardware-configuration.nix # Hardware-Erkennung (wird lokal generiert)
└── modules/
    ├── core/
    │   ├── nix.nix                    # Flakes aktivieren, Garbage Collection, etc.
    │   └── users.nix                  # Benutzer-Definitionen
    ├── desktop/
    │   ├── hyprland.nix               # Hyprland Compositor & Wayland Umgebungsvariablen
    │   └── serpantinum.nix            # Serpantinum Shell (System- & Home-Manager-Modul)
    ├── hardware/
    │   └── virtualbox.nix             # VirtualBox Guest Additions & Video-Fixes
    └── software/
        ├── packages.nix               # Systemweite & GUI-Programme
        └── home.nix                   # Home-Manager Basis-Konfiguration
```

## 4. Detaillierte Anforderungen

### A. VirtualBox & Wayland Kompatibilität
- `virtualisation.virtualbox.guest.enable = true;`
- Umgebungsvariablen für Hyprland in VMs:
  - `WLR_NO_HARDWARE_CURSORS = "1"`
  - `WLR_RENDERER_ALLOW_SOFTWARE = "1"`

### B. Software & Unfree-Pakete
`nixpkgs.config.allowUnfree = true;` muss aktiv sein. Folgende Pakete sind zwingend erforderlich:
- Browser: `firefox`
- Editor/IDE: `vscode`, `notepadqq` (Linux-Alternative zu Notepad++)
- Notizen: `obsidian`
- Versionskontrolle: `git`
- Hyprland-Tools: `kitty` (Terminal), `wofi`, `wl-clipboard`, `cliphist`

### C. Serpantinum Integration
- Flake Input: `serpantinum.url = "github:ilyamiro/serpantinum";`
- System-Modul: `programs.serpantinum.enable = true;` (in NixOS)
- Home-Manager Modul: `programs.serpantinum` mit Basis-Konfiguration (Bar, Workspaces, Clock)
- Autostart-Hooks (in Hyprland):
  - `wl-paste --type text --watch cliphist store`
  - `wl-paste --type image --watch cliphist store`
  - `systemctl --user enable --now easyeffects` (falls Equalizer aktiv)
  - `serpantinumd start`