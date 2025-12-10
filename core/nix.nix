{
  config,
  pkgs,
  ...
}: {
  nix = {
    optimise = {
      automatic = true;
      dates = ["weekly"];
    };
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      trusted-users = ["root" "veltair"];
    };
  };
  nixpkgs.config.allowUnfree = true;
}
