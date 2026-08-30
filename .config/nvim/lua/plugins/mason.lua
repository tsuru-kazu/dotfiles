-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- Lua
        "lua-language-server",
        "stylua",

        -- Go
        "gopls", -- Go language server
        "gofumpt", -- Go formatter (enhanced gofmt)
        "goimports", -- Go import organizer
        "golangci-lint", -- Go linter
        "delve", -- Go debugger

        -- Ruby
        "solargraph", -- Ruby language server
        "rubocop", -- Ruby formatter and linter

        -- TypeScript/JavaScript
        "vtsls", -- TypeScript language server
        "prettierd", -- Fast Prettier daemon for formatting
        "js-debug-adapter", -- JavaScript/TypeScript debugger

        -- Vue
        "vue-language-server", -- Vue language server (Volar)

        -- Markdown
        "marksman",

        -- YAML / TOML（Taskfile, aerospace など）
        "yaml-language-server",
        "taplo",

        -- Other tools
        "tree-sitter-cli",
      },
    },
  },
}
