local leader = "<backspace>"

return {

  ----------------------------------------------------------------------------
  -- LazyVim
  ----------------------------------------------------------------------------

  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "tokyonight-moon",
      -- colorscheme = "gruvbox-material",
      colorscheme = "everforest",
      -- colorscheme = "duskfox",
    },
  },

  -- {
  --   "echasnovski/mini.indentscope",
  --   opts = {
  --     draw = {
  --       -- turn off animations for indentation guides
  --       animation = function()
  --         return 0
  --       end,
  --     },
  --   },
  -- },
  
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        -- show search queries in dialog box as well
        bottom_search = false,
      },
    },
  },

  ----------------------------------------------------------------------------
  -- colorscheme
  ----------------------------------------------------------------------------

  {
    "sainnhe/edge",
    config = function()
      vim.g.edge_background = "soft"
    end,
  },

  {
    "sainnhe/everforest",
    -- config = function()
    --   -- vim.g.everforest_background = "soft"
    -- end,
  },

  {
    "sainnhe/gruvbox-material",
    config = function()
      vim.g.gruvbox_material_background = "soft"
    end,
  },

  ----------------------------------------------------------------------------
  -- navigation
  ----------------------------------------------------------------------------

  {
    "sunaku/tmux-navigate",
    lazy = false,
  },

  {
    "tpope/vim-projectionist",
    cmd = {
      "A",
      "AD",
      "Pcd",
      "Plcd",
    },
    keys = {
      {
        leader .. "ea",
        "<cmd>A<cr>",
        desc = "(projectionist) expose alternate file"
      },

      {
        leader .. "if",
        "<cmd>call feedkeys(':A ', 't')<CR>",
        desc = "(projectionist) create file relative to innermost root",
      },

      {
        leader .. "rB",
        "<cmd>AD<cr>",
        desc = "(projectionist) replace buffer with 'new file' template",
      },

      {
        leader .. "id",
        "<cmd>Pcd<cr>",
        desc = "(projectionist) change working directory to innermost root",
      },

      {
        leader .. "iD",
        "<cmd>Plcd<cr>",
        desc = "(projectionist) change buffer's working directory to innermost root",
      },

      {
        leader .. "eA",
        "<cmd>call feedkeys(\":Commands\n open_projections\\<C-A>\", 'n')<cr>",
        desc = "(projectionist) expose available projections",
      },
    },
    config = function()
      -- TODO: port heuristics folder
      vim.cmd([[
        " load heuristics (which also specify projections) from relative directory
        let files = glob(expand('<sfile>:r').'.heuristics/*.json', v:false, v:true)
        let jsons = map(files, 'json_decode(join(readfile(v:val)))')
        let merged = {} | call map(jsons, 'extend(merged, v:val)')
        silent! unlet merged['_'] " strip makeshift 'comment' keys
        let g:projectionist_heuristics = merged
      ]])
    end,
  },

  -- {
  --   "tpope/vim-unimpaired",
  --   lazy = false,
  -- -- "-----------------------------------------------------------------------------
  -- -- " auto-center the screen on target location after jumping
  -- -- "-----------------------------------------------------------------------------
  -- --
  -- -- nmap [n            <Plug>unimpairedContextPrevious<Esc>zz
  -- -- nmap ]n            <Plug>unimpairedContextNext<Esc>zz
  -- --
  -- -- nmap [l            <Plug>unimpairedLPrevious<Esc>zz
  -- -- nmap ]l            <Plug>unimpairedLNext<Esc>zz
  -- -- nmap [L            <Plug>unimpairedLFirst<Esc>zz
  -- -- nmap ]L            <Plug>unimpairedLLast<Esc>zz
  -- --
  -- -- nmap [q            <Plug>unimpairedQPrevious<Esc>zz
  -- -- nmap ]q            <Plug>unimpairedQNext<Esc>zz
  -- -- nmap [Q            <Plug>unimpairedQFirst<Esc>zz
  -- -- nmap ]Q            <Plug>unimpairedQLast<Esc>zz
  -- --
  -- -- "-----------------------------------------------------------------------------
  -- -- " NEXT AND PREVIOUS                               *unimpaired-next*
  -- -- "-----------------------------------------------------------------------------
  -- --
  -- -- Shortcut! [a       (unimpaired) go to previous argument
  -- -- Shortcut! ]a       (unimpaired) go to next     argument
  -- -- Shortcut! [A       (unimpaired) go to first    argument
  -- -- Shortcut! ]A       (unimpaired) go to last     argument
  -- -- Shortcut! [b       (unimpaired) go to previous buffer
  -- -- Shortcut! ]b       (unimpaired) go to next     buffer
  -- -- Shortcut! [B       (unimpaired) go to first    buffer
  -- -- Shortcut! ]B       (unimpaired) go to last     buffer
  -- -- Shortcut! [l       (unimpaired) go to previous location
  -- -- Shortcut! ]l       (unimpaired) go to next     location
  -- -- Shortcut! [L       (unimpaired) go to first    location
  -- -- Shortcut! ]L       (unimpaired) go to last     location
  -- -- Shortcut! [<C-L>   (unimpaired) go to previous file with locations
  -- -- Shortcut! ]<C-L>   (unimpaired) go to next     file with locations
  -- -- Shortcut! [q       (unimpaired) go to previous quickfix
  -- -- Shortcut! ]q       (unimpaired) go to next     quickfix
  -- -- Shortcut! [Q       (unimpaired) go to first    quickfix
  -- -- Shortcut! ]Q       (unimpaired) go to last     quickfix
  -- -- Shortcut! [<C-Q>   (unimpaired) go to previous file with quickfixes
  -- -- Shortcut! ]<C-Q>   (unimpaired) go to next     file with quickfixes
  -- -- Shortcut! [t       (unimpaired) go to previous ctag
  -- -- Shortcut! ]t       (unimpaired) go to next     ctag
  -- -- Shortcut! [T       (unimpaired) go to first    ctag
  -- -- Shortcut! ]T       (unimpaired) go to last     ctag
  -- --
  -- -- Shortcut! [f       (unimpaired) go to previous file in current file's directory
  -- -- Shortcut! ]f       (unimpaired) go to next     file in current file's directory
  -- --
  -- -- Shortcut! [n       (unimpaired) go to previous conflict marker or diff/patch hunk
  -- -- Shortcut! ]n       (unimpaired) go to next     conflict marker or diff/patch hunk
  -- --
  -- -- "-----------------------------------------------------------------------------
  -- -- " LINE OPERATIONS                                 *unimpaired-lines*
  -- -- "-----------------------------------------------------------------------------
  -- --
  -- -- Shortcut! [<Space> (unimpaired) Add [count] blank lines above the cursor.
  -- -- Shortcut! ]<Space> (unimpaired) Add [count] blank lines below the cursor.
  -- --
  -- -- Shortcut! [e       (unimpaired) Exchange current line with [count] lines above it.
  -- -- Shortcut! ]e       (unimpaired) Exchange current line with [count] lines below it.
  -- --
  -- -- "-----------------------------------------------------------------------------
  -- -- " OPTION TOGGLING                                 *unimpaired-toggling*
  -- -- "-----------------------------------------------------------------------------
  -- --
  -- -- function! s:describe_option_shortcuts(key, description) abort
  -- --   execute 'Shortcut! [o'. a:key .' (unimpaired) enable '.  a:description
  -- --   execute 'Shortcut! ]o'. a:key .' (unimpaired) disable '. a:description
  -- --   execute 'Shortcut! yo'. a:key .' (unimpaired) toggle '.  a:description
  -- -- endfunction
  -- --
  -- -- call s:describe_option_shortcuts('b', "assuming light background")
  -- -- call s:describe_option_shortcuts('c', "highlighting cursor's line")
  -- -- call s:describe_option_shortcuts('d', "diffing with current buffer")
  -- -- call s:describe_option_shortcuts('h', "highlighting search results")
  -- -- call s:describe_option_shortcuts('i', "ignoring case sensitivity")
  -- -- call s:describe_option_shortcuts('l', "listing nonprintable characters")
  -- -- call s:describe_option_shortcuts('n', "absolute line numbering")
  -- -- call s:describe_option_shortcuts('r', "relative line numbering")
  -- -- call s:describe_option_shortcuts('s', "checking for misspelled words")
  -- -- call s:describe_option_shortcuts('u', "highlighting cursor's column")
  -- -- call s:describe_option_shortcuts('v', "constraining cursor to line")
  -- -- call s:describe_option_shortcuts('w', "wrapping very long lines")
  -- -- call s:describe_option_shortcuts('x', "highlighting cursor's position")
  -- --
  -- -- "-----------------------------------------------------------------------------
  -- -- " PASTING                                         *unimpaired-pasting*
  -- -- "-----------------------------------------------------------------------------
  -- --
  -- -- Shortcut! >p       (unimpaired) Paste after  cursor, linewise, increasing indent.
  -- -- Shortcut! >P       (unimpaired) Paste before cursor, linewise, increasing indent.
  -- -- Shortcut! <p       (unimpaired) Paste after  cursor, linewise, decreasing indent.
  -- -- Shortcut! <P       (unimpaired) Paste before cursor, linewise, decreasing indent.
  -- -- Shortcut! =p       (unimpaired) Paste after  cursor, linewise, reindenting.
  -- -- Shortcut! =P       (unimpaired) Paste before cursor, linewise, reindenting.
  -- --
  -- -- Shortcut! [p       (unimpaired) Paste after  cursor, linewise.
  -- -- Shortcut! ]p       (unimpaired) Paste before cursor, linewise.
  -- -- Shortcut! [P       (unimpaired) Paste after  cursor, linewise.
  -- -- Shortcut! ]P       (unimpaired) Paste before cursor, linewise.
  -- --
  -- -- Shortcut! ]op      (unimpaired) Paste after  cursor, linewise, using paste mode.
  -- -- Shortcut! [op      (unimpaired) Paste before cursor, linewise, using paste mode.
  -- -- Shortcut! yop      (unimpaired) Change entire line, using paste mode temporarily.
  -- --
  -- -- "-----------------------------------------------------------------------------
  -- -- " ENCODING AND DECODING                           *unimpaired-encoding*
  -- -- "-----------------------------------------------------------------------------
  -- --
  -- -- Shortcut! [x       (unimpaired) XML escape.
  -- -- Shortcut! ]x       (unimpaired) XML unescape.
  -- -- Shortcut! [xx      (unimpaired) XML escape current line.
  -- -- Shortcut! ]xx      (unimpaired) XML unescape current line.
  -- --
  -- -- Shortcut! [u       (unimpaired) URL escape.
  -- -- Shortcut! ]u       (unimpaired) URL unescape.
  -- -- Shortcut! [uu      (unimpaired) URL escape current line.
  -- -- Shortcut! ]uu      (unimpaired) URL unescape current line.
  -- --
  -- -- Shortcut! [y       (unimpaired) String escape.
  -- -- Shortcut! ]y       (unimpaired) String unescape.
  -- -- Shortcut! [yy      (unimpaired) String escape current line.
  -- -- Shortcut! ]yy      (unimpaired) String unescape current line.
  --   config = function()
  --     vim.keymap.set("n", "[op", "<cmd>set paste<cr>", { desc = "enable verbatim paste mode" })
  --     vim.keymap.set("n", ")op", "<cmd>set nopaste<cr>", { desc = "disable verbatim paste mode" })
  --     vim.keymap.set("n", "cop", "<cmd>set paste! paste?<cr>", { desc = "toggle verbatim paste mode" })
  --   end,
  -- },

  {
    "bkad/CamelCaseMotion",
    lazy = false,
    config = function()
      vim.cmd("call camelcasemotion#CreateMotionMappings('-')")
    end,
  },

  {
    "folke/flash.nvim",
    opts = {
      modes = {
        search = {
          enabled = true
        }
      }
    },
  },

  ----------------------------------------------------------------------------
  -- editing
  ----------------------------------------------------------------------------

  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle" },
    keys = {
      {
        leader .. "tu",
        "<cmd>UndotreeToggle<cr>",
        desc = "(undotree) toggle sidebar",
      },
    },
    config = function()
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.cmd([[
        augroup undotree_my_settings
          autocmd!
          autocmd FileType undotree setlocal number relativenumber
          autocmd FileType undotree vertical resize +4
        augroup END
      ]])
    end,
  },

  {
    "lag13/ReplaceWithRegister",
    keys = { "gr", "grr" },
  },

  ----------------------------------------------------------------------------
  -- formatting
  ----------------------------------------------------------------------------

  -- TODO: this is WIP; need automatic surrounding like sandwich iss/ass
  -- NOTE: this plugin doesn't support automatic surrounding yet
  -- https://github.com/echasnovski/mini.nvim/discussions/450
  -- {
  --   "echasnovski/mini.surround",
  --   version = false, -- wait till new 0.7.0 release to put it back on semver
  --   event = "VimEnter",
  --   config = function()
  --     require("mini.surround").setup({
  --
  --       mappings = {
  --         add = "-sa", -- Add surrounding in Normal and Visual modes
  --         delete = "-sd", -- Delete surrounding
  --         find = "-sf", -- Find surrounding (to the right)
  --         find_left = "-sF", -- Find surrounding (to the left)
  --         highlight = "-sh", -- Highlight surrounding
  --         replace = "-sr", -- Replace surrounding
  --         update_n_lines = "-sn", -- Update `n_lines`
  --
  --         -- suffix_last = 'l', -- Suffix to search with "prev" method
  --         -- suffix_next = 'n', -- Suffix to search with "next" method
  --       },
  --       custom_surroundings = {
  --         -- Make `)` insert parts with spaces. `input` pattern stays the same.
  --         [")"] = { output = { left = "( ", right = " )" } },
  --
  --         -- Autodetect surrounding delimiters
  --         ["s"] = {
  --           input = { find = "[\"'`{(\\[<].-[\"'`})\\]>]", extract = "^(.).*(.)$" },
  --         },
  --       },
  --     })
  --   end,
  -- },

  -- {
  --   "tpope/vim-repeat",
  --   lazy = false,
  --   config = function()
  --     vim.keymap.set("n", "u", "<Plug>(RepeatUndo)", { desc = "(repeat) undo" })
  --   end,
  -- },

  {
    "machakann/vim-sandwich",
    lazy = false,
    init = function()
      vim.g.sandwich_no_default_key_mappings = 1
      vim.g.operator_sandwich_no_default_key_mappings = 1
      vim.g.textobj_sandwich_no_default_key_mappings = 1
    end,
    keys = {
      -- The following shortcuts are based on "macros/sandwich/keymap/surround.vim";
      -- the main difference here is that I use "S" instead of "ss" for auto-detect,
      -- and "gs" instead of "s" for surround, and "." for the sentence text-object.
      --
      -- https://github.com/machakann/vim-sandwich/wiki/Introduce-vim-surround-keymappings
      --
      -- Shortcut! gs  (sandwich) surround selection or specified motion with specified delimiters
      -- Shortcut! gS  (sandwich) surround inside automatic delimiters with specified delimiters
      -- Shortcut! ds  (sandwich) delete specified delimiters surrounding specified motion
      -- Shortcut! dS  (sandwich) delete automatic delimiters surrounding specified motion
      -- Shortcut! cs  (sandwich) change specified delimiters surrounding specified motion
      -- Shortcut! cS  (sandwich) change automatic delimiters surrounding specified motion
      -- Shortcut! vaS (textobj) select around text surrounded by automatic delimiters
      -- Shortcut! viS (textobj) select inside text surrounded by automatic delimiters
      -- Shortcut! vas (textobj) select around text surrounded by specified delimiters
      -- Shortcut! vis (textobj) select inside text surrounded by specified delimiters
      -- Shortcut! vaP (textobj) select around sentence
      -- Shortcut! viP (textobj) select inside sentence

      {
        "gs",
        "<Plug>(operator-sandwich-add)",
        mode = { "n", "x" },
        desc = "(sandwich) add surround",
      },

      {
        "gS",
        "<Plug>(operator-sandwich-add)" .. "<Plug>(textobj-sandwich-auto-i)",
        desc = "(sandwich) add to nearest surround",
      },

      {
        "ds",
        "<Plug>(operator-sandwich-delete)"
          .. "<Plug>(operator-sandwich-release-count)"
          .. "<Plug>(textobj-sandwich-query-a)",
        desc = "(sandwich) delete surround",
      },

      {
        "dS",
        "<Plug>(operator-sandwich-delete)"
          .. "<Plug>(operator-sandwich-release-count)"
          .. "<Plug>(textobj-sandwich-auto-a)",
        desc = "(sandwich) delete nearest surround",
      },

      {
        "cs",
        "<Plug>(operator-sandwich-replace)"
          .. "<Plug>(operator-sandwich-release-count)"
          .. "<Plug>(textobj-sandwich-query-a)",
        desc = "(sandwich) change surround",
      },

      {
        "cS",
        "<Plug>(operator-sandwich-replace)"
          .. "<Plug>(operator-sandwich-release-count)"
          .. "<Plug>(textobj-sandwich-auto-a)",
        desc = "(sandwich) change nearest surround",
      },

      {
        ".",
        "<Plug>(operator-sandwich-dot)",
        desc = "(sandwich) repeat surround",
      },

      {
        "is",
        "<Plug>(textobj-sandwich-literal-query-i)",
        desc = "(sandwich) select inside surround",
        mode = "x",
      },

      {
        "iS",
        "<Plug>(textobj-sandwich-auto-i)",
        desc = "(sandwich) select inside nearest surround",
        mode = "x",
      },

      {
        "as",
        "<Plug>(textobj-sandwich-literal-query-a)",
        desc = "(sandwich) select inside surround",
        mode = "x",
      },

      {
        "aS",
        "<Plug>(textobj-sandwich-auto-a)",
        desc = "(sandwich) select inside nearest surround",
        mode = "x",
      },

      -- provide an alternative "P" alias to Vim's default "s" sentence textobj
      -- which is overridden by sandwich plugin to represent a surround textobj
      {
        "iP",
        "is",
        desc = "select inside sentence",
        noremap = true,
        mode = { "x", "o" },
      },

      {
        "aP",
        "as",
        desc = "select around sentence",
        noremap = true,
        mode = { "x", "o" },
      },
    },
    config = function()
      -- FIXME: u key isn't undoing surround atomically

      -- More distinguishable highlighting for surrounding delimiters.
      vim.cmd([[
        highlight! link OperatorSandwichBuns   lualine_a_command
        highlight! link OperatorSandwichChange lualine_a_replace
        highlight! link OperatorSandwichDelete lualine_a_terminal
        highlight! link OperatorSandwichAdd    lualine_a_insert
      ]])

      -- Restore cursor position after performing surround operations.
      vim.cmd("call operator#sandwich#set('all', 'all', 'cursor', 'keep')")

      -- The following shortcuts are based on "macros/sandwich/keymap/surround.vim";
      -- the main difference here is that I use "S" instead of "ss" for auto-detect,
      -- and "gs" instead of "s" for surround, and "." for the sentence text-object.
      --
      -- https://github.com/machakann/vim-sandwich/wiki/Introduce-vim-surround-keymappings
      --
      -- Shortcut! gs  (sandwich) surround selection or specified motion with specified delimiters
      -- Shortcut! gS  (sandwich) surround inside automatic delimiters with specified delimiters
      -- Shortcut! ds  (sandwich) delete specified delimiters surrounding specified motion
      -- Shortcut! dS  (sandwich) delete automatic delimiters surrounding specified motion
      -- Shortcut! cs  (sandwich) change specified delimiters surrounding specified motion
      -- Shortcut! cS  (sandwich) change automatic delimiters surrounding specified motion
      -- Shortcut! vaS (textobj) select around text surrounded by automatic delimiters
      -- Shortcut! viS (textobj) select inside text surrounded by automatic delimiters
      -- Shortcut! vas (textobj) select around text surrounded by specified delimiters
      -- Shortcut! vis (textobj) select inside text surrounded by specified delimiters
      -- Shortcut! vaP (textobj) select around sentence
      -- Shortcut! viP (textobj) select inside sentence

      -- vim.keymap.set("n", "gs", "<Plug>(operator-sandwich-add)", { desc = "(sandwich) add surround" })
      --
      -- vim.keymap.set(
      --   "n",
      --   "gS",
      --   "<Plug>(operator-sandwich-add)" .. "<Plug>(textobj-sandwich-auto-i)",
      --   { desc = "(sandwich) add to nearest surround" }
      -- )
      --
      -- vim.keymap.set(
      --   "n",
      --   "ds",
      --   "<Plug>(operator-sandwich-delete)"
      --     .. "<Plug>(operator-sandwich-release-count)"
      --     .. "<Plug>(textobj-sandwich-query-a)",
      --   { desc = "(sandwich) delete surround" }
      -- )
      --
      -- vim.keymap.set(
      --   "n",
      --   "dS",
      --   "<Plug>(operator-sandwich-delete)"
      --     .. "<Plug>(operator-sandwich-release-count)"
      --     .. "<Plug>(textobj-sandwich-auto-a)",
      --   { desc = "(sandwich) delete nearest surround" }
      -- )
      --
      -- vim.keymap.set(
      --   "n",
      --   "cs",
      --   "<Plug>(operator-sandwich-replace)"
      --     .. "<Plug>(operator-sandwich-release-count)"
      --     .. "<Plug>(textobj-sandwich-query-a)",
      --   { desc = "(sandwich) change surround" }
      -- )
      --
      -- vim.keymap.set(
      --   "n",
      --   "cS",
      --   "<Plug>(operator-sandwich-replace)"
      --     .. "<Plug>(operator-sandwich-release-count)"
      --     .. "<Plug>(textobj-sandwich-auto-a)",
      --   { desc = "(sandwich) change nearest surround" }
      -- )
      --
      -- vim.keymap.set("n", ".", "<Plug>(operator-sandwich-dot)", { desc = "(sandwich) repeat surround" })
      --
      -- vim.keymap.set("x", "gs", "<Plug>(operator-sandwich-add)", { desc = "(sandwich) add surround" })
      --
      -- vim.keymap.set(
      --   "x",
      --   "is",
      --   "<Plug>(textobj-sandwich-literal-query-i)",
      --   { desc = "(sandwich) select inside surround" }
      -- )
      --
      -- vim.keymap.set(
      --   "x",
      --   "iS",
      --   "<Plug>(textobj-sandwich-auto-i)",
      --   { desc = "(sandwich) select inside nearest surround" }
      -- )
      --
      -- vim.keymap.set(
      --   "x",
      --   "as",
      --   "<Plug>(textobj-sandwich-literal-query-a)",
      --   { desc = "(sandwich) select inside surround" }
      -- )
      --
      -- vim.keymap.set(
      --   "x",
      --   "aS",
      --   "<Plug>(textobj-sandwich-auto-a)",
      --   { desc = "(sandwich) select inside nearest surround" }
      -- )

      -- provide an alternative "n" alias to Vim's default "s" sentence textobj
      -- which is overridden by sandwich plugin to represent a surround textobj
      -- vim.keymap.set({ "n", "o" }, "in", "is", { desc = "select inside sentence", noremap = true })
      -- vim.keymap.set({ "n", "o" }, "an", "as", { desc = "select around sentence", noremap = true })
    end,
  },

  {
    "machakann/vim-swap",
    lazy = false,
    init = function()
      vim.g.swap_no_default_key_mappings = 1
    end,
    keys = {
      -- this is changed from the default "gs" because I use that for machakann/vim-sandwich
      { "g=", "<Plug>(swap-interactive)", desc = "(swap) interactive mode", mode = { "n", "x" } },
      -- these are the default mappings for this plugin:
      { "g<", "<Plug>(swap-prev)", desc = "(swap) move item to left" },
      { "g>", "<Plug>(swap-next)", desc = "(swap) move item to right" },
    },

    -- config = function()
    --   -- this is changed from the default "gs" because I use that for machakann/vim-sandwich
    --   vim.keymap.set("n", "g=", "<Plug>(swap-interactive)", { desc = "(swap) interactive mode" })
    --   -- these are the default mappings for this plugin:
    --   vim.keymap.set("n", "g<", "<Plug>(swap-prev)", { desc = "(swap) move item to left" })
    --   vim.keymap.set("n", "g>", "<Plug>(swap-next)", { desc = "(swap) move item to right" })
    -- end,
  },

  {
    "FooSoft/vim-argwrap",
    cmd = { "ArgWrap" },
    keys = {
      {
        leader .. "fa",
        "<cmd>ArgWrap<cr>",
        desc = "(argwrap) toggle multi-line syntax at cursor",
      },
    },
  },

  {
    "AndrewRadev/splitjoin.vim",
    lazy = false,
    keys = {
      -- FIXME: these descriptions only apply to whichkey if lazy=false, but
      -- setting that also prevents this plugin from being loaded
      { "-K", nil, desc = "(splitjoin) split into multiple lines" },
      { "-J", nil, desc = "(splitjoin) collapse into single line" },
    },
    init = function()
      -- NOTE: gK is already used by LazyVim so use -K instead
      vim.g.splitjoin_split_mapping = "-K"
      vim.g.splitjoin_join_mapping = "-J"
    end,
    config = function() end,
  },

  {
    "tommcdo/vim-lion",
    lazy = false,
    config = function()
      vim.g.lion_squeeze_spaces = 1
    end,
  },

  {
    "scrooloose/nerdcommenter",
    -- lazy = false,
    init = function()
      vim.g.NERDCreateDefaultMappings = 0
      vim.g.NERDSpaceDelims = 1
      vim.g.NERDDefaultAlign = "left"
      vim.g.NERDCommentEmptyLines = 1
    end,
    keys = {
      {
        leader .. "~c",
        "<plug>NERDCommenterAltDelims",
        desc = "(NERDCommenter) toggle alternate comment delimiters",
        mode = { "n", "x" },
      },

      {
        leader .. "dc",
        "<plug>NERDCommenterUncomment",
        desc = "(NERDCommenter) uncomment, deleting comment delimiters",
        mode = { "n", "x" },
      },

      {
        leader .. "=c",
        "<plug>NERDCommenterAlignBoth",
        desc = "(NERDCommenter) comment, aligning both delimiters",
        mode = { "n", "x" },
      },

      {
        leader .. "Ic",
        "<plug>NERDCommenterAlignLeft",
        desc = "(NERDCommenter) comment, aligning left delimiter",
        mode = { "n", "x" },
      },

      {
        leader .. "ac",
        "<plug>NERDCommenterAppend",
        desc = "(NERDCommenter) append comment at end of line",
        mode = { "n", "x" },
      },

      {
        leader .. "yc",
        "<plug>NERDCommenterYank",
        desc = "(NERDCommenter) yank then comment",
        mode = { "n", "x" },
      },

      {
        leader .. "IC",
        "<plug>NERDCommenterSexy",
        desc = "(NERDCommenter) comment, sexily",
        mode = { "n", "x" },
      },

      {
        leader .. "tc",
        "<plug>NERDCommenterInvert",
        desc = "(NERDCommenter) invert comment markers",
        mode = { "n", "x" },
      },

      {
        leader .. "Ac",
        "<plug>NERDCommenterToEOL",
        desc = "(NERDCommenter) comment from cursor to end of line",
        mode = { "n", "x" },
      },

      {
        leader .. "aC",
        "<plug>NERDCommenterNested",
        desc = "(NERDCommenter) comment, nesting",
        mode = { "n", "x" },
      },

      {
        leader .. "iC",
        "<plug>NERDCommenterMinimal",
        desc = "(NERDCommenter) comment, minimally",
        mode = { "n", "x" },
      },

      {
        leader .. "tC",
        "<plug>NERDCommenterToggle",
        desc = "(NERDCommenter) toggle comment markers",
        mode = { "n", "x" },
      },

      {
        leader .. "ic",
        "<plug>NERDCommenterComment",
        desc = "(NERDCommenter) comment, inserting comment delimiters",
        mode = { "n", "x" },
      },

      {
        leader .. "Pc",
        "<plug>NERDCommenterYank`[P",
        desc = "(NERDCommenter) duplicate above cursor and comment",
        mode = { "n", "x" },
      },

      {
        leader .. "pc",
        "<plug>NERDCommenterYank`]p",
        desc = "(NERDCommenter) duplicate below cursor and comment",
        mode = { "n", "x" },
      },
    },
    -- config = function()
    --   local modes = { "n", "x", "v" }
    --   vim.keymap.set(
    --     modes,
    --     leader .. "~c",
    --     "<plug>NERDCommenterAltDelims",
    --     { desc = "(NERDCommenter) toggle alternate comment delimiters" }
    --   )
    --
    --   vim.keymap.set(
    --     modes,
    --     leader .. "dc",
    --     "<plug>NERDCommenterUncomment",
    --     { desc = "(NERDCommenter) uncomment, deleting comment delimiters" }
    --   )
    --
    --   vim.keymap.set(
    --     modes,
    --     leader .. "=c",
    --     "<plug>NERDCommenterAlignBoth",
    --     { desc = "(NERDCommenter) comment, aligning both delimiters" }
    --   )
    --
    --   vim.keymap.set(
    --     modes,
    --     leader .. "Ic",
    --     "<plug>NERDCommenterAlignLeft",
    --     { desc = "(NERDCommenter) comment, aligning left delimiter" }
    --   )
    --
    --   vim.keymap.set(
    --     modes,
    --     leader .. "ac",
    --     "<plug>NERDCommenterAppend",
    --     { desc = "(NERDCommenter) append comment at end of line" }
    --   )
    --
    --   vim.keymap.set("n", leader .. "yc", "<plug>NERDCommenterYank", { desc = "(NERDCommenter) yank then comment" })
    --
    --   vim.keymap.set("n", leader .. "IC", "<plug>NERDCommenterSexy", { desc = "(NERDCommenter) comment, sexily" })
    --
    --   vim.keymap.set(
    --     modes,
    --     leader .. "tc",
    --     "<plug>NERDCommenterInvert",
    --     { desc = "(NERDCommenter) invert comment markers" }
    --   )
    --
    --   vim.keymap.set(
    --     modes,
    --     leader .. "Ac",
    --     "<plug>NERDCommenterToEOL",
    --     { desc = "(NERDCommenter) comment from cursor to end of line" }
    --   )
    --
    --   vim.keymap.set("n", leader .. "aC", "<plug>NERDCommenterNested", { desc = "(NERDCommenter) comment, nesting" })
    --
    --   vim.keymap.set("n", leader .. "iC", "<plug>NERDCommenterMinimal", {
    --     desc = "(NERDCommenter) comment, minimally",
    --   })
    --
    --   vim.keymap.set(
    --     modes,
    --     leader .. "tC",
    --     "<plug>NERDCommenterToggle",
    --     { desc = "(NERDCommenter) toggle comment markers" }
    --   )
    --
    --   vim.keymap.set(
    --     modes,
    --     leader .. "ic",
    --     "<plug>NERDCommenterComment",
    --     { desc = "(NERDCommenter) comment, inserting comment delimiters" }
    --   )
    --
    --   vim.keymap.set(
    --     modes,
    --     leader .. "Pc",
    --     "<plug>NERDCommenterYank`[P",
    --     { desc = "(NERDCommenter) duplicate above cursor and comment" }
    --   )
    --
    --   vim.keymap.set(
    --     modes,
    --     leader .. "pc",
    --     "<plug>NERDCommenterYank`]p",
    --     { desc = "(NERDCommenter) duplicate below cursor and comment" }
    --   )
    -- end,
  },

  ----------------------------------------------------------------------------
  -- documentation
  ----------------------------------------------------------------------------

  {
    "sunaku/vim-dasht",
    cmd = { "Dasht" },
    keys = {
      {
        leader .. "k",
        ":Dasht ",
        desc = "(dasht) search related docsets at command prompt",
        nowait = true,
      },

      {
        leader .. leader .. "k",
        ":Dasht! ",
        desc = "(dasht) search ALL the docsets at command prompt",
        nowait = true,
      },

      {
        leader .. "K",
        ":call Dasht(dasht#cursor_search_terms())<CR>",
        desc = "(dasht) search related docsets for cursor word or selected text",
        silent = true,
      },

      {
        leader .. leader .. "K",
        ":call Dasht(dasht#cursor_search_terms(), '!')<CR>",
        desc = "(dasht) search ALL the docsets for cursor word or selected text",
        silent = true,
      },

      {
        leader .. "K",
        "y:<C-U>call Dasht(getreg(0))<CR>",
        desc = "(dasht) search related docsets for cursor word or selected text",
        mode = "v",
        silent = true,
      },

      {
        leader .. leader .. "K",
        "y:<C-U>call Dasht(getreg(0), '!')<CR>",
        desc = "(dasht) search ALL the docsets for cursor word or selected text",
        mode = "v",
        silent = true,
      },
    },
    config = function()
      -- Define docsets to consider as related:
      -- filetype => list of docset name regexp
      vim.g.dasht_filetype_docsets = {
        elixir = { "elixir", "erlang" },
        html = { "html", "css", "js" },
        eruby = { "ruby" },
      }

      -- vim.keymap.set(
      --   "n",
      --   leader .. "k",
      --   ":Dasht ",
      --   { desc = "(dasht) search related docsets at command prompt", nowait = true }
      -- )
      --
      -- vim.keymap.set(
      --   "n",
      --   leader .. leader .. "k",
      --   ":Dasht! ",
      --   { desc = "(dasht) search ALL the docsets at command prompt", nowait = true }
      -- )
      --
      -- vim.keymap.set(
      --   "n",
      --   leader .. "K",
      --   ":call Dasht(dasht#cursor_search_terms())<CR>",
      --   { desc = "(dasht) search related docsets for cursor word or selected text", silent = true }
      -- )
      --
      -- vim.keymap.set(
      --   "n",
      --   leader .. leader .. "K",
      --   ":call Dasht(dasht#cursor_search_terms(), '!')<CR>",
      --   { desc = "(dasht) search ALL the docsets for cursor word or selected text", silent = true }
      -- )
      --
      -- vim.keymap.set(
      --   "v",
      --   leader .. "K",
      --   "y:<C-U>call Dasht(getreg(0))<CR>",
      --   { desc = "(dasht) search related docsets for cursor word or selected text" }
      -- )
      --
      -- vim.keymap.set(
      --   "v",
      --   leader .. leader .. "K",
      --   "y:<C-U>call Dasht(getreg(0), '!')<CR>",
      --   { desc = "(dasht) search ALL the docsets for cursor word or selected text" }
      -- )
    end,
  },

  {
    "sunaku/vim-hicterm",
    cmd = {
      "HiCterm",
      "HiCtermFg",
      "HiCtermBg",
      "HiCtermOff",
    },
  },

  {
    "Pocco81/TrueZen.nvim",
    cmd = {
      "TZAtaraxis",
      "TZMinimalist",
    },
    keys = {
      {
        leader .. "tt",
        "<cmd>TZAtaraxis<cr>",
        desc = "(true-zen) toggle distractions",
      },
      {
        leader .. "tT",
        "<cmd>TZMinimalist<cr>",
        desc = "(true-zen) toggle minimalism",
      },
    },
  },

  ----------------------------------------------------------------------------
  -- code assistance
  ----------------------------------------------------------------------------

  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { {
      "<leader>cs",
      "<cmd>SymbolsOutline<cr>",
      desc = "Symbols Outline",
    } },
    config = true,
  },

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
    end,
  },

  ----------------------------------------------------------------------------
  -- textobj
  ----------------------------------------------------------------------------

  {
    "michaeljsmith/vim-indent-object",
    lazy = false,
    --Shortcut! vai (textobj) select around indentation level and line above
    --Shortcut! vii (textobj) select inside indentation level; no line above
    --Shortcut! vaI (textobj) select around indentation level and lines above/below
    --Shortcut! viI (textobj) select inside indentation level; no lines above/below
  },

  ----------------------------------------------------------------------------
  -- git
  ----------------------------------------------------------------------------

  {
    "tpope/vim-fugitive",
    lazy = false,
    -- TODO: config fugitive
    keys = {
      {
        leader .. "/G",
        "<cmd><C-U>call Fugitive_grep_prompt('-Pi')<cr>",
        desc = "(fugitive) git grep: search repository",
      },

      {
        leader .. "/g",
        "<cmd><C-U>call Fugitive_grep_prompt('-P')<cr>",
        desc = "(fugitive) git grep: search repository",
      },

      {
        leader .. "?G",
        "<cmd><C-U>call Fugitive_grep_register('-Pi')<cr>",
        desc = "(fugitive) git grep: search repository for Vim search pattern",
      },

      {
        leader .. "?g",
        "<cmd><C-U>call Fugitive_grep_register('-P')<cr>",
        desc = "(fugitive) git grep: search repository for Vim search pattern",
      },

      {
        leader .. "*G",
        "<cmd><C-U>call Fugitive_grep_cursor('-Pi')<cr>",
        desc = "(fugitive) git grep: search repository for word under cursor",
      },

      {
        leader .. "*g",
        "<cmd><C-U>call Fugitive_grep_cursor('-P')<cr>",
        desc = "(fugitive) git grep: search repository for word under cursor",
      },

      {
        leader .. "cg",
        "<cmd>call feedkeys(':GMove '.expand('%'), 't')<cr>",
        desc = "(fugitive) git mv: rename file",
      },

      {
        leader .. "Cg",
        "<cmd>call feedkeys(':GMove! '.expand('%'), 't')<cr>",
        desc = "(fugitive) git mv -f: rename file forcefully",
      },

      {
        leader .. "GG",
        "<cmd>Git blame<cr>",
        desc = "(fugitive) git blame: who changed which line",
      },

      {
        leader .. "ig",
        "<cmd>Git commit<cr>",
        desc = "(fugitive) git commit: record new commit",
      },

      {
        leader .. "ag",
        "<cmd>Git commit --amend<cr>",
        desc = "(fugitive) git commit --amend",
      },

      {
        leader .. "Ag",
        "<cmd>Git commit --amend --reuse-message=HEAD<cr>",
        desc = "(fugitive) git commit --amend --reuse-message=HEAD",
      },

      {
        leader .. "hg",
        "<cmd>Gdiffsplit<cr>",
        desc = "(fugitive) git diff: show changes against repository",
      },

      {
        leader .. "eG",
        "<cmd>Gedit<cr>",
        desc = "(fugitive) return to editing git buffer",
      },

      {
        leader .. "rg",
        "<cmd>Gread<cr>",
        desc = "(fugitive) git checkout: revert buffer to repository",
      },

      {
        leader .. "Rg",
        "<cmd>Gread!<cr>",
        desc = "(fugitive) git checkout -f: revert buffer to repository forcefully",
      },

      {
        leader .. "gg",
        "<cmd>Gstatus<cr>",
        desc = "(fugitive) open git status window",
      },

      {
        leader .. "wg",
        "<cmd>Gwrite<cr>",
        desc = "(fugitive) git add: stage all changes in buffer",
      },

      {
        leader .. "Wg",
        "<cmd>Gwrite!<cr>",
        "(fugitive) git add -f: stage all changes in buffer forcefully",
      },

      {
        leader .. "dg",
        "<cmd>GRemove<Bar>bdelete<cr>",
        desc = "(fugitive) git rm: delete file from repository",
      },

      {
        leader .. "Dg",
        "<cmd>GRemove!<Bar>bdelete<cr>",
        desc = "(fugitive) git rm -f: delete file from repository forcefully",
      },
    },
  },

  {
    "f-person/git-blame.nvim",
    lazy = false,
    init = function()
      vim.g.gitblame_highlight_group = "SpecialKey"
      vim.g.gitblame_date_format = "%r"
    end,
  },

  {
    "akinsho/git-conflict.nvim",
    version = "*", -- only upgrade when a new tag is released
    cmd = {
      "GitConflictChooseOurs", -- Select the current changes.
      "GitConflictChooseTheirs", -- Select the incoming changes.
      "GitConflictChooseBoth", -- Select both changes.
      "GitConflictChooseNone", -- Select none of the changes.
      "GitConflictNextConflict", -- Move to the next conflict.
      "GitConflictPrevConflict", -- Move to the previous conflict.
      "GitConflictListQf", -- Get all conflict to quickfix
    },
    keys = {
      {
        leader .. "ho",
        "<cmd>GitConflictChooseOurs<cr>",
        desc = "(git-conflict) choose our version",
      },

      {
        leader .. "ht",
        "<cmd>GitConflictChooseTheirs<cr>",
        desc = "(git-conflict) choose their version",
      },

      {
        leader .. "ha",
        "<cmd>GitConflictChooseBoth<cr>",
        desc = "(git-conflict) choose both versions",
      },

      {
        leader .. "hn",
        "<cmd>GitConflictChooseNone<cr>",
        desc = "(git-conflict) delete both versions",
      },

      { "]c", "<cmd>GitConflictNextConflict<cr>", desc = "(git-conflict) go to next conflict" },

      { "[c", "<cmd>GitConflictPrevConflict<cr>", desc = "(git-conflict) go to prev conflict" },

      {
        leader .. "hq",
        "<cmd>GitConflictListQf<cr>",
        desc = "(git-conflict) populate quickfix",
      },
    },
    config = function()
      require("git-conflict").setup({
        default_mappings = false,
      })
    end,
    -- lazy = false,
  },

  ----------------------------------------------------------------------------
  -- telescope
  ----------------------------------------------------------------------------

  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader><leader>", "<cmd>Telescope builtin<cr>", desc = "Telescope" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
      { '<leader>f"', "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>f'", "<cmd>Telescope marks<cr>", desc = "Marks" },
    },
  },
  {
    "kyoh86/telescope-windows.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>fw", "<cmd>Telescope windows<cr>", desc = "Windows" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      telescope.setup({
        defaults = {
          -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
          mappings = {
            i = {
              -- Mapping <Esc> to quit in insert mode
              ["<esc>"] = actions.close,
              -- Mapping <C-u> to clear prompt
              ["<C-u>"] = false,
              -- Mapping <C-d> to delete buffer
              ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
            },
          },
        },
      })
      telescope.load_extension("windows")
    end,
  },

  ----------------------------------------------------------------------------
  -- system
  ----------------------------------------------------------------------------

  {
    "tpope/vim-eunuch",
    lazy = false,
    keys = {
      {
        leader .. "cf",
        "<cmd>call feedkeys(':Rename '.expand('%:t'), 't')<cr>",
        desc = "(eunuch) rename file",
        nowait = true,
      },
      {
        leader .. "df",
        -- TODO: convert to lua
        [[<cmd>if confirm("Delete file?", "&Yes\n&No", 2) == 1 <bar>
            Remove <bar>
          endif<cr>]],
        desc = "(eunuch) prompt to delete file",
      },
    },
  },

  ----------------------------------------------------------------------------
  -- completion
  ----------------------------------------------------------------------------
  --
  -- -- NOTE: this is copy/pasted from neighboring "lua/plugins/example.lua" file
  -- --
  -- -- Use <tab> for completion and snippets (supertab)
  -- -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  -- {
  --   "L3MON4D3/LuaSnip",
  --   keys = function()
  --     return {}
  --   end,
  -- },
  -- -- then: setup supertab in cmp
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     "hrsh7th/cmp-emoji",
  --   },
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     local has_words_before = function()
  --       unpack = unpack or table.unpack
  --       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  --       return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  --     end
  --
  --     local luasnip = require("luasnip")
  --     local cmp = require("cmp")
  --
  --     opts.mapping = vim.tbl_extend("force", opts.mapping, {
  --       ["<Tab>"] = cmp.mapping(function(fallback)
  --         if cmp.visible() then
  --           cmp.select_next_item()
  --           -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
  --           -- this way you will only jump inside the snippet region
  --         elseif luasnip.expand_or_jumpable() then
  --           luasnip.expand_or_jump()
  --         elseif has_words_before() then
  --           cmp.complete()
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --       ["<S-Tab>"] = cmp.mapping(function(fallback)
  --         if cmp.visible() then
  --           cmp.select_prev_item()
  --         elseif luasnip.jumpable(-1) then
  --           luasnip.jump(-1)
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --     })
  --   end,
  -- },
}
