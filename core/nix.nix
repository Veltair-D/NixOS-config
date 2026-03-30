{pkgs, ...}: {
  nix = {
    package = pkgs.nixVersions.latest;
    optimise = {
      automatic = true;
      dates = ["weekly"];
    };
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      trusted-users = ["root" "veltair"];
    };
    gc = {
      options = "--delete-older-than 30d";
      dates = "weekly";
      automatic = true;
    };
  };
  nixpkgs.config.allowUnfree = true;
}
