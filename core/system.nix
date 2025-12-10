{
  pkgs,
  config,
  ...
}: {
  #host

  system.stateVersion = "25.05";

  time.timeZone = "America/Lima";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  boot = {
    loader = {
      timeout = 10;

      efi = {
        efiSysMountPoint = "/boot";
      };

      grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true; # Otherwise /boot/EFI/BOOT/BOOTX64.EFI isn't generated
        devices = ["nodev"];
        useOSProber = true;
        extraEntriesBeforeNixOS = false;
        extraEntries = ''
          menuentry "Reboot" {
            reboot
          }
          menuentry "Poweroff" {
            halt
          }
        '';
      };
    };

    plymouth = {
      enable = true;
    };
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    supportedFilesystems = ["ntfs"];
    tmp.cleanOnBoot = true;
    kernelParams =
      if builtins.elem "kvm-amd" config.boot.kernelModules
      then ["amd_pstate=active" "nosplit_lock_mitigate" "clearcpuid=514"]
      else
        ["nosplit_lock_mitigate" "quiet" "splash"]
        [
          "quiet"
          "splash"
          "boot.shell_on_fail"
          "udev.log_priority=3"
          "rd.systemd.show_status=auto"
        ];

    kernel.sysctl = {
      "kernel.split_lock_mitigate" = 0;
      "vm.swappiness" = 10;
      "vm.vfs_cache_pressure" = 50;
      "vm.dirty_bytes" = 268435456;
      "vm.max_map_count" = 16777216;
      "vm.dirty_background_bytes" = 67108864;
      "vm.dirty_writeback_centisecs" = 1500;
      "kernel.nmi_watchdog" = 0;
      "kernel.unprivileged_userns_clone" = 1;
      "kernel.printk" = "3 3 3 3";
      "kernel.kptr_restrict" = 2;
      "kernel.kexec_load_disabled" = 1;
    };
  };
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    nameservers = ["192.168.1.35"];
  };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    DISPLAY = ":0";
  };
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
    priority = 5;
  };

  services = {
    printing.enable = true;
    resolved.enable = true;
    speechd.enable = true;
  };
}
