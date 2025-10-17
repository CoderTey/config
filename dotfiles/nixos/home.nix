{ config, pkgs, ... }:

{
  home.username = "tey";
  home.homeDirectory = "/home/tey";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    zsh
    bat
  ];

  # Управление сессией через Home Manager
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Zsh configuration
  programs.zsh.enable = true;
  programs.zsh.ohMyZsh = {
    enable = true;
    theme = "nord-extended/nord";
    plugins = [
      "git"
      "zsh-autosuggestions"
      "zsh-syntax-highlighting"
    ];
  };
}

