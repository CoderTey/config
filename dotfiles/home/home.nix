{ config, pkgs, ... }:

{
  home.username = "tey";
  home.homeDirectory = "/home/tey";
  home.stateVersion = "25.05";

  imports = [
    ./modules/mango.nix
  ];

  home.packages = with pkgs; [
    zsh
    bat
  ];

  programs.home-manager.enable = true;
}
