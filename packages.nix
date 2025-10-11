{ config, pkgs, ... }:
{

  nixpkgs.config.permittedInsecurePackages = [
    "qtwebengine-5.15.19"
  ];

  programs = {
  niri.enable = true;
  firefox.enable = true;
  corectrl.enable = true;
  obs-studio.enable = true;
  zoom-us.enable = true;
  gamemode.enable = true;
  gamescope = {
    enable = true;
    capSysNice = true;
  };
  steam = {
    enable = true;
    gamescopeSession.enable = true;
    package = pkgs.steam.override {
      extraEnv = {
        OBS_VKCAPTURE = true;
      };
      extraPkgs = pkgs': with pkgs'; [
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
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
  appimage = {
    enable = true;
    binfmt = true;
  };
  nix-ld.enable = true;

  };

    fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];


  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    alacritty
    linuxKernel.packages.linux_6_12.hid-tmff2
    exfatprogs
    pciutils
    usbutils
    libva-utils
    ffmpeg
    ffmpegthumbnailer


    # Compression
    arj
    brotli
    bzip2
    cpio
    gnutar
    gzip
    lha
    libarchive
    lrzip
    lz4
    lzop
    p7zip
    pbzip2
    pigz
    pixz
    unrar
    unzip
    xz
    zip
    zstd


    fastfetch

  ];





  }
