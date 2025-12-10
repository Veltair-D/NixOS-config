{
  pkgs,
  inputs,
  ...
}: {
  users = {
    users = {
      veltair = {
        isNormalUser = true;
        description = "Fabian Quevedo";
        extraGroups = ["networkmanager" "wheel"];
        packages = with pkgs; [
          #  thunderbird
        ];
      };
    };
    extraUsers.veltair = {
      shell = pkgs.fish;
    };
  };
}
