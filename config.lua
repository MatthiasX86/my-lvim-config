--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
--
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "nightfox"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- lvim.builtin.telescope.on_config_done = function()
--   local actions = require "telescope.actions"
--   -- for input mode
--   lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
--   lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
--   lvim.builtin.telescope.defaults.mappings.i["<C-n>"] = actions.cycle_history_next
--   lvim.builtin.telescope.defaults.mappings.i["<C-p>"] = actions.cycle_history_prev
--   -- for normal mode
--   lvim.builtin.telescope.defaults.mappings.n["<C-j>"] = actions.move_selection_next
--   lvim.builtin.telescope.defaults.mappings.n["<C-k>"] = actions.move_selection_previous
-- end

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.dap.active = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

lvim.lang.javascript.linters = { { exe = 'eslint' } }
lvim.lang.javascript.formatting = { { exe = 'prettier' } }
lvim.lang.javascriptreact.linters = { { exe = 'eslint' } }
lvim.lang.javascriptreact.formatting = { { exe = 'prettier' } }


lvim.lang.typescript.linters = { { exe = 'eslint' } }
lvim.lang.typescript.formatting = { { exe = 'prettier' } }
lvim.lang.typescriptreact.linters = { { exe = 'eslint' } }
lvim.lang.typescriptreact.formatting = { { exe = 'prettier' } }

-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end

-- set a formatter if you want to override the default lsp one (if it exists)
-- lvim.lang.python.formatters = {
--   {
--     exe = "black",
--   }
-- }
-- set an additional linter
-- lvim.lang.python.linters = {
--   {
--     exe = "flake8",
--   }
-- }

