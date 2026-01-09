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
        -- install language servers
        "lua-language-server",
        "gopls",        -- Go language server
        "ruby-lsp",     -- Ruby language server

        -- install formatters
        "stylua",
        "gofumpt",      -- Go formatter (enhanced gofmt)
        "rubocop",      -- Ruby formatter and linter

        -- install debuggers
        "debugpy",

        -- install any other package
        "tree-sitter-cli",
      },
    },
  },
}
