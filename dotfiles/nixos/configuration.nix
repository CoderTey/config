
{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
  ];

  # ====== Boot loader ======
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ====== Networking ======
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # ====== Time & Locale ======
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };


services.displayManager.ly.enable = true;
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.oxwm.enable = true;
    desktopManager.gnome.enable = true;
    displayManager.sessionCommands = ''
      xwallpaper --zoom ~/nixos-dotfiles/walls/wall1.png
    '';
  };


services.picom = {
  enable = true;
  backend = "glx";
  fade = true;
};

 programs.niri.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # ====== Users ======
  users.users.tey = {
    isNormalUser = true;
    description = "Tey";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [ ];
  };

  # ====== Programs ======
  programs.nix-ld.enable = true;
  programs.firefox.enable = true;
  programs.zsh.enable = true;

  # ====== Services ======
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;
  services.flatpak.enable = true;

  # ====== Nix settings ======
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # ====== Environment packages ======
  environment.systemPackages =
    with pkgs;
    [
      coreutils
      gnumake
      gcc
      binutils
      wlroots
      zig
      nordic
      wayland-protocols
      libxkbcommon
      emacs
      emacsPackages.doom
      libevdev
      pixman
      pamixer
      pkg-config
      swaybg
      grim
      scdoc
      mesa
      egl-wayland
      git
      zsh-autocomplete
      zsh-autopair
      zsh-autosuggestions
      htop
      ncdu
      wget
      curl
      unzip
      tree
      scenefx
      sway
      dwl
      wlroots
      pkgs.home-manager
      xorg.xorgserver
      xorg.xinit
      xorg.xrandr
      dwl
      flatpak
      hyprland
      hyprlock
      hyprpaper
      waybar
      sxhkd
      rofi
      firefox
      zoom-us
      spotify
      discord
      obsidian
      libreoffice
      telegram-desktop
      nwg-look
      dracula-icon-theme
      xfce.thunar
      pavucontrol
      alacritty
      foot
      wmenu
      tmux
      zellij
      fish
      neovim
      helix
      vim
      clang
      clang-tools
      cmake
      rust-analyzer
      rustup
      clippy
      rustfmt
      rustc
      zig
      pkg-config
      xorg.libX11
      xorg.libXft
      xorg.libXrender
      freetype
      fontconfig
      nodejs_24
      python314
      lua-language-server
      lua54Packages.luarocks-nix
      cargo
      fzf
      ripgrep
      zoxide
      gnome
      pcmanfm
      nitch   
      xwallpaper
      lshw
      fuzzel
      vimPlugins.harpoon
      vimPlugins.nord-nvim
      vimPlugins.telescope-nvim
      vimPlugins.lualine-nvim
      vimPlugins.tokyonight-nvim
      libnotify
      pkgs.source-code-pro
      neofetch
      fastfetch
      lf
      picom
      scrot
      wl-clipboard
      lazygit
      st
      dmenu
      alsa-tools
      alsa-utils
      tree-sitter
      tree-sitter-grammars.tree-sitter-nix
      fishPlugins.done
      fishPlugins.fzf-fish
      fishPlugins.forgit
      fishPlugins.hydro
      fishPlugins.grc
      grc
      nixd
      ghostty
      tokyo-night-gtk
    ]
    ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  # ====== System version ======
  system.stateVersion = "25.05";
}
