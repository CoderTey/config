{ config, lib, pkgs, ... }: {
virtualisation.libvirtd.enable = true;
programs.virt-manager.enable = true;

users.users.tey.extraGroups = [ "libvirtd" "kvm" ]; 
}
