{pkgs, ...}: {
  services.flatpak = {
    enable = true;
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/";
      }
    ];
    packages = [
      "com.discordapp.Discord"
      "com.stremio.Stremio"
      "com.usebottles.bottles"
      "org.dupot.easyflatpak"
      "org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/24.08"
      "org.winehq.Wine.gecko/x86_64/stable-24.08"
      "org.winehq.Wine.gecko/x86_64/stable-25.08"
      "org.winehq.Wine.mono/x86_64/stable-24.08"
      "org.winehq.Wine.mono/x86_64/stable-25.08"
    ];
    update.onActivation = true;
  };
  systemd.services = {
    flatpak-repo = {
      wantedBy = ["multi-user.target"];
      requires = ["network-online.target"];
      after = ["network-online.target"];
      wants = ["network-online.target"];
      path = [pkgs.flatpak];
      script = ''
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo && flatpak install -y flathub org.dupot.easyflatpak com.discordapp.Discord
      '';
    };
  };
}
