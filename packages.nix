{ config, pkgs, inputs, nixpkgs, system, ... }:
{

  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "qtwebengine-5.15.19"
  ];

  nixpkgs.overlays = [
    (final: prev: {
      stable = import inputs.nixpkgs-stable {
        system = prev.system;
        config.allowUnfree = true; # Also allow unfree packages from unstable
      };
    })
  ];

  programs = {
    niri.enable = true;
    firefox.enable = true;
    corectrl.enable = true;
    obs-studio.enable = true;
    zoom-us.enable = true;
    xwayland.enable = true;
    gamemode.enable = true;
    gamescope = {
      enable = true;
      capSysNice = false;
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
    xwayland-satellite
    ntfs3g
    cmake
    cmakeMinimal
    polkit_gnome
    gh
    killall
    libsForQt5.qt5.qtimageformats
    kdePackages.okular
    kdePackages.dolphin
    kdePackages.spectacle
    libsForQt5.qt5.qtsvg
    libjpeg
    imv
    bign-handheld-thumbnailer


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

    #Neovim required packages 
    luajitPackages.luarocks
    lua51Packages.lua
    tree-sitter
    lua-language-server
    fd
  ];

  stylix.enable = true;


  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";


}
