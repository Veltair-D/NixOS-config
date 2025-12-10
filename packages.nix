{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "qtwebengine-5.15.19"
  ];

  nixpkgs.overlays = [
    (final: prev: {
      stable = import inputs.nixpkgs-stable {
        system = prev.stdenv.hostPlatform.system;
        config.allowUnfree = true; # Also allow unfree packages from unstable
      };
      nixpkgs-unstable = import inputs.nixpkgs-unstable {
        system = prev.stdenv.hostPlatform.system;
        config.allowUnfree = true;
      };
    })
  ];

  programs = {
    fish.enable = true;
    firefox = {
      enable = true;
      preferences."media.eme.enabled" = true;
    };
    corectrl.enable = true;
    obs-studio.enable = true;
    zoom-us.enable = true;
    xwayland.enable = true;
    appimage = {
      enable = false;
      binfmt = false;
    };
    nix-ld.enable = true;
    nh = {
      enable = true;
      flake = "/home/veltair/nixos-dotfiles/"; # path to config dir
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [
    vim
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
    polkit
    libsForQt5.polkit-qt
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
    feh
    webp-pixbuf-loader
    papirus-icon-theme
    kdePackages.breeze-icons
    rose-pine-cursor
    rose-pine-icon-theme
    libsForQt5.qtstyleplugins
    kdePackages.breeze
    gtk2
    rose-pine-kvantum
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    kdePackages.qt6ct
    gparted
    nh
    gamescope
    wineWowPackages.stable
    clang-tools
    pinta
    faugus-launcher
    spicetify-cli
    vesktop
    vlc
    nicotine-plus
    sleek-todo
    fasole
    openh264
    direnv

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

  services.flatpak = {
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

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  stylix.enable = true;

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
  stylix.autoEnable = false;
  stylix.targets.chromium.enable = true;
}
