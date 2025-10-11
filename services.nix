{ config, pkgs, ... }:
{

services = {

xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    xkb = {
    layout = "us";
    variant = "alt-intl";
  };
  };

displayManager.sddm.enable = true;
desktopManager.plasma6.enable = true;

printing.enable = true;

pulseaudio.enable = false;

pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 256;
        "default.clock.min-quantum" = 256;
        "default.clock.max-quantum" = 256;
      };
    };

    wireplumber.extraConfig = {
      "10-disable-camera" = {
        "wireplumber.profiles" = {
          main = {
            "monitor.libcamera" = "disabled";
          };
        };
      };
    };
  };

  flatpak.enable = true;


    udev.extraRules = ''
    ACTION=="add|change", SUBSYSTEM=="block", ATTR{queue/scheduler}="bfq"
  '';
hardware.openrgb.enable = true;
};

systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    requires = [ "network-online.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo && flatpak install -y flathub org.dupot.easyflatpak com.discordapp.Discord
    '';
  };


  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-gpu-tools
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        #libvdpau-va-gl
        libva
        vulkan-loader
        vulkan-validation-layers
        mesa
      ];
      extraPackages32 = with pkgs; [
        intel-gpu-tools
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        #libvdpau-va-gl
        libva
        pkgsi686Linux.mesa

      ];
    };
    opentabletdriver.enable = true;
    opentabletdriver.daemon.enable = true;
    steam-hardware.enable = true;
    logitech.wireless.enable = true;

  };
  security.rtkit.enable = true;
#  virtualisation.virtualbox.host.enable = true;
 # virtualisation.virtualbox.guest.clipboard = true;
 # virtualisation.virtualbox.guest.enable = true;
}
