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
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      fish_config prompt choose arrow
    '';
    shellInit = ''
      fastfetch --logo ~/Pictures/nixos.png --logo-height 20 --logo-width 40
    '';
    shellAliases = {
      fetch = "fastfetch --logo ~/Pictures/nixos.png --logo-height 20 --logo-width 40";
      ".." = "cd ..";
      "..." = "cd ../..";
      gst = "git status";
      ga = "git add";
      gaa = "git add *";
      gc = "git commit";
      gcm = "git commit -m";
      gp = "git push";
      lg = "lazygit";
      nv = "nvim";
    };
    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
    ];
  };
  programs.ghostty.enableFishIntegration = true;
  programs.eza.enable = true;
  programs.eza.colors = "always";
  programs.eza.icons = "always";
  programs.eza.enableFishIntegration = true;
  programs.fzf.enable = true;
  programs.fzf.enableFishIntegration = true;
  programs.starship.enable = true;
  programs.starship.enableFishIntegration = true;
  programs.starship.enableTransience = true;
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
    nixpkgs-unstable.osu-lazer-bin
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
    #gaming
    mesa-demos
    joystickwake
    winetricks
    openrgb-with-all-plugins
    etterna

    fishPlugins.grc
    grc
    eza
    fzf
    starship

  ];
  programs.zen-browser = {
    enable = true;
    #  profiles = {
    #   profile = {
    # bookmarks, extensions, search engines...
    #  };
    #};
  };

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
    citron = {
      name = "Citron";
      genericName = "Citron";
      exec = "/home/veltair/Downloads/citron_0.8.0-x86_64.AppImage %U";
      terminal = false;
      categories = [ "Game" ];
      icon = "/home/veltair/Downloads/25f6ab48f6e60b601deb89e52ecabe18.png";
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
  #stylix.targets.zen-browser.enable = true;
  #stylix.targets.zen-browser.profileNames = [ "profile" ];


}
