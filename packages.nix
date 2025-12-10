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
    xwayland.enable = true;
    nix-ld.enable = true;

    firefox = {
      enable = true;
      preferences."media.eme.enabled" = true;
    };
    corectrl.enable = true;
    obs-studio.enable = true;
    zoom-us.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

    #appimage = {
    #  enable = false;
    #  binfmt = false;
    #};
    nh = {
      enable = true;
      flake = "/home/veltair/nixos-dotfiles/"; # path to config dir
    };
  };

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    autoEnable = false;
    targets.chromium.enable = true;
  };
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [
    # Core Utilities & Development
    vim
    wget
    git
    alacritty
    cmake
    cmakeMinimal
    gh
    killall
    direnv
    nh
    clang-tools
    grc

    # File System & Hardware Tools
    linuxKernel.packages.linux_6_12.hid-tmff2
    exfatprogs
    pciutils
    usbutils
    ntfs3g
    gparted
    # Added missing Thunar plugins:
    xfce.thunar-archive-plugin
    xfce.thunar-volman

    # Graphics & Multimedia Libraries/Codecs
    libva-utils
    ffmpeg
    ffmpegthumbnailer
    openh264
    libjpeg
    webp-pixbuf-loader

    # Desktop & Image Utilities
    xwayland-satellite
    polkit_gnome
    polkit
    imv
    bign-handheld-thumbnailer
    feh

    # KDE/Qt Tools
    libsForQt5.polkit-qt
    libsForQt5.qt5.qtimageformats
    libsForQt5.qt5.qtsvg
    kdePackages.okular
    kdePackages.dolphin
    kdePackages.spectacle
    kdePackages.breeze
    kdePackages.qt6ct

    # Theming Packages (GTK/Qt)
    papirus-icon-theme
    kdePackages.breeze-icons
    rose-pine-cursor
    rose-pine-icon-theme
    libsForQt5.qtstyleplugins
    gtk2
    rose-pine-kvantum
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    vimPlugins.rose-pine
    vimPlugins.obsidian-nvim

    # Gaming & Applications
    gamescope
    wineWowPackages.stable
    pinta
    faugus-launcher
    spicetify-cli
    vesktop
    vlc
    nicotine-plus
    sleek-todo
    fasole

    # Shell/CLI Tools
    fastfetch # Removed duplicate fastfetch

    # Neovim required packages
    luajitPackages.luarocks
    lua51Packages.lua
    tree-sitter
    lua-language-server
    fd

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
  ];
}
