-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            " █████  ███████ ████████ ██████   ██████ ",
            "██   ██ ██         ██    ██   ██ ██    ██",
            "███████ ███████    ██    ██████  ██    ██",
            "██   ██      ██    ██    ██   ██ ██    ██",
            "██   ██ ███████    ██    ██   ██  ██████ ",
            "",
            "███    ██ ██    ██ ██ ███    ███",
            "████   ██ ██    ██ ██ ████  ████",
            "██ ██  ██ ██    ██ ██ ██ ████ ██",
            "██  ██ ██  ██  ██  ██ ██  ██  ██",
            "██   ████   ████   ██ ██      ██",
          }, "\n"),
        },
      },
    },
  },

  -- === GitHub Dark テーマ ===
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup {
        -- 新しい設定形式
        options = {
          -- 透過設定（必要に応じて）
          transparent = true, -- trueにすると背景が透過します
          hide_end_of_buffer = false,
          hide_nc_statusline = false,
          dim_inactive = false,
          -- サイドバーの設定
          darken = {
            sidebars = {
              enable = true,
              list = { "qf", "vista_kind", "terminal", "packer" },
            },
          },
          -- スタイル設定
          styles = {
            comments = "italic",
            functions = "italic",
            keywords = "italic",
            variables = "NONE",
          },
        },
        -- カスタムハイライト（必要に応じて）
        -- specs = {},
        -- groups = {},
      }
    end,
  },

  -- === Noice.nvim: コマンドラインUI改善（:を入力した時のモーダル表示） ===
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- LSPの設定（lsp_signature.nvimと競合するため無効化）
      lsp = {
        hover = {
          enabled = false,
        },
        signature = {
          enabled = false,
        },
      },
      -- コマンドラインの設定
      cmdline = {
        enabled = true, -- コマンドラインUIを有効化
        view = "cmdline_popup", -- ポップアップ表示
        opts = {},
        format = {
          -- コマンドラインのフォーマット設定
          cmdline = { icon = " " },
          search_down = { icon = " " },
          search_up = { icon = " " },
          filter = { icon = " " },
          lua = { icon = " " },
          help = { icon = " " },
        },
      },
      -- メッセージの設定
      messages = {
        enabled = true,
        view = "notify",
        view_error = "notify",
        view_warn = "notify",
        view_history = "messages",
        view_search = "virtualtext",
      },
      -- ポップアップメニューの設定
      popupmenu = {
        enabled = true,
        backend = "nui", -- nuiバックエンドを使用
        kind_icons = {},
      },
      -- コマンドパレットの設定
      commands = {
        history = {
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {
            pattern = "^:",
            fn = function(cmd) return vim.fn.histget(":", -1) == cmd end,
          },
        },
      },
      -- 通知の設定
      notify = {
        enabled = true,
        view = "notify",
      },
      -- ルーターの設定（メッセージのルーティング）
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },

  -- === Neo-tree: 無効化（oil.nvimを使用） ===
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },

  -- === Oil.nvim: バッファベースのファイルエクスプローラー ===
  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {
      -- デフォルトのファイルエクスプローラー設定
      default_file_explorer = true,
      -- カラム表示設定
      columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      -- バッファ設定
      buf_options = {
        buflisted = false,
        bufhidden = "hide",
      },
      -- ウィンドウ設定
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
      },
      -- 削除時の確認
      delete_to_trash = false,
      skip_confirm_for_simple_edits = false,
      -- プロンプトでファイル操作を保存
      prompt_save_on_select_new_entry = true,
      -- ゴミ箱コマンド（macOSの場合）
      cleanup_delay_ms = 2000,
      -- キーマップ（Ctrl+aプレフィックスでzellij競合を回避）
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-a>v"] = "actions.select_vsplit",
        ["<C-a>s"] = "actions.select_split",
        ["<C-a>t"] = "actions.select_tab",
        ["<C-a>p"] = "actions.preview",
        ["<C-a>c"] = "actions.close",
        ["<C-a>r"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
      -- 隠しファイルを表示
      view_options = {
        show_hidden = true,
        is_hidden_file = function(name, bufnr)
          return vim.startswith(name, ".")
        end,
        is_always_hidden = function(name, bufnr)
          return false
        end,
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  -- マークダウン
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
}
