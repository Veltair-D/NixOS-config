{
  pkgs,
  inputs,
  lib,
  ...
}: {
  programs.nvf = {
    enable = true;

    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;
        lsp = {
          enable = true;
          formatOnSave = true;
          inlayHints.enable = true;
          lightbulb.enable = true;
        };
        languages = {
          enableExtraDiagnostics = true;
          enableFormat = true;
          enableTreesitter = true;
          bash = {
            enable = true;
            extraDiagnostics.enable = true;
            format.enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
          clang = {
            enable = true;
            cHeader = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
          lua = {
            enable = true;
            extraDiagnostics.enable = true;
            format.enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
          markdown = {
            enable = true;
            extensions.markview-nvim.enable = true;
            extensions.render-markdown-nvim.enable = true;
            extraDiagnostics.enable = true;
            format.enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
          nix = {
            enable = true;
            extraDiagnostics.enable = true;
            format.enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
          python = {
            enable = true;
            format.enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
          rust = {
            enable = true;
            crates.enable = true;
            format.enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
        };
        autocomplete = {
          enableSharedCmpSources = true;
          blink-cmp = {
            enable = true;
            friendly-snippets.enable = true;
            mappings = {
              close = "<C-e>";
              complete = "<C-Space>";
              confirm = "<CR>";
              next = "<Tab>";
              previous = "<S-Tab>";
              scrollDocsDown = "<C-f>";
              scrollDocsUp = "<C-d>";
            };
            setupOpts = {
              completion = {
                documentation.auto_show = true;
                menu.auto_show = true;
              };
              sources = {
                default = [
                  "lsp"
                  "path"
                  "snippets"
                  "buffer"
                ];
              };
            };
            sourcePlugins = {
              emoji.enable = true;
              ripgrep.enable = true;
              spell.enable = true;
            };
          };
        };
        binds = {
          cheatsheet.enable = true;
          whichKey.enable = true;
        };
        clipboard = {
          enable = true;
          providers.wl-copy.enable = true;
          registers = "unnamedplus";
        };
        dashboard.alpha = {
          enable = true;
          theme = "dashboard";
        };
        diagnostics = {
          enable = true;
          config = {
            virtual_lines = true;
            virtual_text = {
              format = lib.generators.mkLuaInline ''
                function(diagnostic)
                  return string.format("%s (%s)", diagnostic.message, diagnostic.source)
                end
              '';
            };
          };
          nvim-lint = {
            enable = true;
          };
        };
        extraPlugins = with pkgs.vimPlugins; {};
        filetree = {
          neo-tree = {
            enable = true;
            setupOpts = {
              enable_cursor_hijack = true;
              enable_diagnostics = true;
            };
          };
        };
        formatter.conform-nvim = {
          enable = true;
          setupOpts = {
            formatters_by_ft = {
              lua = [
                "stylua"
              ];
              cpp = [
                "clang-format"
              ];
              python = [
                "black"
              ];
              markdown = [
                "mdformat"
                "markdownfmt"
              ];
              nix = [
                "nixfmt"
              ];
              rust = [
                "rustfmt"
              ];
            };
          };
        };
        fzf-lua = {
          enable = true;
        };
        git.enable = true;
        globals = {
          hideSearchHighlight = true;
        };
        keymaps = [
          {
            key = "<leader>m";
            desc = "";
            mode = "n";
            silent = true;
            action = ":make<CR>";
            expr = false;
            lua = false;
            noremap = true;
            nowait = false;
            script = false;
            unique = false;
          }
          {
            key = "<leader>l";
            mode = ["n" "x"];
            silent = true;
            action = "<cmd>cnext<CR>";
          }
        ];
        lazy = {
          enable = true;
          #Plugins to lazy load
          plugins = {
            rose-pine = {
              enabled = true;
              package = "rose-pine";
              colorscheme = "rose-pine";
            };
          };
        };
        luaPackages = [
          "magick"
          "serpent"
        ];
        navigation.harpoon = {
          enable = true;
          mappings = {
            file1 = "<C-n>";
            file2 = "<C-e>";
            file3 = "<C-i>";
            file4 = "<C-o";
            listMarks = "<C-h>";
            markFile = "<C-H>";
          };
        };
        notes = {
          obsidian.enable = true;
          todo-comments = {
            enable = true;
            mappings = {
              quickFix = "<leader>tdq";
              telescope = "<leader>tds";
            };
          };
        };
        notify.nvim-notify.enable = true;
        options = {
          autoindent = true;
          cursorlineopt = "both";
          shiftwidth = 4;
          tabstop = 4;
        };
        searchCase = "smart";
        spellcheck = {
          enable = true;
          extraSpellWords = {
            "en.utf-8" = ["nvf" "word_you_want_to_add"];
          };
        };
      };
    };
  };
}