-- Additional Plugins
lvim.plugins = {
  {"folke/tokyonight.nvim"},

  {
    "ray-x/lsp_signature.nvim",
    config = function() require"lsp_signature".on_attach() end,
    event = "InsertEnter"
  },

  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },

  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    end
  },

  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require'nvim-lastplace'.setup {
        lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
        lastplace_ignore_filetype = {
          "gitcommit", "gitrebase", "svn", "hgcommit"
        },
        lastplace_open_folds = true
      }
    end,
  },

  {
    "kevinhwang91/rnvimr",
    cmd = "Rnvimr",
    config = function()
      -- Make Ranger replace netrw and be the file explorer
      -- vim.g.rnvimr_ex_enable = 1
      vim.g.rnvimr_draw_border = 1
      vim.g.rnvimr_pick_enable = 1
      vim.g.rnvimr_bw_enable = 1
      vim.api.nvim_set_keymap("n", "-", ":RnvimrToggle<CR>", { noremap = true, silent = true })
      require("lv-rnvimr").config()
    end,
  },

  {
    "pwntester/octo.nvim",
      event = "BufRead",
  },

  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd "highlight default link gitblame SpecialComment"
      vim.g.gitblame_enabled = 0
    end,
  },

  {
    "sindrets/diffview.nvim",
    event = "BufRead",
    config = function()
      local cb = require'diffview.config'.diffview_callback

      require('diffview').setup {
        diff_binaries = false,    -- Show diffs for binaries
        file_panel = {
          width = 35,
          use_icons = true        -- Requires nvim-web-devicons
        },
        key_bindings = {
          disable_defaults = false,                   -- Disable the default key bindings
          -- The `view` bindings are active in the diff buffers, only when the current
          -- tabpage is a Diffview.
          view = {
            ["<tab>"]     = cb("select_next_entry"),  -- Open the diff for the next file
            ["<s-tab>"]   = cb("select_prev_entry"),  -- Open the diff for the previous file
            ["<leader>e"] = cb("focus_files"),        -- Bring focus to the files panel
            ["<leader>b"] = cb("toggle_files"),       -- Toggle the files panel.
          },
          file_panel = {
            ["j"]             = cb("next_entry"),         -- Bring the cursor to the next file entry
            ["<down>"]        = cb("next_entry"),
            ["k"]             = cb("prev_entry"),         -- Bring the cursor to the previous file entry.
            ["<up>"]          = cb("prev_entry"),
            ["<cr>"]          = cb("select_entry"),       -- Open the diff for the selected entry.
            ["o"]             = cb("select_entry"),
            ["<2-LeftMouse>"] = cb("select_entry"),
            ["-"]             = cb("toggle_stage_entry"), -- Stage / unstage the selected entry.
            ["S"]             = cb("stage_all"),          -- Stage all entries.
            ["U"]             = cb("unstage_all"),        -- Unstage all entries.
            ["X"]             = cb("restore_entry"),      -- Restore entry to the state on the left side.
            ["R"]             = cb("refresh_files"),      -- Update stats and entries in the file list.
            ["<tab>"]         = cb("select_next_entry"),
            ["<s-tab>"]       = cb("select_prev_entry"),
            ["<leader>e"]     = cb("focus_files"),
            ["<leader>b"]     = cb("toggle_files"),
          }
        }
      }
      vim.api.nvim_set_keymap("n", "<Bslash>d", ":DiffviewOpen<Enter>", { noremap = true, silent = true })
    end
  },

  {
    "tpope/vim-liquid"
  },

  {
    "mattn/emmet-vim"
  },

  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = {"fugitive"}
  },

  {
    "nvim-treesitter/playground",
    event = "BufRead",
  },

  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require('nvim-ts-autotag').setup()
    end
  },

  {
    "p00f/nvim-ts-rainbow",
  },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufRead",
  },

  {
    "nvim-telescope/telescope-fzy-native.nvim",
    run = "make",
  },

  -- {
  --   "folke/lsp-colors.nvim",
  --   event = "BufRead",
  -- },

  {
    "rmagatti/goto-preview",
    config = function()
      require('goto-preview').setup {
        width = 120; -- Width of the floating window
          height = 25; -- Height of the floating window
          default_mappings = true; -- Bind default mappings
          debug = true; -- Print debug information
          opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
          post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
          -- You can use "default_mappings = true" setup option
          -- Or explicitly set keybindings
          -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
          -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
          -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
      }
    end
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "*" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },

  {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  {
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
      require("numb").setup {
        show_numbers = true, -- Enable 'number' for the window while peeking
        show_cursorline = true, -- Enable 'cursorline' for the window while peeking
      }
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },

  {
    "turbio/bracey.vim",
    cmd = {"Bracey", "BracyStop", "BraceyReload", "BraceyEval"},
    run = "npm install --prefix server",
  },

  {
    "npxbr/glow.nvim",
    ft = {"markdown"}
    -- run = "yay -S glow"
  },

  {
    "ahmedkhalf/lsp-rooter.nvim",
    event = "BufRead",
    config = function()
      require("lsp-rooter").setup()
      vim.api.nvim_set_keymap("n", "<Bslash>r", ":rooter<Enter>", { noremap = true, silent = true })
    end,
  },

  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup {}
    end,
    requires = "nvim-lua/plenary.nvim",
  },

  {
    "simrat39/symbols-outline.nvim",
    event = "BufRead",
    cmd = "SymbolsOutline",
    config = function()
      vim.api.nvim_set_keymap("n", "<Bslash>o", ":SymbolsOutline<Enter>", { noremap = true, silent = true })
    end
  },

  {
    "itchyny/vim-cursorword",
      event = {"BufEnter", "BufNewFile"},
      config = function()
        vim.api.nvim_command("augroup user_plugin_cursorword")
        vim.api.nvim_command("autocmd!")
        vim.api.nvim_command("autocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0")
        vim.api.nvim_command("autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif")
        vim.api.nvim_command("autocmd InsertEnter * let b:cursorword = 0")
        vim.api.nvim_command("autocmd InsertLeave * let b:cursorword = 1")
        vim.api.nvim_command("augroup END")
      end
  },

  {
    "tpope/vim-surround",
    event = {"BufEnter", "BufRead"},
    keys = {"c", "d", "y"}
  },

  {
    "metakirby5/codi.vim",
    cmd = "Codi",
  },

  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
        '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,        -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,              -- Function to run after the scrolling animation ends
      })
    end
  },

  {
    "Xuyuanp/scrollbar.nvim",
  },

  {
    "alexaandru/nvim-lspupdate"
  },

  {
    "fladson/vim-kitty"
  },

  {
    "s1n7ax/nvim-comment-frame",
    requires = {
        { 'nvim-treesitter' }
    },
    config = function()
      require('nvim-comment-frame').setup({
        keymap = '<Bslash>c',
        multiline_keymap = '<Bslash>C',
        languages = {
          -- configuration for Lua programming language
          -- @NOTE global configuration will be overridden by language level
          -- configuration if provided
          lua = {
              -- start the comment with this string
              start_str = '--[[',
              -- end the comment line with this string
              end_str = ']]--',
              -- fill the comment frame border with this character
              fill_char = '*',
              -- width of the comment frame
              frame_width = 100,
              -- wrap the line after 'n' characters
              line_wrap_len = 70,
              -- automatically indent the comment frame based on the line
              auto_indent = false,
              -- add comment above the current line
              add_comment_above = false,
          },
        }
      })
    end
  },

  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        window = {
          backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
          -- height and width can be:
          -- * an absolute number of cells when > 1
          -- * a percentage of the width / height of the editor when <= 1
          -- * a function that returns the width or the height
          width = 120, -- width of the Zen window
          height = 1, -- height of the Zen window
          -- by default, no options are changed for the Zen window
          -- uncomment any of the options below, or add other vim.wo options you want to apply
          options = {
            -- signcolumn = "no", -- disable signcolumn
            -- number = false, -- disable number column
            -- relativenumber = false, -- disable relative numbers
            -- cursorline = false, -- disable cursorline
            -- cursorcolumn = false, -- disable cursor column
            -- foldcolumn = "0", -- disable fold column
            -- list = false, -- disable whitespace characters
          },
        },
        plugins = {
          -- disable some global vim options (vim.o...)
          -- comment the lines to not apply the options
          options = {
            enabled = true,
            ruler = false, -- disables the ruler text in the cmd line area
            showcmd = false, -- disables the command in the last line of the screen
          },
          twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
          gitsigns = { enabled = false }, -- disables git signs
          tmux = { enabled = false }, -- disables the tmux statusline
          -- this will change the font size on kitty when in zen mode
          -- to make this work, you need to set the following kitty options:
          -- - allow_remote_control socket-only
          -- - listen_on unix:/tmp/kitty
          kitty = {
            enabled = true,
            font = "+4", -- font size increment
          },
        },
        -- callback where you can add custom code when the Zen window opens
        on_open = function(win)
        end,
        -- callback where you can add custom code when the Zen window closes
        on_close = function()
        end,
      }

      vim.api.nvim_set_keymap("n", "<Bslash>z", ":ZenMode<Enter>", { noremap = true, silent = true })
    end
  },

  {
    "RishabhRD/nvim-lsputils",
    config = function()
    end
  },

  -- {
  --   "savq/melange",
  -- },

  {
    "EdenEast/nightfox.nvim",
    config = function()
      require('lualine').setup {
        options = {
          -- ... your lualine config
          theme = "nightfox"
        }
      }
    end
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup {
        buftype_exclude = {"terminal"}
      }
      vim.g.indent_blankline_space_char = '.'
      vim.g.indent_blankline_show_first_indent_level = false
      vim.g.indent_blankline_use_treesitter = true
      -- might make things a little slower
      vim.g.indent_blankline_show_current_context = true
    end
  },

