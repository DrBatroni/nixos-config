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
  };

  outputs = { self, nixpkgs, home-manager, serpantinum, ... }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit serpantinum;
        };

        modules = [
          # Host-spezifische Konfiguration
          ./hosts/vm/configuration.nix

          # Core-Module
          ./modules/core/nix.nix
          ./modules/core/users.nix

          # Hardware
          ./modules/hardware/virtualbox.nix

          # Desktop
          ./modules/desktop/hyprland.nix
          ./modules/desktop/serpantinum.nix

          # Software
          ./modules/software/packages.nix

          # Home-Manager als NixOS-Modul
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.batroni = import ./modules/software/home.nix;
            home-manager.extraSpecialArgs = { inherit serpantinum; };
            # home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
    };
}

