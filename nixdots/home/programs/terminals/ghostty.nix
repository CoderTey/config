{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;

    settings = {
      font-family = "JetBrainsMono Nerd Font";
      font-size = 14;
      theme = "nord";
      background-opacity = 0.90;
      window-padding-x = 10;
      window-padding-y = 10;
      cursor-style = "block";
      command = "${pkgs.zsh}/bin/zsh";
    };
  };
}
