
{ config, lib, pkgs, ... }: {
  # Включаем libvirt
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = false;
      swtpm.enable = true;
    };
    onBoot = "start";  # Запускать сети при загрузке
    onShutdown = "shutdown";  # Корректное выключение ВМ
  };

  # Необходимо для virt-manager
  programs.dconf.enable = true;
  
  # Устанавливаем virt-manager
  programs.virt-manager.enable = true;

  # Добавляем пользователя в группы
  users.users.tey = {
    extraGroups = [ "libvirtd" "kvm" ];
  };
}
