{ pkgs, lib, ... }:
{
  vim = {
    viAlias = true;
    vimAlias = true;
    leaderKey = " ";

    theme = {
      enable = true;
      name = "rose-pine";
      style = "main";
      transparent = true;
    };
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
      # Harpoon mappings
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

      # Basic navigation and editing
      {
        key = "<leader>pv";
        mode = "n";
        action = ":lua vim.cmd.Ex()<CR>";
      }
      {
        key = "J";
        mode = "v";
        action = ":m '>+1<CR>gv=gv";
      }
      {
        key = "K";
        mode = "v";
        action = ":m '<-2<CR>gv=gv";
      }
      {
        key = "J";
        mode = "n";
        action = "mzJ`z";
      }

      # Centered scrolling
      {
        key = "<C-d>";
        mode = "n";
        action = "<C-d>zz";
      }
      {
        key = "<C-u>";
        mode = "n";
        action = "<C-u>zz";
      }
      {
        key = "n";
        mode = "n";
        action = "nzzzv";
      }
      {
        key = "N";
        mode = "n";
        action = "Nzzzv";
      }

      # Format paragraph
      {
        key = "=ap";
        mode = "n";
        action = "ma=ap'a";
      }

      # LSP restart
      {
        key = "<leader>zig";
        mode = "n";
        action = "<cmd>LspRestart<cr>";
      }

      # LSP mappings
      {
        key = "gd";
        mode = "n";
        action = ":lua vim.lsp.buf.definition()<CR>";
        desc = "Go to definition";
      }
      {
        key = "K";
        mode = "n";
        action = ":lua vim.lsp.buf.hover()<CR>";
        desc = "Hover documentation";
      }
      {
        key = "<leader>vws";
        mode = "n";
        action = ":lua vim.lsp.buf.workspace_symbol()<CR>";
        desc = "Workspace symbol";
      }
      {
        key = "<leader>vd";
        mode = "n";
        action = ":lua vim.diagnostic.open_float()<CR>";
        desc = "Open diagnostic float";
      }
      {
        key = "[d";
        mode = "n";
        action = ":lua vim.diagnostic.goto_next()<CR>";
        desc = "Next diagnostic";
      }
      {
        key = "]d";
        mode = "n";
        action = ":lua vim.diagnostic.goto_prev()<CR>";
        desc = "Previous diagnostic";
      }
      {
        key = "<leader>vca";
        mode = "n";
        action = ":lua vim.lsp.buf.code_action()<CR>";
        desc = "Code action";
      }
      {
        key = "<leader>vrr";
        mode = "n";
        action = ":lua vim.lsp.buf.references()<CR>";
        desc = "References";
      }
      {
        key = "<leader>vrn";
        mode = "n";
        action = ":lua vim.lsp.buf.rename()<CR>";
        desc = "Rename";
      }
      {
        key = "<C-h>";
        mode = "i";
        action = ":lua vim.lsp.buf.signature_help()<CR>";
        desc = "Signature help";
      }

      # Clipboard operations
      {
        key = "<leader>p";
        mode = "x";
        action = "\"_dP";
      }
      {
        key = "<leader>y";
        mode = "n";
        action = "\"+y";
      }
      {
        key = "<leader>y";
        mode = "v";
        action = "\"+y";
      }
      {
        key = "<leader>Y";
        mode = "n";
        action = "\"+Y";
      }
      {
        key = "<leader>d";
        mode = "n";
        action = "\"_d";
      }
      {
        key = "<leader>d";
        mode = "v";
        action = "\"_d";
      }

      # ESC alternative
      {
        key = "<C-c>";
        mode = "i";
        action = "<Esc>";
      }

      # Disable Q
      {
        key = "Q";
        mode = "n";
        action = "<nop>";
      }

      # Tmux sessionizer
      {
        key = "<C-f>";
        mode = "n";
        action = "<cmd>silent !tmux neww tmux-sessionizer<CR>";
      }
      {
        key = "<M-h>";
        mode = "n";
        action = "<cmd>silent !tmux-sessionizer -s 0 --vsplit<CR>";
      }
      {
        key = "<M-H>";
        mode = "n";
        action = "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>";
      }

      # Quickfix navigation
      {
        key = "<C-k>";
        mode = "n";
        action = "<cmd>cnext<CR>zz";
      }
      {
        key = "<C-j>";
        mode = "n";
        action = "<cmd>cprev<CR>zz";
      }
      {
        key = "<leader>k";
        mode = "n";
        action = "<cmd>lnext<CR>zz";
      }
      {
        key = "<leader>j";
        mode = "n";
        action = "<cmd>lprev<CR>zz";
      }

      # Search and replace word under cursor
      {
        key = "<leader>s";
        mode = "n";
        action = ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>";
      }

      # Make file executable
      {
        key = "<leader>x";
        mode = "n";
        action = "<cmd>!chmod +x %<CR>";
        silent = true;
      }

      # Go error handling snippets
      {
        key = "<leader>ee";
        mode = "n";
        action = "oif err != nil {<CR>}<Esc>Oreturn err<Esc>";
      }
      {
        key = "<leader>ea";
        mode = "n";
        action = "oassert.NoError(err, \\\"\\\")<Esc>F\\\";a";
      }
      {
        key = "<leader>ef";
        mode = "n";
        action = "oif err != nil {<CR>}<Esc>Olog.Fatalf(\\\"error: %s\\\\n\\\", err.Error())<Esc>jj";
      }
      {
        key = "<leader>el";
        mode = "n";
        action = "oif err != nil {<CR>}<Esc>O.logger.Error(\\\"error\\\", \\\"error\\\", err)<Esc>F.;i";
      }

      # Cellular automaton
      {
        key = "<leader>ca";
        mode = "n";
        action = ":lua require('cellular-automaton').start_animation('make_it_rain')<CR>";
      }

      # Source config
      {
        key = "<leader><leader>";
        mode = "n";
        action = ":lua vim.cmd('so')<CR>";
      }

      # Plenary test
      {
        key = "<leader>tf";
        mode = "n";
        action = "<Plug>PlenaryTestFile";
        noremap = false;
        silent = false;
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
