# NixOS Config – batroni (Dendritic Style)

Modulare NixOS-Konfiguration basierend auf **Nix Flakes** + **Home-Manager** im Dendritic Style nach [Vimjoyer](https://youtube.com/@vimjoyer).

## Stack

| Komponente | Wert |
|---|---|
| OS | NixOS (nixos-unstable) |
| Compositor | Hyprland (Wayland) |
| Shell | Serpantinum |
| Terminal | Kitty |
| Launcher | Wofi |
| Editor | VSCode + Notepadqq |
| Browser | Firefox |
| Notizen | Obsidian |

## Verzeichnisstruktur

```
nixos-config/
├── flake.nix                          # Einstiegspunkt
├── flake.lock                         # Versionspins (im Git!)
├── hosts/
│   └── vm/
│       ├── configuration.nix          # Host-Settings (Bootloader, Locale, Audio)
│       └── hardware-configuration.nix # ⚠️ LOKAL GENERIEREN – nicht im Repo!
└── modules/
    ├── core/
    │   ├── nix.nix                    # Flakes, Garbage Collection, Caches
    │   └── users.nix                  # Benutzer batroni
    ├── desktop/
    │   ├── hyprland.nix               # Compositor + Wayland-Umgebung + greetd
    │   └── serpantinum.nix            # Serpantinum Wayland-Shell
    ├── hardware/
    │   └── virtualbox.nix             # VirtualBox Guest Additions
    └── software/
        ├── packages.nix               # Systemweite Pakete (inkl. Unfree)
        └── home.nix                   # Home-Manager: Hyprland-Config, Git, Shell
```

## Erstinstallation in der VM

### 1. NixOS minimal installieren

Boote die NixOS ISO und führe die Grundinstallation durch (Partitionierung etc.):

```bash
# Partitionen einhängen (Beispiel – an deine Platten anpassen!)
mount /dev/sda2 /mnt
mkdir -p /mnt/boot
mount /dev/sda1 /mnt/boot

# Hardware-Konfiguration generieren
nixos-generate-config --root /mnt
```

### 2. Diese Konfig herunterladen

```bash
# Git auf dem Installationssystem verfügbar machen
nix-shell -p git

# Repository klonen
git clone https://github.com/DrBatroni/nixos-config.git /mnt/etc/nixos
# ODER nach der Installation:
# git clone https://github.com/DrBatroni/nixos-config.git ~/.config/nixos-config
```

### 3. Hardware-Konfiguration einbinden

```bash
# Die generierte hardware-configuration.nix in den richtigen Ordner kopieren
cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/hosts/vm/
```

### 4. System bauen & aktivieren

```bash
# Während der Installation (von der ISO):
nixos-install --flake /mnt/etc/nixos#vm

# Nach einem Neustart / bei Updates:
sudo nixos-rebuild switch --flake ~/.config/nixos-config#vm
```

### 5. Passwort setzen

Nach dem ersten Login:

```bash
passwd batroni
```

## Tägliche Nutzung

```bash
# System aktualisieren (Inputs updaten + rebuild)
nix flake update ~/.config/nixos-config
sudo nixos-rebuild switch --flake ~/.config/nixos-config#vm

# Kurzform (Bash-Aliases aus home.nix)
update   # flake update
nrs      # nixos-rebuild switch
gc       # Garbage Collection
```

## Auf einem neuen Gerät hinzufügen

1. Neuen Host-Ordner anlegen: `hosts/neuer-pc/`
2. `configuration.nix` kopieren und anpassen (Hostname, etc.)
3. `hardware-configuration.nix` lokal generieren und einfügen
4. In `flake.nix` einen neuen `nixosConfigurations`-Eintrag hinzufügen
5. `sudo nixos-rebuild switch --flake .#neuer-pc`

## ⚠️ Bekannte Hinweise

- **Serpantinum**: Falls `nix build` mit einem Fehler über fehlende Attribute abbricht, die Datei [`modules/desktop/serpantinum.nix`](modules/desktop/serpantinum.nix) anpassen – dort ist erklärt wie.
- **hardware-configuration.nix** wird **nicht** im Repository gespeichert (`.gitignore`), da sie gerätespezifisch ist.
- Initiales Passwort ist `changeme` – **sofort nach dem ersten Login** mit `passwd batroni` ändern!

