{ config, pkgs, ... }:

{
  users.users.tey = {
    isNormalUser = true;
    description = "Tey";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    shell = pkgs.zsh;
  };
  
  programs.zsh.enable = true;
}
