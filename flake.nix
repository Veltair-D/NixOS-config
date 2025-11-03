{
  description = "NixOS from Scratch";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs.url = "nixpkgs/nixos-unstable";
nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell"; # Use same quickshell version
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, stylix, ... }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = system;
        modules = [
          ./8bitdo.nix
          ./hardware-configuration.nix
          ./nix.nix
          ./packages.nix
          ./system.nix
          ./services.nix
          ./user.nix
          ./noctalia.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.veltair = import ./home.nix;
              backupFileExtension = "backup";
              overwriteBackup = true;
              extraSpecialArgs = { inherit inputs; };

            };
          }
        ];
        #              specialArgs = { inherit inputs system; };
      };
    };
}

#     homeConfigurations.veltair = home-manager.lib.homeManagerConfiguration {
# modules = [ ./home.nix ];};
# };

