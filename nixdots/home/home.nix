{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./programs/shells/zsh.nix
    ./programs/terminals/ghostty.nix
    ./programs/multiplexers/tmux.nix
    ./programs/launchers/rofi.nix

    ./programs/desktop/theme.nix
    ./programs/desktop/noctalia.nix

    ./programs/editors/emacs.nix

    ./programs/personaluse/spotify.nix
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
      rustup
      gdb
      # Основные утилиты
      coreutils
      gnumake
      eza
      git
      lua5_1
      qemu
      steam
      steam-run
      emacs.pkgs.vterm
      vim
      virt-manager
      fd
      xmobar
      nixd
      btop
      zed-editor
      curl
      glib
      wget
      unzip
      tree
      osu-lazer-bin
      fastfetch
      bat
      fzf
      ripgrep
      zoxide
      neohtop
      quickshell
      inputs.zen-browser.packages."${system}".default
      # Wayland / GUI

      wlroots
      libxkbcommon
      wayland-protocols
      sway
      libtool
      libvterm
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
      xwayland-satellite
      xwallpaper
      picom
      scrot
      wl-clipboard
      fuzzel
      libnotify
      lshw
      tokyonight-gtk-theme
      dracula-icon-theme
      pkgs.nordic
      pkgs.nordzy-icon-theme
      pkgs.source-code-pro
      xfce.thunar
      nwg-look
      zoom-us
      vesktop

      # Editors / Terminals / Multiplexers
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
      firefox
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
      zig
      zvm
      zls

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
