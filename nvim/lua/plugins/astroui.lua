-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    -- 利用可能なテーマ例:
    -- "astrodark" (デフォルトのダークテーマ)
    -- "astrolight" (ライトテーマ)
    -- "habamax" (シンプルなテーマ)
    -- "github_dark" (GitHub Darkテーマ)
    -- "github_dark_default" (GitHub Dark Default)
    -- "github_dark_colorblind" (GitHub Dark Colorblind)
    -- "github_light" (GitHub Lightテーマ)
    -- "catppuccin" (Catppuccinテーマ - 追加インストールが必要)
    -- "tokyonight" (Tokyo Nightテーマ - 追加インストールが必要)
    -- "onedark" (One Darkテーマ - 追加インストールが必要)
    -- "dracula" (Draculaテーマ - 追加インストールが必要)
    colorscheme = "github_dark",
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      init = { -- this table overrides highlights in all themes
        -- 背景を透過させる設定（必要に応じてコメントアウトを解除）
        -- Normal = { bg = "NONE" },
        -- NormalNC = { bg = "NONE" },
        -- SignColumn = { bg = "NONE" },
        -- StatusLine = { bg = "NONE" },
        -- StatusLineNC = { bg = "NONE" },
      },
      github_dark = { -- GitHub Darkテーマ固有の設定
        -- 必要に応じてカスタマイズ
      },
    },
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
  },
}
