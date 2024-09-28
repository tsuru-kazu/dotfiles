local M = {}

function M.setup()
  require("noice").setup({
    lsp = {
      -- オーバーライド markdown-hover オーバーホバーフォーマット
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    -- cmdlineやpopupメニューなどのプリセットを使用
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = false,
    },
  })
end

return M