--   {
--     "vuki656/package-info.nvim",
--     config = function()
--       require('package-info').setup()
--       -- Display latest versions as virtual text
--       vim.api.nvim_set_keymap("n", "<Bslash>ns", "<cmd>lua require('package-info').show()<cr>",
--         { silent = true, noremap = true }
--       )

--       -- Clear package info virtual text
--       vim.api.nvim_set_keymap("n", "<Bslash>nc", "<cmd>lua require('package-info').hide()<cr>",
--         { silent = true, noremap = true }
--       )
--     end
--   },

  {
    'sudormrfbin/cheatsheet.nvim',
    requires = {
      {'nvim-telescope/telescope.nvim'},
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
    },
    config = function()
      require("cheatsheet").setup({
          -- Whether to show bundled cheatsheets

          -- For generic cheatsheets like default, unicode, nerd-fonts, etc
          bundled_cheatsheets = true,
          -- bundled_cheatsheets = {
          --     enabled = {},
          --     disabled = {},
          -- },

          -- For plugin specific cheatsheets
          bundled_plugin_cheatsheets = true,
          -- bundled_plugin_cheatsheets = {
          --     enabled = {},
          --     disabled = {},
          -- }

          -- For bundled plugin cheatsheets, do not show a sheet if you
          -- don't have the plugin installed (searches runtimepath for
          -- same directory name)
          include_only_installed_plugins = true,
      })
      vim.api.nvim_set_keymap("n", "<Bslash>h", ":Cheatsheet<Enter>",
        { silent = true, noremap = true }
      )
    end
  },

  {
    "aca/emmet-ls",
    config = function()
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig/configs")

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      }

      if not lspconfig.emmet_ls then
        configs.emmet_ls = {
          default_config = {
            cmd = { "emmet-ls", "--stdio" },
            filetypes = {
              "html",
              "css",
              "javascript",
              "typescript",
              "eruby",
              "typescriptreact",
              "javascriptreact",
              "svelte",
              "vue",
            },
            root_dir = function(fname)
              return vim.loop.cwd()
            end,
            settings = {},
          },
        }
      end
      lspconfig.emmet_ls.setup({ capabilities = capabilities })
    end,
  },

  {
    'michaelb/sniprun',
    run = 'bash ./install.sh',
    config = function()
      require("sniprun").setup({
        selected_interpreters = {},     --# use those instead of the default for the current filetype
        repl_enable = {},               --# enable REPL-like behavior for the given interpreters
        repl_disable = {},              --# disable REPL-like behavior for the given interpreters

        interpreter_options = {},       --# intepreter-specific options, consult docs / :SnipInfo <name>

        --# you can combo different display modes as desired
        display = {
          "Classic",                    --# display results in the command-line  area
          "VirtualTextOk",              --# display ok results as virtual text (multiline is shortened)

          -- "VirtualTextErr",          --# display error results as virtual text
          -- "TempFloatingWindow",      --# display results in a floating window
          -- "LongTempFloatingWindow",  --# same as above, but only long results. To use with VirtualText__
          -- "Terminal",                --# display results in a vertical split
          -- "NvimNotify",              --# display with the nvim-notify plugin
          -- "Api"                      --# return output to a programming interface
        },

        --# You can use the same keys to customize whether a sniprun producing
        --# no output should display nothing or '(no output)'
        show_no_output = {
          "Classic",
          "TempFloatingWindow",      --# implies LongTempFloatingWindow, which has no effect on its own
        },

        --# customize highlight groups (setting this overrides colorscheme)
        snipruncolors = {
          SniprunVirtualTextOk   =  {bg="#66eeff",fg="#000000",ctermbg="Cyan",cterfg="Black"},
          SniprunFloatingWinOk   =  {fg="#66eeff",ctermfg="Cyan"},
          SniprunVirtualTextErr  =  {bg="#881515",fg="#000000",ctermbg="DarkRed",cterfg="Black"},
          SniprunFloatingWinErr  =  {fg="#881515",ctermfg="DarkRed"},
        },

        --# miscellaneous compatibility/adjustement settings
        inline_messages = 0,             --# inline_message (0/1) is a one-line way to display messages
                 --# to workaround sniprun not being able to display anything

        borders = 'single'               --# display borders around floating windows
                                         --# possible values are 'none', 'single', 'double', or 'shadow'
      })
    end,
  },

}

require'lspconfig'.tailwindcss.setup{}
require'lspconfig'.cssmodules_ls.setup{}


-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

