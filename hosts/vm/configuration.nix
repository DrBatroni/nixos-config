{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix  # Wird lokal generiert – NICHT im Git-Repo!
  ];

  # ── Bootloader ────────────────────────────────────────────────────────────
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ── Netzwerk ──────────────────────────────────────────────────────────────
  networking.hostName = "nixos-vm";
  networking.networkmanager.enable = true;

  # ── Locale & Zeitzone ─────────────────────────────────────────────────────
  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "de_DE.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT    = "de_DE.UTF-8";
    LC_MONETARY       = "de_DE.UTF-8";
    LC_NAME           = "de_DE.UTF-8";
    LC_NUMERIC        = "de_DE.UTF-8";
    LC_PAPER          = "de_DE.UTF-8";
    LC_TELEPHONE      = "de_DE.UTF-8";
    LC_TIME           = "de_DE.UTF-8";
  };

  # ── Tastatur (Console & X11) ──────────────────────────────────────────────
  console.keyMap = "de";
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # ── Audio (PipeWire) ──────────────────────────────────────────────────────
  security.rtkit.enable = true;
  services.pipewire = {
    enable            = true;
    alsa.enable       = true;
    alsa.support32Bit = true;
    pulse.enable      = true;
  };

  # ── OpenGL / GPU ──────────────────────────────────────────────────────────
  hardware.graphics.enable = true;

  # ── NixOS State Version ───────────────────────────────────────────────────
  # Nicht ändern! Dieser Wert bestimmt die initiale Systemkonfiguration.
  system.stateVersion = "25.05";
}

