{ config, pkgs, ... }:

{
  # GTK Theme Configuration
  gtk = {
    enable = true;
    
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    
    iconTheme = {
      name = "Nordzy-cyan-dark";
      package = pkgs.nordic;
    };
    
    font = {
      name = "Sans";
      size = 11;
    };
    
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };
}
