{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.custom.hardware.gamepad-8bitdo-ultimate2c;
in {
  ## 8bitdo config
  options.custom.hardware.gamepad-8bitdo-ultimate2c = {
    enable = lib.mkEnableOption "8bitdo 2.4 Ultimate 2C Controller support";
  };
  config = lib.mkMerge [
    {
      programs = {
        steam = {
          enable = true;
          extest.enable = true;
          gamescopeSession.enable = true;
          protontricks.enable = true;
          package = pkgs.steam.override {
            extraEnv = {
              OBS_VKCAPTURE = true;
            };
            extraPkgs = pkgs':
              with pkgs'; [
                xorg.libXcursor
                xorg.libXi
                xorg.libXinerama
                xorg.libXScrnSaver
                libpng
                libpulseaudio
                libvorbis
                stdenv.cc.cc.lib
                libkrb5
                keyutils
              ];
          };
          remotePlay.openFirewall = true;
          dedicatedServer.openFirewall = true;
          localNetworkGameTransfers.openFirewall = true;
          extraCompatPackages = with pkgs; [proton-ge-bin];
        };
        gamemode.enable = true;
        gamescope = {
          enable = true;
          capSysNice = false;
        };
      };
      hardware = {
        amdgpu = {
          opencl.enable = true;
          initrd.enable = true;
        };
        graphics = {
          enable = true;
          enable32Bit = true;
          extraPackages = with pkgs; [
            #intel-gpu-tools
            #intel-media-driver
            #vaapiIntel
            #vaapiVdpau
            #libvdpau-va-gl
            libva
            vulkan-loader
            vulkan-validation-layers
            mesa
            libdrm
          ];
          extraPackages32 = with pkgs; [
            #intel-gpu-tools
            #intel-media-driver
            #vaapiIntel
            #vaapiVdpau
            #libvdpau-va-gl
            libva
            driversi686Linux.mesa
          ];
        };
        opentabletdriver.enable = true;
        opentabletdriver.daemon.enable = true;
        steam-hardware.enable = true;
        xpadneo.enable = true;
        logitech.wireless.enable = true;
      };

      # Tip: When on: press and hold X/B and Home to power off. Then hold X/B to power on. The mode will be the one selected:
      # - X -> Xinput (displays as Xbox Controller)
      # - D -> DInput (displays as 8Bitdo Ultimate 2C Wireless)

      services = {
        udev.extraRules = ''
          ACTION=="add|change", SUBSYSTEM=="block", ATTR{queue/scheduler}="bfq"
          SUBSYSTEM=="input", ATTRS{idVendor}=="2dc8", ATTRS{idProduct}=="310a", MODE="0660", TAG+="uaccess"
          SUBSYSTEM=="input", ATTRS{idVendor}=="55d4", ATTRS{idProduct}=="0461", ENV{ID_INPUT_JOYSTICK}=""
          KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
        '';
        hardware.openrgb.enable = true;
      };
      security = {
        rtkit.enable = true;
        polkit.enable = true;
        polkit.extraConfig = ''
            polkit.addRule(function(action, subject) {
              if ((action.id == "org.corectrl.helper.init" ||
                   action.id == "org.corectrl.helperkiller.init") &&
                  subject.local == true &&
                  subject.active == true &&
                  subject.isInGroup("users")) {
                      return polkit.Result.YES;
              }
          });
              polkit.addRule(function(action, subject) {
                if (subject.isInGroup("wheel"))
                  return polkit.Result.YES;
              });
        '';
      };
    }
    (lib.mkIf cfg.enable {
      services.udev.extraRules = ''
        KERNEL=="hidraw*", ATTRS{idProduct}=="6012", ATTRS{idVendor}=="2dc8", MODE="0660", TAG+="uaccess"
      '';
    })
  ];
}
