{
  config,
  pkgs,
  lib,
  ...
}:
{
  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = lib.mkForce pkgs.nordic;
    };
    iconTheme = {
      name = "Nordzy-cyan-dark";
      package = pkgs.nordzy-icon-theme;
    };
    font = {
      name = "Sans";
      size = 11;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
     # gtk-application-prefer-dark-theme = true;
    };
  };
  xdg.configFile."gtk-3.0/settings.ini".force = true;
  xdg.configFile."gtk-4.0/settings.ini".force = true;
  xdg.configFile."gtk-4.0/gtk.css".force = true;
}
