{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

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
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  programs.hyprland.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.nix-ld.enable = true;

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.tey = {
    isNormalUser = true;
    description = "Tey";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
    shell = pkgs.fish; 
  };

  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;

  # ====== Fish shell ======
  programs.fish.enable = true;
  services.flatpak.enable = true;
  #====== Flakes =====
nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = with pkgs; [
    hyprshot
    pavucontrol
    neofetch
    nwg-look
    gnumake
    sxhkd
    gdb
    hyprlock
    hyprpaper
    waybar
    neovim
    helix
    tokyo-night-gtk
    vim
    alacritty
    ranger
    lshw
    xorg.xorgserver
    xorg.xinit
    xorg.xrandr
    dwl
    gcc
    binutils
    git
    zoom-us
    spotify
    discord
    wofi
    dracula-icon-theme
    xfce.thunar
    fish
    tmux
    zellij
    dwl
    cmake
    clang-tools
    clang
    htop
    ncdu
    lf
    fzf
    ripgrep
    rust-analyzer
    zoxide
    rustup
    clippy
    rustfmt
    rustc
    bat
    wget
    curl
    wl-clipboard
    foot
    wmenu
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fishPlugins.grc
    grc
    nixd
    obsidian
    tree-sitter
    tree-sitter-grammars.tree-sitter-nix
    nodejs_24
    python314
    telegram-desktop
    unzip
    lua-language-server
    tree
    lua54Packages.luarocks-nix
    cargo    
    libreoffice
    lmstudio
    lazygit
    st
    dmenu
  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  system.stateVersion = "25.05";
}

