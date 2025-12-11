{ config, lib, pkgs, ...}: {
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras =  true;
  services.xserver.windowManager.xmonad.enableConfiguredRecompile = true;
}
