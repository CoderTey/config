{ pkgs, inputs, ... }:

{
  programs.noctalia-shell = {
    enable = true;
    settings = {
      bar = {
        density = "compact";
        position = "top";
        showCapsule = false;
        widgets = {
          left = [
            { id = "SidePanelToggle"; useDistroLogo = true; }
            { id = "WiFi"; }
            { id = "Bluetooth"; }
          ];
          center = [
            { hideUnoccupied = false; id = "Workspace"; labelMode = "none"; }
          ];
          right = [
            { alwaysShowPercentage = false; id = "Battery"; warningThreshold = 30; }
            {
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              id = "Clock";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
          ];
        };
      };
      colorSchemes.predefinedScheme = "Nord";
      general = {
        avatarImage = "/home/tey/Pictures/1.png";
        radiusRatio = 0.2;
      };
      location = {
        monthBeforeDay = true;
        name = "Mannheim, Germany";
      };
    };
  };
}
