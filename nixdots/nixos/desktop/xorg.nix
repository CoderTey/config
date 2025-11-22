{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;

    xkb = {
      layout = "us,ru";
      options = "grp:win_space_toggle";
    };

    displayManager.sessionCommands = ''
      xwallpaper --zoom ~/Pictures/1.png
    '';
  };

  services.displayManager.ly.enable = true;
}
