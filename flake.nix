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
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=latest";
    };
    #obsidian-nvim.url = "github:epwalsh/obsidian.nvim";

    nvf = {
      url = "github:NotAShelf/nvf/v0.8";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.obsidian-nvim.follows = "obsidian-nvim";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    stylix,
    nix-flatpak,
    ...
  }: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      system = system;
      modules = [
        ##Hardware and core
        ./hardware-configuration.nix
        ./core/nix.nix
        ./core/system.nix
        ##Modules
        ./modules/audio.nix
        ./modules/desktop.nix
        ./modules/flatpak.nix
        ./modules/gaming.nix
        ./modules/noctalia.nix
        ./modules/nvim.nix
        ##Users and packages
        ./packages.nix
        ./users/veltair.nix

        nix-flatpak.nixosModules.nix-flatpak
        inputs.nvf.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.veltair = import ./users/home.nix;
            backupFileExtension = "backup";
            overwriteBackup = true;
            extraSpecialArgs = {inherit inputs;};
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

