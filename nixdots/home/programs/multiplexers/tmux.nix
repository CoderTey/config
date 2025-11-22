{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    shortcut = "a";
    keyMode = "vi";
    mouse = true;

    extraConfig = ''
      bind | split-window -h
      bind - split-window -v

      bind -r k select-pane -U 
      bind -r j select-pane -D 
      bind -r h select-pane -L 
      bind -r l select-pane -R

      set -g base-index 1
      setw -g pane-base-index 1

      set -g status-style 'bg=#333333 fg=#5eacd3'
    '';

    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      vim-tmux-navigator
    ];
  };
}
