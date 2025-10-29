{ pkgs, lib, ... }:
{
  vim = {
    theme = {
      enable = true;
      name = "nord";
      style = "dark";
      transparent = true;
    };

    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;
    navigation.harpoon.enable = true;
    git.vim-fugitive.enable = true;
    autopairs.nvim-autopairs.enable = true;
    utility.undotree.enable = true;
    formatter.conform-nvim.enable = true;
    formatter.conform-nvim.setupOpts.format_after_save.enable = true;
    ui.nvim-highlight-colors.enable = true;
    visuals.nvim-web-devicons.enable = true;
    utility.motion.leap.enable = true;
    visuals.indent-blankline.enable = true;

    keymaps = [
      {
        key = "<leader>a";
        mode = "n";
        action = ":lua require('harpoon'):list():add()<CR>";
      }
      {
        key = "<C-e>";
        mode = "n";
        action = ":lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<CR>";
      }
      {
        key = "<leader>fl";
        mode = "n";
        action = ":lua toggle_telescope(require('harpoon'):list())<CR>";
      }
      {
        key = "<C-p>";
        mode = "n";
        action = ":lua require('harpoon'):list():prev()<CR>";
      }
      {
        key = "<C-n>";
        mode = "n";
        action = ":lua require('harpoon'):list():next()<CR>";
      }
    ];

    languages = {
      enableLSP = true;
      enableTreesitter = true;

      nix.enable = true;
      rust.enable = true;
      go.enable = true;
      clang.enable = true;
    };
  };
}
