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
      require("github-theme").setup({
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
      })
    end,
  },

  -- === Noice.nvim: コマンドラインUI改善（:を入力した時のモーダル表示） ===
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
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

  -- === Neo-tree: 隠しファイルを表示 ===
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true, -- 隠しファイルを表示
          hide_dotfiles = false, -- .で始まるファイルを非表示にしない
          hide_gitignored = false, -- gitignoreされたファイルを非表示にしない
          hide_by_name = {
            -- 特定のファイル名を非表示にしたい場合はここに追加
            -- ".DS_Store",
            -- "thumbs.db"
          },
          never_show = {
            -- 絶対に表示したくないファイル
            -- ".git",
          },
        },
      },
    },
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
}
