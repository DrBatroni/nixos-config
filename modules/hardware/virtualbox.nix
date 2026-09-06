{ ... }:

{
  # ── VirtualBox Guest Additions ────────────────────────────────────────────
  virtualisation.virtualbox.guest = {
    enable      = true;
    dragAndDrop = true;  # Drag & Drop zwischen Host und Gast
  };

  # ── VirtualBox-kompatible Kernel-Module ───────────────────────────────────
  # Die Guest Additions laden automatisch vboxvideo, vboxguest, vboxsf
  # Keine manuellen boot.kernelModules nötig.

  # ── Freigegebene Ordner (optional aktivieren) ─────────────────────────────
  # Falls du Ordner zwischen Host und Gast teilen möchtest:
  # fileSystems."/mnt/host" = {
  #   device  = "share_name";   # Name des freigegebenen Ordners in VirtualBox
  #   fsType  = "vboxsf";
  #   options = [ "rw" "nofail" ];
  # };
}

