{
  config,
  pkgs,
  inputs,
  ...
}: let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/configs";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "nvim";
    niri = "niri";
    noctalia = "noctalia";
    ghostty = "ghostty";
  };
in {
  imports = [
    inputs.zen-browser.homeModules.beta
    inputs.mango.hmModules.mango
  ];
  home = {
    username = "veltair";
    homeDirectory = "/home/veltair";
    stateVersion = "25.05";
  };
  programs = {
    git = {
      enable = true;
      settings.user.name = "Fabian Quevedo";
      settings.user.email = "fabian.quevedo@upch.pe";
    };
    fish = {
      enable = true;
      #package = pkgs.stable.fish;
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
        cppqb = "clang++ project.cpp && ./a.out";
        nru = "nh os switch --update";
        nrs = "nh os switch";
      };
      plugins = [
        # Enable a plugin (here grc for colorized command output) from nixpkgs
        {
          name = "grc";
          src = pkgs.fishPlugins.grc.src;
        }
      ];
    };
    ghostty.enableFishIntegration = true;
    eza = {
      enable = true;
      colors = "always";
      icons = "always";
      enableFishIntegration = true;
    };
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };
    starship = {
      enable = true;
      enableFishIntegration = true;
      enableTransience = true;
    };
    lazygit.enable = true;
    bat.enable = true;
    zen-browser = {
      enable = true;
      #  profiles = {
      #   profile = {
      # bookmarks, extensions, search engines...
      #  };
      #};
    };
    mangohud = {
      enable = true;
      settings = {
        full = true;
      };
    };
    neovide = {
      enable = true;
      settings = {};
    };
    zed-editor = {
      enable = true;
      package = pkgs.stable.zed-editor;
      extensions = ["nix" "toml" "rust"];
      userSettings = {
        hour_format = "hour24";
        vim_mode = true;
      };
    };
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        waveform
        obs-vkcapture
        obs-stroke-glow-shadow
        obs-source-switcher
        obs-source-record
        obs-pipewire-audio-capture
        obs-noise
      ];
    };
  };
  wayland.windowManager.mango = {
    enable = true;
    settings = ''
    '';
    autostart_sh = ''
       # see autostart.sh
      # Note: here no need to add shebang
    '';
  };
  home.packages = with pkgs; [
    # Development
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
    fastfetch
    btop
    nvtopPackages.amd
    wl-clipboard
    lazygit
    bat
    mesa-demos
    openrgb-with-all-plugins
    # Gaming & Related
    protonup-qt
    heroic
    nixpkgs-unstable.osu-lazer-bin
    stable.virtualbox
    desmume
    goverlay
    mangohud
    stable.mgba
    joystickwake
    etterna
    corectrl
    winetricks

    # GUI Applications
    chromium
    firefox
    neovide
    anki
    obsidian
    mediawriter
    kdePackages.partitionmanager
    kdePackages.kate
    opentabletdriver
    spotify
    upscayl
    zoom-us
    nautilus
    localsend
    syncthing
    libreoffice-fresh
    solaar
    ghostty
    swayidle
  ];
  #Dotfiles symlinks
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
      categories = ["Game"];
      #mimeType = [ "text/html" "text/xml" ];
    };
    citron = {
      name = "Citron";
      genericName = "Citron";
      exec = "/home/veltair/Downloads/citron_0.8.0-x86_64.AppImage %U";
      terminal = false;
      categories = ["Game"];
      icon = "/home/veltair/Downloads/25f6ab48f6e60b601deb89e52ecabe18.png";
      #mimeType = [ "text/html" "text/xml" ];
    };
  };

  #Theming
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
  stylix.targets = {
    bat.enable = true;
    fzf.enable = true;
    nixos-icons.enable = true;
    btop.enable = true;
    zed.enable = true;
  };

  #targets.spicetify.enable
  #targets.starship.enable
  #targets.zen-browser.enable = true;
  #targets.zen-browser.profileNames = [ "profile" ];
}
