{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Программы
    ./programs/shells/zsh.nix
    ./programs/terminals/ghostty.nix
    ./programs/multiplexers/tmux.nix
    ./programs/launchers/rofi.nix

    # Десктоп
    ./programs/desktop/theme.nix
    ./programs/desktop/noctalia.nix
  ];

  home = {
    username = "tey";
    homeDirectory = "/home/tey";
    stateVersion = "25.05";
  };

  home.packages =
    with pkgs;
    [
      # Toolchain
      gcc
      binutils
      zig
      rustup
      # Основные утилиты
      coreutils
      gnumake
      eza
      git
      qemu
      virt-manager
      fd
      xmobar
      btop
      zed-editor
      curl
      wget
      unzip
      tree
      fastfetch
      bat
      fzf
      ripgrep
      zoxide
      neohtop
      quickshell

      # Wayland / GUI
      wlroots
      libxkbcommon
      wayland-protocols
      sway
      dwl
      hyprland
      hyprlock
      flatpak
      hyprpaper
      waybar
      sxhkd
      rofi
      swaybg
      grim
      xorg.xrandr
      xorg.libX11
      xorg.libXrender
      xorg.xorgserver
      xorg.xinit
      xorg.xsetroot
      xorg.xclock
      xorg.libXft
      xclip
      xwallpaper
      picom
      scrot
      wl-clipboard
      fuzzel
      libnotify
      lshw
      tokyo-night-gtk
      dracula-icon-theme
      pkgs.nordic
      pkgs.nordzy-icon-theme
      pkgs.source-code-pro
      xfce.thunar
      nwg-look
      vesktop

      # Editors / Terminals / Multiplexers
      emacs
      emacsPackages.doom
      neovim
      helix
      tmux
      zellij
      st
      foot
      alacritty
      wmenu
      dmenu

      # Multimedia
      spotify
      firefox
      zoom-us
      discord
      obsidian
      libreoffice
      telegram-desktop
      pavucontrol
      alsa-tools
      alsa-utils

      # Development / Tools
      pkg-config
      cmake
      scdoc
      freetype
      fontconfig
      tree-sitter
      tree-sitter-grammars.tree-sitter-nix
      scenefx
      nixd

      # Shell / Plugins
      zsh
      zsh-autocomplete
      zsh-autopair
      zsh-autosuggestions
      fish
      fishPlugins.done
      fishPlugins.fzf-fish
      fishPlugins.forgit
      fishPlugins.hydro
      fishPlugins.grc
      grc

      # Extras
      neofetch
      fastfetch
      lf
      pcmanfm
      nodejs_24
      python314
      lua-language-server
      lua54Packages.luarocks-nix

      # Noctalia theme / input
      inputs.noctalia.packages.${system}.default
    ]
    ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
