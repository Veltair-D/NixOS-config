{ config, pkgs, lib, inputs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/configs";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "nvim";
    niri = "niri";
    noctalia = "noctalia";
    ghostty = "ghostty";
  };
in
{

  imports = [
    inputs.zen-browser.homeModules.beta
  ];

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
    heroic
    osu-lazer-bin
    chromium
    stable.virtualbox
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
    stable.mgba
    obs-studio
    opentabletdriver
    spotify
    stable.stremio
    upscayl
    zoom-us
    wl-clipboard
    kdePackages.kate
    swayidle
    nautilus
    localsend
    syncthing
    lazygit
    bat
    fzf
    #gaming
    glxinfo
    joystickwake
    winetricks
    openrgb-with-all-plugins

  ];
  programs.zen-browser.enable = true;

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

  xdg.configFile =

    builtins.mapAttrs
      (name: subpath: {
        source = create_symlink "${dotfiles}/${subpath}";
        recursive = true;
      })
      configs;

  xdg.desktopEntries = {
    osu-gamescope = {
      name = "osu! Gamescope";
      genericName = "osu!";
      exec = "steam-run gamemoderun gamescope -h 1080 -w 1920 -b -r 144 -- osu! %U";
      terminal = false;
      categories = [ "Game" ];
      #mimeType = [ "text/html" "text/xml" ];
    };
  };
  gtk = {
    enable = true;
    theme = {
      package = pkgs.rose-pine-gtk-theme;
      name = "rose-pine";
    };
    iconTheme = {
      package = pkgs.rose-pine-icon-theme;
      name = "rose-pine";
    };
    gtk2 = {
      enable = true;
      cursorTheme = {
        package = pkgs.rose-pine-cursor;
        name = "BreezeX-RosePine-Linux";
        size = 30;
      };
      iconTheme = {
        package = pkgs.rose-pine-icon-theme;
        name = "rose-pine";
      };
    };
  };
  qt = {
    enable = true;
    platformTheme.name = "gtk2";
    style = {
      package = pkgs.libsForQt5.qtstyleplugins;
      name = "gtk2";
    };
  };
  home.pointerCursor = {
    enable = true;
    name = "BreezeX-RosePine-Linux";
    package = pkgs.rose-pine-cursor;
    size = 30;
    x11.enable = true;
  };

  stylix.targets.bat.enable = true;
  stylix.targets.btop.enable = true;
  #stylix.targets.vesktop.enable
  #stylix.targets.vencord.enable
  #stylix.targets.vencord.extraCss
  stylix.targets.fzf.enable = true;
  stylix.targets.nixos-icons.enable = true;
  #stylix.targets.spicetify.enable
  #stylix.targets.starship.enable
  #stylix.targets.zed.enable


}
