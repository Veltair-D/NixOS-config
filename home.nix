{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    #nvim = "nvim";
  };
in
{
  home.username = "veltair";
  home.homeDirectory = "/home/veltair";
  programs.git.enable = true;
  home.stateVersion = "25.05";
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos, btw";
    };
  };
  home.packages = with pkgs; [
    neovim
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
    fastfetch
    protonup-qt
    bottles
    heroic
    osu-lazer-bin
    chromium
    #virtualbox
    solaar
    neovide
    anki
    obsidian
    firefox
    mediawriter
    kdePackages.partitionmanager
    btop
    nvtopPackages.amd
    corectrl
    ghostty
    desmume
    goverlay
    mangohud
    libreoffice-fresh
    #mgba
    obs-studio
    opentabletdriver
    spotify
    #stremio
    upscayl
    zoom-us
    wl-clipboard
    kdePackages.kate


    #gaming
    glxinfo
    joystickwake
    winetricks
    openrgb-with-all-plugins

  ];

  programs.mangohud = {
    enable = true;
    settings = {

      full = true;
    };
  };

  programs.neovide = {
    enable = true;
    settings = { };
  };


  programs.git = {
    userName = "Fabian Quevedo";
    userEmail = "fabian.quevedo@upch.pe";
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;
    }
