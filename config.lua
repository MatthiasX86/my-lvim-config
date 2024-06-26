--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "catppuccin"

vim.g.catppuccin_flavour = "mocha"
-- vim.cmd [[colorscheme catppuccin]]
-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
-- lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
-- lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.treesitter.rainbow.enable = true

lvim.lsp.installer.setup.automatic_installation = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

lvim.builtin.which_key.setup.plugins.presets.z = true

vim.api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = true, silent = true })

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheReset` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--no-semi" },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact" },
  },
}

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--severity", "warning" },
  },
  {
    command = "codespell",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "python" },
  },
  {
    command = "eslint",
    filetypes = { "typescript", "typescriptreact" }
  }
}

-- Additional Plugins
lvim.plugins = {
  {
    "folke/tokyonight.nvim",
    config = function()
      vim.g.tokyonight_style = "day"
      vim.g.tokyonight_italic_functions = true
      vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

      require('lualine').setup {
        options = {
          theme = 'tokyonight'
        }
      }
    end
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      vim.g.catppuccin_flavour = "mocha"

      require("catppuccin").setup({
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        transparent_background = false,
        term_colors = false,
        compile = {
          enabled = false,
          path = vim.fn.stdpath "cache" .. "/catppuccin",
        },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        integrations = {
          treesitter = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
          coc_nvim = false,
          lsp_trouble = true,
          cmp = true,
          lsp_saga = false,
          gitgutter = true,
          gitsigns = true,
          leap = false,
          telescope = true,
          nvimtree = {
            enabled = true,
            show_root = true,
            transparent_panel = false,
          },
          neotree = {
            enabled = false,
            show_root = true,
            transparent_panel = false,
          },
          dap = {
            enabled = false,
            enable_ui = false,
          },
          which_key = false,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = true,
          },
          dashboard = true,
          neogit = false,
          vim_sneak = true,
          fern = false,
          barbar = false,
          bufferline = true,
          markdown = true,
          lightspeed = false,
          ts_rainbow = true,
          hop = true,
          notify = true,
          telekasten = true,
          symbols_outline = true,
          mini = false,
          aerial = false,
          vimwiki = true,
          beacon = true,
          navic = false,
          overseer = false,
        },
        color_overrides = {},
        highlight_overrides = {},
      })

      vim.cmd [[colorscheme catppuccin]]
    end
  },

  {
    "EdenEast/nightfox.nvim",
    config = function()
      -- Default options
      require('nightfox').setup({
        options = {
          -- Compiled file's destination location
          compile_path = vim.fn.stdpath("cache") .. "/nightfox",
          compile_file_suffix = "_compiled", -- Compiled file suffix
          transparent = false,               -- Disable setting background
          terminal_colors = true,            -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
          dim_inactive = false,              -- Non focused panes set to alternative background
          -- styles = { -- Style to be applied to different syntax groups
          --   comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
          --   conditionals = "NONE",
          --   constants = "NONE",
          --   functions = "NONE",
          --   keywords = "NONE",
          --   numbers = "NONE",
          --   operators = "NONE",
          --   strings = "NONE",
          --   types = "NONE",
          --   variables = "NONE",
          -- },
          inverse = {
            -- Inverse highlight for different types
            match_paren = false,
            visual = false,
            search = false,
          },
          modules = { -- List of various plugins and additional options
            -- ...
          },
        },
        palettes = {},
        specs = {},
        groups = {},
      })

      -- setup must be called before loading
      vim.cmd("colorscheme duskfox")
    end
  },

  -- {
  --   "ray-x/lsp_signature.nvim",
  --   config = function()
  --     require "lsp_signature".on_attach()
  --   end,
  --   event = { "InsertEnter" }
  -- },

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
      require 'nvim-lastplace'.setup {
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
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
    "mattn/emmet-vim",
    config = function()
      local lspconfig = require('lspconfig')
      local configs = require('lspconfig/configs')
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      lspconfig.emmet_ls.setup({
        -- on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
      })
    end
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
    ft = { "fugitive" }
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

  -- {
  --   "p00f/nvim-ts-rainbow",
  -- },

  -- {
  --   "JoosepAlviste/nvim-ts-context-commentstring",
  --   event = "BufRead",
  -- },

  {
    "nvim-telescope/telescope-fzy-native.nvim",
    build = "make",
  },

  -- {
  --   "folke/lsp-colors.nvim",
  --   event = "BufRead",
  -- },

  {
    "rmagatti/goto-preview",
    config = function()
      require('goto-preview').setup {
        width = 120,             -- Width of the floating window
        height = 25,             -- Height of the floating window
        default_mappings = true, -- Bind default mappings
        debug = true,            -- Print debug information
        opacity = nil,           -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil     -- A function taking two arguments, a buffer and a window to be ran as a hook.
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
        RGB = true,      -- #RGB hex codes
        RRGGBB = true,   -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true,   -- CSS rgb() and rgba() functions
        hsl_fn = true,   -- CSS hsl() and hsla() functions
        css = true,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },

  -- {
  -- "andymass/vim-matchup",
  -- event = "cursormoved",
  -- config = function()
  -- vim.g.matchup_matchparen_offscreen = { method = "popup" }
  -- end,
  -- },

  {
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
      require("numb").setup {
        show_numbers = true,    -- Enable 'number' for the window while peeking
        show_cursorline = true, -- Enable 'cursorline' for the window while peeking
      }
    end,
  },

  -- {
  --   "iamcco/markdown-preview.nvim",
  --   build = "cd app && npm install",
  --   ft = "markdown",
  --   config = function()
  --     vim.g.mkdp_auto_start = 1
  --   end,
  -- },

  -- {
  --   "turbio/bracey.vim",
  --   cmd = { "Bracey", "BracyStop", "BraceyReload", "BraceyEval" },
  --   build = "npm install --prefix server",
  -- },

  {
    "npxbr/glow.nvim",
    ft = { "markdown" }
    -- build = "yay -S glow"
  },

  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup {}
    end,
    dependencies = "nvim-lua/plenary.nvim",
  },

  {
    "simrat39/symbols-outline.nvim",
    event = "BufRead",
    cmd = "SymbolsOutline",
    config = function()
      require("symbols-outline").setup {}
      vim.api.nvim_set_keymap("n", "<Bslash>os", ":SymbolsOutline<Enter>", { noremap = true, silent = true })
    end
  },

  {
    "itchyny/vim-cursorword",
    event = { "BufEnter", "BufNewFile" },
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
    event = { "BufEnter", "BufRead" },
    keys = { "c", "d", "y" }
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
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,       -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
      })
    end
  },

  {
    "petertriho/nvim-scrollbar",
    dependencies = "kevinhwang91/nvim-hlslens",
    config = function()
      require("scrollbar").setup({
        show = true,
        set_highlights = true,
        handle = {
          text = " ",
          color = nil,
          cterm = nil,
          highlight = "CursorColumn",
          hide_if_all_visible = true, -- Hides handle if all lines are visible
        },
        marks = {
          Search = {
            text = { "-", "=" },
            priority = 0,
            color = nil,
            cterm = nil,
            highlight = "Search",
          },
          Error = {
            text = { "-", "=" },
            priority = 1,
            color = nil,
            cterm = nil,
            highlight = "DiagnosticVirtualTextError",
          },
          Warn = {
            text = { "-", "=" },
            priority = 2,
            color = nil,
            cterm = nil,
            highlight = "DiagnosticVirtualTextWarn",
          },
          Info = {
            text = { "-", "=" },
            priority = 3,
            color = nil,
            cterm = nil,
            highlight = "DiagnosticVirtualTextInfo",
          },
          Hint = {
            text = { "-", "=" },
            priority = 4,
            color = nil,
            cterm = nil,
            highlight = "DiagnosticVirtualTextHint",
          },
          Misc = {
            text = { "-", "=" },
            priority = 5,
            color = nil,
            cterm = nil,
            highlight = "Normal",
          },
        },
        excluded_buftypes = {
          "terminal",
        },
        excluded_filetypes = {
          "prompt",
          "TelescopePrompt",
        },
        autocmd = {
          render = {
            "BufWinEnter",
            "TabEnter",
            "TermEnter",
            "WinEnter",
            "CmdwinLeave",
            "TextChanged",
            "VimResized",
            "WinScrolled",
          },
        },
        handlers = {
          diagnostic = true,
          search = false, -- Requires hlslens to be loaded, will run require("scrollbar.handlers.search").setup() for you
        },
      })
      require("scrollbar.handlers.search").setup()
    end
  },

  -- enable when neovim 0.10 is out
  -- {
  --   "lewis6991/satellite.nvim",
  --   config = function()
  --     require('satellite').setup {
  --       current_only = false,
  --       winblend = 50,
  --       zindex = 40,
  --       excluded_filetypes = {},
  --       width = 2,
  --       handlers = {
  --         cursor = {
  --           enable = true,
  --           -- Supports any number of symbols
  --           symbols = { '⎺', '⎻', '⎼', '⎽' }
  --           -- symbols = { '⎻', '⎼' }
  --           -- Highlights:
  --           -- - SatelliteCursor (default links to NonText
  --         },
  --         search = {
  --           enable = true,
  --           -- Highlights:
  --           -- - SatelliteSearch (default links to Search)
  --           -- - SatelliteSearchCurrent (default links to SearchCurrent)
  --         },
  --         diagnostic = {
  --           enable = true,
  --           signs = { '-', '=', '≡' },
  --           min_severity = vim.diagnostic.severity.HINT,
  --           -- Highlights:
  --           -- - SatelliteDiagnosticError (default links to DiagnosticError)
  --           -- - SatelliteDiagnosticWarn (default links to DiagnosticWarn)
  --           -- - SatelliteDiagnosticInfo (default links to DiagnosticInfo)
  --           -- - SatelliteDiagnosticHint (default links to DiagnosticHint)
  --         },
  --         gitsigns = {
  --           enable = true,
  --           signs = { -- can only be a single character (multibyte is okay)
  --             add = "│",
  --             change = "│",
  --             delete = "-",
  --           },
  --           -- Highlights:
  --           -- SatelliteGitSignsAdd (default links to GitSignsAdd)
  --           -- SatelliteGitSignsChange (default links to GitSignsChange)
  --           -- SatelliteGitSignsDelete (default links to GitSignsDelete)
  --         },
  --         marks = {
  --           enable = true,
  --           show_builtins = false, -- shows the builtin marks like [ ] < >
  --           key = 'm'
  --           -- Highlights:
  --           -- SatelliteMark (default links to Normal)
  --         },
  --         quickfix = {
  --           signs = { '-', '=', '≡' },
  --           -- Highlights:
  --           -- SatelliteQuickfix (default links to WarningMsg)
  --         }
  --       },
  --     }
  --   end
  -- },

  {
    "fladson/vim-kitty"
  },

  {
    "s1n7ax/nvim-comment-frame",
    dependencies = {
      { 'nvim-treesitter' }
    },
    config = function()
      require('nvim-comment-frame').setup({
        keymap = '<Bslash>dc',
        multiline_keymap = '<Bslash>dC',
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
          height = 1,  -- height of the Zen window
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
            ruler = false,               -- disables the ruler text in the cmd line area
            showcmd = false,             -- disables the command in the last line of the screen
          },
          twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
          gitsigns = { enabled = true }, -- disables git signs
          tmux = { enabled = false },    -- disables the tmux statusline
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
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup {
        buftype_exclude = { "terminal" }
      }
      vim.g.indent_blankline_space_char = '.'
      vim.g.indent_blankline_show_first_indent_level = false
      vim.g.indent_blankline_use_treesitter = true
      -- might make things a little slower
      vim.g.indent_blankline_show_current_context = true
    end
  },

  -- {
  --   'hoob3rt/lualine.nvim',
  --   config = function()
  --     require('lualine').setup {
  --       options = {
  --         theme = 'horizon',
  --         lower = true,
  --         upper = true,
  --       },
  --     }
  --   end,
  --   dependencies = { 'kyazdani42/nvim-web-devicons', opt = true }
  -- },

  {
    "vuki656/package-info.nvim",
    dependencies = "MunifTanjim/nui.nvim",
  },

  {
    'sudormrfbin/cheatsheet.nvim',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
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
      -- vim.api.nvim_set_keymap("n", "<Bslash>h", ":Cheatsheet<Enter>", { silent = true, noremap = true })
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
    "michaelb/sniprun",
    build = 'bash ./install.sh',
    config = function()
      require('sniprun').setup({
        selected_interpreters = { "JS_TS_bun" },
        repl_enable = { "JS_TS_bun" }
      })

      vim.api.nvim_set_keymap("v", "<Bslash>sr", ":'<,'>SnipRun<Enter>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<Bslash>ssc", ":SnipClose<Enter>", { noremap = true, silent = true })
    end
  },

  {
    "luukvbaal/stabilize.nvim",
    config = function() require("stabilize").setup() end
  },

  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require 'treesitter-context'.setup {
        enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0,   -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = {
          -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'class',
            'function',
            'method',
            -- 'for', -- These won't appear in the context
            -- 'while',
            -- 'if',
            -- 'switch',
            -- 'case',
          },
          -- Example for a specific filetype.
          -- If a pattern is missing, *open a PR* so everyone can benefit.
          --   rust = {
          --       'impl_item',
          --   },
        },
        exact_patterns = {
          -- Example for a specific filetype with Lua patterns
          -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
          -- exactly match "impl_item" only)
          -- rust = true,
        }
      }
    end
  },

  -- {
  --   "edluffy/specs.nvim",
  --   config = function()
  --     require('specs').setup {
  --       show_jumps       = true,
  --       min_jump         = 30,
  --       popup            = {
  --         delay_ms = 0, -- delay before popup displays
  --         inc_ms = 10,  -- time increments used for fade/resize effects
  --         blend = 10,   -- starting blend, between 0-100 (fully transparent), see :h winblend
  --         width = 10,
  --         winhl = "pulse_fader",
  --         fader = require('specs').linear_fader,
  --         resizer = require('specs').shrink_resizer
  --       },
  --       ignore_filetypes = {},
  --       ignore_buftypes  = {
  --         nofile = true,
  --       },
  --     }
  --   end
  -- },

  {
    'tanvirtin/vgit.nvim',
    config = function()
      require('vgit').setup()
      vim.api.nvim_set_keymap("n", "<Bslash>gbd", ":VGit buffer_diff_preview<Enter>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<Bslash>gbh", ":VGit buffer_history_preview<Enter>",
        { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<Bslash>gbp", ":VGit buffer_blame_preview<Enter>", { noremap = true, silent = true })
    end,
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  {
    "davidgranstrom/nvim-markdown-preview",
    config = function()
      vim.api.nvim_set_keymap("n", "<Bslash>mp", ":MarkdownPreview<Enter>", { noremap = true, silent = true })
    end
  },

  {
    "jamestthompson3/nvim-remote-containers",
    -- look into the docs, there is a way to set current container to statusline
  },

  {
    "sindrets/winshift.nvim",
    config = function()
      require("winshift").setup({
        highlight_moving_win = true, -- Highlight the window being moved
        focused_hl_group = "Visual", -- The highlight group used for the moving window
        moving_win_options = {
          -- These are local options applied to the moving window while it's
          -- being moved. They are unset when you leave Win-Move mode.
          wrap = false,
          cursorline = false,
          cursorcolumn = false,
          colorcolumn = "",
        },
        -- The window picker is used to select a window while swapping windows with
        -- ':WinShift swap'.
        -- A string of chars used as identifiers by the window picker.
        window_picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        window_picker_ignore = {
          -- This table allows you to indicate to the window picker that a window
          -- should be ignored if its buffer matches any of the following criteria.
          filetype = { -- List of ignored file types
            "NvimTree",
          },
          buftype = { -- List of ignored buftypes
            "terminal",
            "quickfix",
          },
          bufname = { -- List of regex patterns matching ignored buffer names
            [[.*foo/bar/baz\.qux]]
          },
        },
      })
      vim.api.nvim_set_keymap("n", "<Bslash>ws", ":WinShift swap<Enter>", { noremap = true, silent = true })

      vim.api.nvim_set_keymap("n", "<Bslash>wh", ":WinShift left<Enter>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<Bslash>w<S-h>", ":WinShift far_left<Enter>", { noremap = true, silent = true })

      vim.api.nvim_set_keymap("n", "<Bslash>wl", ":WinShift right<Enter>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<Bslash>w<S-l>", ":WinShift far_right<Enter>", { noremap = true, silent = true })

      vim.api.nvim_set_keymap("n", "<Bslash>wj", ":WinShift down<Enter>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<Bslash>w<S-j>", ":WinShift far_down<Enter>", { noremap = true, silent = true })

      vim.api.nvim_set_keymap("n", "<Bslash>wk", ":WinShift up<Enter>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<Bslash>w<S-k>", ":WinShift far_up<Enter>", { noremap = true, silent = true })
    end
  },


  {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require("hlslens").setup()
    end,
  },

  {
    'gelguy/wilder.nvim',
    config = function()
      -- config goes here
    end,
  },

  -- {
  --   "NTBBloodbath/rest.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     require("rest-nvim").setup({
  --       -- Open request results in a horizontal split
  --       result_split_horizontal = false,
  --       -- Keep the http file buffer above|left when split horizontal|vertical
  --       result_split_in_place = false,
  --       -- Skip SSL verification, useful for unknown certificates
  --       skip_ssl_verification = false,
  --       -- Highlight request on run
  --       highlight = {
  --         enabled = true,
  --         timeout = 150,
  --       },
  --       result = {
  --         -- toggle showing URL, HTTP info, headers at top the of result window
  --         show_url = true,
  --         show_http_info = true,
  --         show_headers = true,
  --       },
  --       -- Jump to request line on run
  --       jump_to_request = false,
  --       env_file = '.env',
  --       custom_dynamic_variables = {},
  --       yank_dry_run = true,
  --     })
  --     vim.api.nvim_set_keymap("n", "<Bslash>rr", "<Plug>RestNvim", { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap("n", "<Bslash>rp", "<Plug>RestNvimPreview", { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap("n", "<Bslash>rl", "<Plug>RestNvimLast", { noremap = true, silent = true })
  --   end
  -- },

  {
    "nanotee/sqls.nvim",
    config = function()
      require 'lspconfig'.sqls.setup {
        on_attach = function(client, bufnr)
          require('sqls').on_attach(client, bufnr)
        end
      }
    end
  },

  {
    "mzarnitsa/psql",
    config = function()
      require('psql').setup({
        database_name     = 'postgres',
        execute_line      = '<Bslash>pl',
        execute_selection = '<Bslash>ps',
        execute_paragraph = '<Bslash>pp',
        -- close_latest_result = '<Bslash>p',
        close_all_results = '<Bslash>pc',
      })
    end
  },

  {
    'tzachar/cmp-tabnine',
    config = function()
      local tabnine = require('cmp_tabnine.config')
      tabnine:setup({
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = '..',
        ignored_file_types = { -- default is not to ignore
          -- uncomment to ignore in lua:
          -- lua = true
        },
        show_prediction_strength = false,
      })
    end,
    build = './install.sh',
    dependencies = 'hrsh7th/nvim-cmp'
  },

  -- {
  --   'tpope/vim-fugitive',
  -- },

  {
    'junegunn/gv.vim',
    dependencies = 'tpope/vim-fugitive',
    config = function()
      vim.api.nvim_set_keymap("n", "<Bslash>gl", ":GV<Enter>", { noremap = true, silent = true })
    end
  },

  {
    'Pocco81/HighStr.nvim',
    config = function()
      vim.api.nvim_set_keymap("v", "<Bslash>h1", ":<c-u>HSHighlight 1<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("v", "<Bslash>h2", ":<c-u>HSHighlight 2<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("v", "<Bslash>h3", ":<c-u>HSHighlight 3<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("v", "<Bslash>h4", ":<c-u>HSHighlight 4<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("v", "<Bslash>h5", ":<c-u>HSHighlight 5<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("v", "<Bslash>h6", ":<c-u>HSHighlight 6<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("v", "<Bslash>h7", ":<c-u>HSHighlight 7<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("v", "<Bslash>h8", ":<c-u>HSHighlight 8<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("v", "<Bslash>h9", ":<c-u>HSHighlight 9<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<Bslash>hrr", ":HSRmHighlight<Enter>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<Bslash>hra", ":HSRmHighlight rm_all<Enter>", { noremap = true, silent = true })
    end
  },

  {
    "glacambre/firenvim",
    build = function()
      vim.fn['firenvim#install'](0)
    end
  },

  {
    "haringsrob/nvim_context_vt",
    config = function()
      require('nvim_context_vt').setup({
        -- Enable by default. You can disable and use :NvimContextVtToggle to maually enable.
        -- Default: true
        enabled = true,
        -- Override default virtual text prefix
        -- Default: '-->'
        prefix = '',
        -- Override the internal highlight group name
        -- Default: 'ContextVt'
        highlight = 'CustomContextVt',
        -- Disable virtual text for given filetypes
        -- Default: { 'markdown' }
        disable_ft = { 'markdown' },
        -- Disable display of virtual text below blocks for indentation based languages like Python
        -- Default: false
        disable_virtual_lines = false,
        -- Same as above but only for spesific filetypes
        -- Default: {}
        disable_virtual_lines_ft = { 'yaml' },
        -- How many lines required after starting position to show virtual text
        -- Default: 1 (equals two lines total)
        min_rows = 1,
        -- Same as above but only for spesific filetypes
        -- Default: {}
        min_rows_ft = {},
      })
    end
  },

  {
    'bennypowers/nvim-regexplainer',
    config = function()
      require 'regexplainer'.setup()
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'MunifTanjim/nui.nvim',
    }
  },

  { 'tikhomirov/vim-glsl' },

  { 'timtro/glslView-nvim', ft = 'glsl' },

  {
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
        lsp = {
          hover = {
            enabled = false
          },
          signature = {
            enable = true
          }
        }
      })
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
      "nvim-treesitter/nvim-treesitter"
    }
  },

  -- 6/2/24: disable
  -- {
  --   "stevearc/overseer.nvim",
  --   config = function()
  --     require('overseer').setup()
  --     vim.api.nvim_set_keymap("n", "<Bslash>oor", ":OverseerRunCmd ", { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap("n", "<Bslash>oot", ":OverseerToggle<Enter>", { noremap = true, silent = true })
  --   end
  -- },

  {
    'simrat39/rust-tools.nvim',
    config = function()
      local opts = {
        tools = {
          -- rust-tools options

          -- how to execute terminal commands
          -- options right now: termopen / quickfix
          executor = require("rust-tools.executors").termopen,
          -- callback to execute once rust-analyzer is done initializing the workspace
          -- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
          on_initialized = nil,
          -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
          reload_workspace_from_cargo_toml = true,
          -- These apply to the default RustSetInlayHints command
          inlay_hints = {
            -- automatically set inlay hints (type hints)
            -- default: true
            auto = true,
            -- Only show inlay hints for the current line
            only_current_line = false,
            -- whether to show parameter hints with the inlay hints or not
            -- default: true
            show_parameter_hints = true,
            -- prefix for parameter hints
            -- default: "<-"
            parameter_hints_prefix = "<- ",
            -- prefix for all the other hints (type, chaining)
            -- default: "=>"
            other_hints_prefix = "=> ",
            -- whether to align to the length of the longest line in the file
            max_len_align = false,
            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,
            -- whether to align to the extreme right or not
            right_align = false,
            -- padding from the right if right_align is true
            right_align_padding = 7,
            -- The color of the hints
            highlight = "Comment",
          },
          -- options same as lsp hover / vim.lsp.util.open_floating_preview()
          hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
              { "╭", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╮", "FloatBorder" },
              { "│", "FloatBorder" },
              { "╯", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╰", "FloatBorder" },
              { "│", "FloatBorder" },
            },
            -- Maximal width of the hover window. Nil means no max.
            max_width = nil,
            -- Maximal height of the hover window. Nil means no max.
            max_height = nil,
            -- whether the hover action window gets automatically focused
            -- default: false
            auto_focus = false,
          },
          -- settings for showing the crate graph based on graphviz and the dot
          -- command
          crate_graph = {
            -- Backend used for displaying the graph
            -- see: https://graphviz.org/docs/outputs/
            -- default: x11
            backend = "x11",
            -- where to store the output, nil for no output stored (relative
            -- path from pwd)
            -- default: nil
            output = nil,
            -- true for all crates.io and external crates, false only the local
            -- crates
            -- default: true
            full = true,
            -- List of backends found on: https://graphviz.org/docs/outputs/
            -- Is used for input validation and autocompletion
            -- Last updated: 2021-08-26
            enabled_graphviz_backends = {
              "bmp",
              "cgimage",
              "canon",
              "dot",
              "gv",
              "xdot",
              "xdot1.2",
              "xdot1.4",
              "eps",
              "exr",
              "fig",
              "gd",
              "gd2",
              "gif",
              "gtk",
              "ico",
              "cmap",
              "ismap",
              "imap",
              "cmapx",
              "imap_np",
              "cmapx_np",
              "jpg",
              "jpeg",
              "jpe",
              "jp2",
              "json",
              "json0",
              "dot_json",
              "xdot_json",
              "pdf",
              "pic",
              "pct",
              "pict",
              "plain",
              "plain-ext",
              "png",
              "pov",
              "ps",
              "ps2",
              "psd",
              "sgi",
              "svg",
              "svgz",
              "tga",
              "tiff",
              "tif",
              "tk",
              "vml",
              "vmlz",
              "wbmp",
              "webp",
              "xlib",
              "x11",
            },
          },
        },
        -- all the opts to send to nvim-lspconfig
        -- these override the defaults set by rust-tools.nvim
        -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
        server = {
          -- standalone file support
          -- setting it to false may improve startup time
          standalone = true,
        }, -- rust-analyzer options
        -- debugging stuff
        dap = {
          adapter = {
            type = "executable",
            command = "lldb-vscode",
            name = "rt_lldb",
          },
        },
      }

      require('rust-tools').setup(opts)
    end,
    dependencies = {
      "neovim/nvim-lspconfig",
      'nvim-lua/plenary.nvim',
      'mfussenegger/nvim-dap'
    }
  },

  {
    "lewis6991/hover.nvim",
    config = function()
      require("hover").setup {
        init = function()
          -- Require providers
          require("hover.providers.lsp")
          require('hover.providers.gh')
          require('hover.providers.gh_user')
          -- require('hover.providers.jira')
          require('hover.providers.man')
          require('hover.providers.dictionary')
        end,
        preview_opts = {
          border = nil
        },
        -- Whether the contents of a currently open hover window should be moved
        -- to a :h preview-window when pressing the hover keymap.
        preview_window = true,
        title = true
      }

      -- Setup keymaps
      vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
      vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
    end
  },

  {
    "Bryley/neoai.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    cmd = {
      "NeoAI",
      "NeoAIOpen",
      "NeoAIClose",
      "NeoAIToggle",
      "NeoAIContext",
      "NeoAIContextOpen",
      "NeoAIContextClose",
      "NeoAIInject",
      "NeoAIInjectCode",
      "NeoAIInjectContext",
      "NeoAIInjectContextCode",
    },
    keys = {
      { "<leader>as", desc = "summarize text" },
      { "<leader>ag", desc = "generate git message" },
    },
    config = function()
      require("neoai").setup({
        -- Options go here
      })


      vim.api.nvim_set_keymap('n', '<Bslash>ain', ":NeoAi<Enter>", { noremap = true, silent = false })
    end,
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup {
        api_key_cmd = nil,
        yank_register = "+",
        edit_with_instructions = {
          diff = false,
          keymaps = {
            close = "<C-c>",
            accept = "<C-y>",
            toggle_diff = "<C-d>",
            toggle_settings = "<C-o>",
            toggle_help = "<C-h>",
            cycle_windows = "<Tab>",
            use_output_as_input = "<C-i>",
          },
        },
        chat = {
          welcome_message = WELCOME_MESSAGE,
          loading_text = "Loading, please wait ...",
          question_sign = "", -- 🙂
          answer_sign = "ﮧ", -- 🤖
          border_left_sign = "",
          border_right_sign = "",
          max_line_length = 120,
          sessions_window = {
            active_sign = "  ",
            inactive_sign = "  ",
            current_line_sign = "",
            border = {
              style = "rounded",
              text = {
                top = " Sessions ",
              },
            },
            win_options = {
              winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
            },
          },
          keymaps = {
            close = "<C-c>",
            yank_last = "<C-y>",
            yank_last_code = "<C-k>",
            scroll_up = "<C-u>",
            scroll_down = "<C-d>",
            new_session = "<C-n>",
            cycle_windows = "<Tab>",
            cycle_modes = "<C-f>",
            next_message = "<C-j>",
            prev_message = "<C-k>",
            select_session = "<Space>",
            rename_session = "r",
            delete_session = "d",
            draft_message = "<C-r>",
            edit_message = "e",
            delete_message = "d",
            toggle_settings = "<C-o>",
            toggle_sessions = "<C-p>",
            toggle_help = "<C-h>",
            toggle_message_role = "<C-r>",
            toggle_system_role_open = "<C-s>",
            stop_generating = "<C-x>",
          },
        },
        popup_layout = {
          default = "center",
          center = {
            width = "80%",
            height = "80%",
          },
          right = {
            width = "30%",
            width_settings_open = "50%",
          },
        },
        popup_window = {
          border = {
            highlight = "FloatBorder",
            style = "rounded",
            text = {
              top = " ChatGPT ",
            },
          },
          win_options = {
            wrap = true,
            linebreak = true,
            foldcolumn = "1",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
          buf_options = {
            filetype = "markdown",
          },
        },
        system_window = {
          border = {
            highlight = "FloatBorder",
            style = "rounded",
            text = {
              top = " SYSTEM ",
            },
          },
          win_options = {
            wrap = true,
            linebreak = true,
            foldcolumn = "2",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },
        popup_input = {
          prompt = "  ",
          border = {
            highlight = "FloatBorder",
            style = "rounded",
            text = {
              top_align = "center",
              top = " Prompt ",
            },
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
          submit = "<C-Enter>",
          submit_n = "<Enter>",
          max_visible_lines = 20,
        },
        settings_window = {
          setting_sign = "  ",
          border = {
            style = "rounded",
            text = {
              top = " Settings ",
            },
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },
        help_window = {
          setting_sign = "  ",
          border = {
            style = "rounded",
            text = {
              top = " Help ",
            },
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },
        openai_params = {
          model = "gpt-3.5-turbo",
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 300,
          temperature = 0,
          top_p = 1,
          n = 1,
        },
        openai_edit_params = {
          model = "gpt-3.5-turbo",
          frequency_penalty = 0,
          presence_penalty = 0,
          temperature = 0,
          top_p = 1,
          n = 1,
        },
        use_openai_functions_for_edits = false,
        actions_paths = {},
        show_quickfixes_cmd = "Trouble quickfix",
        predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
        highlights = {
          help_key = "@symbol",
          help_description = "@comment",
        },
      }

      vim.api.nvim_set_keymap('n', '<Bslash>aic', ":ChatGPT<Enter>", { noremap = true, silent = false })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },

  {
    "sindrets/diffview.nvim",
    event = "BufRead",
    config = function()
      local cb = require 'diffview.config'.diffview_callback

      require('diffview').setup {
        diff_binaries = false, -- Show diffs for binaries
        file_panel = {
          width = 35,
          use_icons = true -- Requires nvim-web-devicons
        },
        key_bindings = {
          disable_defaults = false, -- Disable the default key bindings
          -- The `view` bindings are active in the diff buffers, only when the current
          -- tabpage is a Diffview.
          view = {
            ["<tab>"]     = cb("select_next_entry"), -- Open the diff for the next file
            ["<s-tab>"]   = cb("select_prev_entry"), -- Open the diff for the previous file
            ["<leader>e"] = cb("focus_files"),       -- Bring focus to the files panel
            ["<leader>b"] = cb("toggle_files"),      -- Toggle the files panel.
          },
          file_panel = {
            ["j"]             = cb("next_entry"),   -- Bring the cursor to the next file entry
            ["<down>"]        = cb("next_entry"),
            ["k"]             = cb("prev_entry"),   -- Bring the cursor to the previous file entry.
            ["<up>"]          = cb("prev_entry"),
            ["<cr>"]          = cb("select_entry"), -- Open the diff for the selected entry.
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
      vim.api.nvim_set_keymap("n", "<Bslash>gD", ":DiffviewOpen<Enter>", { noremap = true, silent = true })
    end
  },

  {
    "dnlhc/glance.nvim",
    config = function()
      local glance = require('glance')
      local actions = glance.actions

      glance.setup({
        height = 18, -- Height of the window
        zindex = 45,

        -- By default glance will open preview "embedded" within your active window
        -- when `detached` is enabled, glance will render above all existing windows
        -- and won't be restiricted by the width of your active window
        detached = true,

        -- Or use a function to enable `detached` only when the active window is too small
        -- (default behavior)
        -- detached = function(winid)
        --   return vim.api.nvim_win_get_width(winid) < 100
        -- end,

        preview_win_opts = { -- Configure preview window options
          cursorline = true,
          number = true,
          wrap = true,
        },
        border = {
          enable = false, -- Show window borders. Only horizontal borders allowed
          top_char = '―',
          bottom_char = '―',
        },
        list = {
          position = 'right', -- Position of the list window 'left'|'right'
          width = 0.33,       -- 33% width relative to the active window, min 0.1, max 0.5
        },
        theme = {             -- This feature might not work properly in nvim-0.7.2
          enable = true,      -- Will generate colors for the plugin based on your current colorscheme
          mode = 'auto',      -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
        },
        mappings = {
          list = {
            ['j'] = actions.next,     -- Bring the cursor to the next item in the list
            ['k'] = actions.previous, -- Bring the cursor to the previous item in the list
            ['<Down>'] = actions.next,
            ['<Up>'] = actions.previous,
            ['<Tab>'] = actions.next_location,       -- Bring the cursor to the next location skipping groups in the list
            ['<S-Tab>'] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
            ['<C-u>'] = actions.preview_scroll_win(5),
            ['<C-d>'] = actions.preview_scroll_win(-5),
            ['v'] = actions.jump_vsplit,
            ['s'] = actions.jump_split,
            ['t'] = actions.jump_tab,
            ['<CR>'] = actions.jump,
            ['o'] = actions.jump,
            ['l'] = actions.open_fold,
            ['h'] = actions.close_fold,
            ['<leader>l'] = actions.enter_win('preview'), -- Focus preview window
            ['q'] = actions.close,
            ['Q'] = actions.close,
            ['<Esc>'] = actions.close,
            ['<C-q>'] = actions.quickfix,
            -- ['<Esc>'] = false -- disable a mapping
          },
          preview = {
            ['Q'] = actions.close,
            ['<Tab>'] = actions.next_location,
            ['<S-Tab>'] = actions.previous_location,
            ['<leader>l'] = actions.enter_win('list'), -- Focus list window
          },
        },
        hooks = {},
        folds = {
          fold_closed = '',
          fold_open = '',
          folded = true, -- Automatically fold list on startup
        },
        indent_lines = {
          enable = true,
          icon = '│',
        },
        winbar = {
          enable = true, -- Available strating from nvim-0.8+
        },
      })
      -- Lua
      vim.api.nvim_set_keymap("n", "gGd", "<CMD>Glance definitions<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "gGr", "<CMD>Glance references<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "gGy", "<CMD>Glance type_definitions<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "gGm", "<CMD>Glance implementations<CR>", { noremap = true, silent = true })
    end,
  },

  {
    "CRAG666/code_runner.nvim",
    config = function()
      require('code_runner').setup({
        filetype = {
          python = "python3 -u",
          typescript = "deno run",
          rust = {
            "cd $dir &&",
            "rustc $fileName &&",
            "$dir/$fileNameWithoutExt"
          },
        },
      })

      vim.api.nvim_set_keymap('n', '<Bslash>rc', ':RunCode<CR>', { noremap = true, silent = false })
      vim.api.nvim_set_keymap('n', '<Bslash>rf', ':RunFile<CR>', { noremap = true, silent = false })
      vim.api.nvim_set_keymap('n', '<Bslash>rft', ':RunFile tab<CR>', { noremap = true, silent = false })
      -- vim.api.nvim_set_keymap('n', '<Bslash>rp', ':RunProject<CR>', { noremap = true, silent = false })
      -- vim.api.nvim_set_keymap('n', '<Bslash>rc', ':RunClose<CR>', { noremap = true, silent = false })
      -- vim.api.nvim_set_keymap('n', '<Bslash>crf', ':CRFiletype<CR>', { noremap = true, silent = false })
      -- vim.api.nvim_set_keymap('n', '<Bslash>crp', ':CRProjects<CR>', { noremap = true, silent = false })
    end
  },

  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require('neogen').setup({})

      vim.api.nvim_set_keymap('n', '<Bslash>dg', ":Neogen<cr>", { noremap = true, silent = false })
    end,
  },

  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (' 󰁂 %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, 'MoreMsg' })
        return newVirtText
      end

      -- global handler
      -- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
      -- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.

      require('ufo').setup({
        fold_virt_text_handler = handler,
        open_fold_hl_timeout = 150,
        close_fold_kinds = { 'imports', 'comment' },
        preview = {
          win_config = {
            border = { '', '─', '', '', '', '─', '', '' },
            winhighlight = 'Normal:Folded',
          },
          mappings = {
            scrollU = '<C-u>',
            scrollD = '<C-d>',
            jumpTop = '[',
            jumpBot = ']'
          }
        },
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end
      })

      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
      vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
      vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
      vim.keymap.set('n', 'zk', function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          -- choose one of coc.nvim and nvim lsp
          vim.fn.CocActionAsync('definitionHover') -- coc.nvim
          vim.lsp.buf.hover()
        end
      end)
    end
  },

  {
    "roobert/action-hints.nvim",
    config = function()
      require("action-hints").setup({
        template = {
          definition = { text = " ⊛", color = "#add8e6" },
          references = { text = " ↱%s", color = "#ff6666" },
        },
        use_virtual_text = true,
      })
    end,
  },

  {
    "luckasRanarison/nvim-devdocs",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("nvim-devdocs").setup()


      vim.api.nvim_set_keymap('n', '<Bslash>ddi', ":DevdocsInstall", { noremap = true, silent = false })
      vim.api.nvim_set_keymap('n', '<Bslash>ddo', ":DevdocsOpen<Enter>", { noremap = true, silent = false })
      vim.api.nvim_set_keymap('n', '<Bslash>ddf', ":DevdocsOpenFloat<Enter>", { noremap = true, silent = false })
      vim.api.nvim_set_keymap('n', '<Bslash>ddt', ":DevdocsToggle<Enter>", { noremap = true, silent = false })
      vim.api.nvim_set_keymap('n', '<Bslash>ddu', ":DevdocsUpdateAll<Enter>", { noremap = true, silent = false })
    end
  },

}

-- this isn't working...
-- require('specs').toggle()

require 'lspconfig'.tailwindcss.setup {}
require 'lspconfig'.cssmodules_ls.setup {}
require 'lspconfig'.solang.setup {}
require 'lspconfig'.glsl_analyzer.setup {}

-- Debug Adapter Protocol: DAP

-- local dap = require("dap")

-- dap.adapters.codelldb = {
--   type = 'server',
--   port = "${port}",
--   executable = {
--     command = '/home/matthew/.local/share/nvim/mason/bin/codelldb',
--     args = { "--port", "${port}" },
--   }
-- }

-- dap.configurations.cpp = {
--   {
--     name = "Launch file",
--     type = "codelldb",
--     request = "launch",
--     program = function()
--       return vim.fn.input('/home/matthew/.local/share/nvim/mason/bin/codelldb', vim.fn.getcwd() .. '/', 'file')
--     end,
--     cwd = '${workspaceFolder}',
--     stopOnEntry = false,
--   },
-- }

-- dap.configurations.rust = dap.configurations.cpp


-- require('dap').configurations.rust = {
--   {
--     name = "Launch file",
--     type = "codelldb",
--     request = "launch",
--     program = function()
--       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--     end,
--     cwd = '${workspaceFolder}',
--     stopOnEntry = false,
--   },
-- }

-- Autocommands (https://neovim.io/doc/user/autocmd.html)

-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
