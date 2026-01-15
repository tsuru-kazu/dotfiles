-- Telescope設定
return {
  "nvim-telescope/telescope.nvim",
  opts = function(_, opts)
    local actions = require "telescope.actions"
    return require("astrocore").extend_tbl(opts, {
      defaults = {
        -- 大文字・小文字を区別しない設定
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--ignore-case", -- 大文字・小文字を常に区別しない
        },
        -- ファイル名検索の設定
        file_ignore_patterns = { "node_modules", ".git/" },
        -- 検索時の設定
        layout_config = {
          horizontal = {
            preview_width = 0.55,
          },
        },
        mappings = {
          i = {
            -- Ctrl+jで下に移動
            ["<C-j>"] = actions.move_selection_next,
            -- Ctrl+kで上に移動
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      },
      pickers = {
        find_files = {
          -- hidden filesも表示
          hidden = true,
        },
        buffers = {
          -- バッファ検索でも大文字・小文字を区別しない
          ignore_current_buffer = false,
          sort_mru = true,
        },
      },
    })
  end,
}
