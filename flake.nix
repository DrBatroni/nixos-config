{
  description = "NixOS Konfiguration (Dendritic Style) – batroni";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    serpantinum = {
      url = "github:ilyamiro/serpantinum";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs"; # this line is optional, prevents downloading two versions of nixpkgs but disables cache
    };
  };

  
  outputs = { self, nixpkgs, home-manager, serpantinum, noctalia, ... }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        # ── 1. Deine bestehende VM ──────────────────────────────────────────
        vm = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit serpantinum;
          };

          modules = [
            ./hosts/vm/configuration.nix
            ./modules/core/nix.nix
            ./modules/core/users.nix
            ./modules/hardware/virtualbox.nix
            ./modules/desktop/hyprland.nix
            ./modules/desktop/noctalia.nix
            ./modules/desktop/serpantinum.nix
            ./modules/software/packages.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.batroni = import ./modules/software/home.nix;
              home-manager.extraSpecialArgs = { inherit serpantinum; };
            }
          ];
        };

        # ── 2. Dein physischer Laptop (ohne VirtualBox-Treiber) ─────────────
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit serpantinum;
          };

          modules = [
            noctalia.nixosModules.default

            ./hosts/laptop/configuration.nix
            ./modules/core/nix.nix
            ./modules/core/users.nix
            ./modules/desktop/hyprland.nix
            ./modules/desktop/noctalia.nix
            ./modules/desktop/serpantinum.nix
            ./modules/software/packages.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.batroni = import ./modules/software/home.nix;
              home-manager.extraSpecialArgs = { inherit serpantinum; };
            }
          ];
        };
      };
    };
}
