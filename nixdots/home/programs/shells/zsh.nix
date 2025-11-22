{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;

      # Используем встроенную тему robbyrussell
      theme = "robbyrussell";

      plugins = [
        "git"
        "sudo"
        "docker"
      ];
    };

    initExtra = ''
      # PATH для локальных бинарников
      export PATH="$HOME/.local/bin:$PATH"

      # Переменная для командного терминала
      export TS_SESSION_COMMANDS="nix run ~/nixdots"

      # Алиасы
      alias ls="eza --icons"
      alias ll="eza -la --icons"
      alias cat="bat"
      alias nvf="nix run ~/nixdots"
      alias nrs="sudo nixos-rebuild switch --flake ~/nixdots#tey"
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  home.packages = with pkgs; [
    eza
    bat
    zoxide
  ];
}
