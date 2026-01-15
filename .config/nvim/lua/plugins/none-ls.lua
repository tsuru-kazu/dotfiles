-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    -- opts variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

    -- Only insert new sources, do not replace the existing ones
    -- (If you wish to replace, use `opts.sources = {}` instead of the `list_insert_unique` function)
    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      -- Lua
      null_ls.builtins.formatting.stylua,

      -- TypeScript/JavaScript (prettierd is faster than prettier)
      null_ls.builtins.formatting.prettierd.with {
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "css",
          "scss",
          "less",
          "html",
          "json",
          "jsonc",
          "yaml",
          "markdown",
          "markdown.mdx",
          "graphql",
          "handlebars",
        },
      },
      -- Note: ESLint diagnostics are provided by vtsls LSP
      -- If you need eslint_d, install it via npm: npm install -g eslint_d

      -- Go
      null_ls.builtins.formatting.gofumpt,
      null_ls.builtins.formatting.goimports,

      -- Ruby
      null_ls.builtins.formatting.rubocop,
      null_ls.builtins.diagnostics.rubocop,
    })
  end,
}
