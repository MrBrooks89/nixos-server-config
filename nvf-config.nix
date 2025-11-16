{
  config,
  lib,
  ...
}: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        lsp = {
          enable = true;
          formatOnSave = true;
          lspkind.enable = false;
          lightbulb.enable = true;
          lspsaga.enable = false;
          trouble.enable = true;
        };

        highlight = {
          Visual = {
            bg = "#44475a";
            fg = "NONE";
          };
        };

        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;
          nix.enable = true;
          python.enable = true;
          bash.enable = true;
          go.enable = true;
          rust.enable = true;
        };

        filetree.neo-tree.enable = true;
        telescope.enable = true;
        treesitter.enable = true;
        treesitter.context.enable = true;
        autopairs.nvim-autopairs.enable = true;
        snippets.luasnip.enable = true;

        keymaps = [
          {
            key = "jj";
            mode = "i";
            action = "<Esc>";
            silent = true;
            noremap = true;
          }
          {
            key = "y";
            mode = "v";
            action = "\"+y";
            noremap = true;
            silent = true;
          }
          {
            key = "<leader>H";
            mode = "n";
            action = ":let bar = repeat('#', 60) | call append(line('.') - 1, bar) | call append(line('.'), bar)<CR>";
            noremap = true;
            silent = true;
          }
        ];

        spellcheck = {
          enable = true;
        };

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false;
          neogit.enable = true;
        };

        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          modes-nvim.enable = true;
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
          };
          smartcolumn = {
            enable = true;
            setupOpts.custom_colorcolumn = {
              nix = "110";
              go = ["90" "130"];
            };
          };
          fastaction.enable = true;
        };

        visuals = {
          nvim-scrollbar.enable = true;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;
          highlight-undo.enable = true;
          indent-blankline.enable = true;
          cellular-automaton.enable = false;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "dracula";
          };
        };

        theme = {
          enable = true;
          name = "dracula";
          style = "night";
          transparent = false;
        };

        tabline = {
          nvimBufferline.enable = true;
        };

        minimap = {
          minimap-vim.enable = false;
          codewindow.enable = true;
        };

        dashboard = {
          dashboard-nvim.enable = false;
          alpha.enable = true;
        };

        notify = {
          nvim-notify.enable = true;
        };

        notes = {
          obsidian.enable = false;
          neorg.enable = false;
          orgmode.enable = false;
          todo-comments.enable = true;
        };

        session = {
          nvim-session-manager.enable = false;
        };

        gestures = {
          gesture-nvim.enable = false;
        };

        comments = {
          comment-nvim.enable = true;
        };

        presence = {
          neocord.enable = false;
        };

        assistant = {
          chatgpt.enable = false;
          copilot = {
            enable = true;
            cmp.enable = false;
            setupOpts = {
              suggestion = {
                enabled = true;
                auto_trigger = true;
                debounce = 75;
              };
            };
          };
        };

        autocomplete = {
          nvim-cmp.enable = false;
          blink-cmp.enable = true;
        };

        utility = {
          ccc.enable = false;
          vim-wakatime.enable = false;
          diffview-nvim.enable = true;
          yanky-nvim.enable = false;

          motion = {
            hop.enable = true;
            leap.enable = true;
          };
          images = {
            image-nvim.enable = false;
          };
        };
      };
    };
  };
}
