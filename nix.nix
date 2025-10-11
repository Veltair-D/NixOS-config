{ config, pkgs, ... }:

{

    nix = {
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
    settings = {
    experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
  };
    nixpkgs.config.allowUnfree = true;

  }
