{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Hardware
    ./hardware/hardware-configuration.nix
    ./hardware/nvidia.nix

    # Boot
    ./boot

    # Core
    ./core/nix.nix
    ./core/users.nix
    ./core/locale-time.nix
    ./core/qemu.nix

    #Gaming
    ./gaming

    # Network
    ./network

    # Desktop
    ./desktop/xorg.nix
    ./desktop/cosmic.nix
    ./desktop/niri.nix
    ./desktop/oxwm.nix
    ./desktop/picom.nix
    ./desktop/xmonad.nix
  ];

  networking.hostName = "nixos";

  # System version
  system.stateVersion = "25.05";
}
