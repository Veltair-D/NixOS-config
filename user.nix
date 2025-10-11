{ pkgs, inputs, ... }:

{
#imports = [
#inputs.home-manager.nixosModules.home-manager
#];
#home-manager = {
#              useGlobalPkgs = true;
#              useUserPackages = true;
 #             users.veltair = import ./home.nix;
 #             backupFileExtension = "backup";
  #          };
  users.users.veltair = {
    isNormalUser = true;
    description = "Fabian Quevedo";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      #  thunderbird
    ];
  };
}
