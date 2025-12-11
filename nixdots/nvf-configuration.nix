{ pkgs, lib, ... }:
{
  vim = {
    viAlias = true;
    vimAlias = true;
    leaderKey = " ";

    theme = {
      enable = true;
      name = "nord";
      transparent = true;
    };
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;
    navigation.harpoon.enable = true;
    git.vim-fugitive.enable = true;
    autopairs.nvim-autopairs.enable = true;
    utility.undotree.enable = true;
    formatter.conform-nvim.enable = true;
    ui.nvim-highlight-colors.enable = true;
    visuals.nvim-web-devicons.enable = true;
    utility.motion.leap.enable = true;
    visuals.indent-blankline.enable = true;

    keymaps = [
      # Telescope mappings
      {
        key = "<leader>pf";
        mode = "n";
        action = ":lua require('telescope.builtin').find_files()<CR>";
        desc = "Find files";
      }
      {
        key = "<C-p>";
        mode = "n";
        action = ":lua require('telescope.builtin').git_files()<CR>";
        desc = "Git files";
      }
      {
        key = "<leader>pws";
        mode = "n";
        action = ":lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })<CR>";
        desc = "Grep word under cursor";
      }
      {
        key = "<leader>pWs";
        mode = "n";
        action = ":lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cWORD>') })<CR>";
        desc = "Grep WORD under cursor";
      }
      {
        key = "<leader>ps";
        mode = "n";
        action = ":lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep > ') })<CR>";
        desc = "Grep search";
      }
      {
        key = "<leader>vh";
        mode = "n";
        action = ":lua require('telescope.builtin').help_tags()<CR>";
        desc = "Help tags";
      }

      # Harpoon mappings
      {
        key = "<leader>a";
        mode = "n";
        action = ":lua require('harpoon'):list():add()<CR>";
        desc = "Harpoon add file";
      }
      {
        key = "<C-e>";
        mode = "n";
        action = ":lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<CR>";
        desc = "Harpoon quick menu";
      }
      {
        key = "<C-h>";
        mode = "n";
        action = ":lua require('harpoon'):list():select(1)<CR>";
        desc = "Harpoon file 1";
      }
      {
        key = "<C-t>";
        mode = "n";
        action = ":lua require('harpoon'):list():select(2)<CR>";
        desc = "Harpoon file 2";
      }
      {
        key = "<C-n>";
        mode = "n";
        action = ":lua require('harpoon'):list():select(3)<CR>";
        desc = "Harpoon file 3";
      }
      {
        key = "<C-s>";
        mode = "n";
        action = ":lua require('harpoon'):list():select(4)<CR>";
        desc = "Harpoon file 4";
      }
      {
        key = "<C-S-P>";
        mode = "n";
        action = ":lua require('harpoon'):list():prev()<CR>";
        desc = "Harpoon prev";
      }
      {
        key = "<C-S-N>";
        mode = "n";
        action = ":lua require('harpoon'):list():next()<CR>";
        desc = "Harpoon next";
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
      zig.enable = true;
      haskell.enable = true;
    };
  };
}
