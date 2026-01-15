-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.typescript" }, -- TypeScript/JavaScript support
  { import = "astrocommunity.pack.ruby" }, -- Ruby support (solargraph LSP, rubocop, etc)
  { import = "astrocommunity.pack.go" }, -- Go support (gopls LSP, gofmt, goimports, etc)
  -- import/override with your plugins folder
}
