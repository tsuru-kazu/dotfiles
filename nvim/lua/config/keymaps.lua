local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  if opts.remap and not vim.g.vscode then
    opts.remap = nil
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

map("n", "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
map("n", "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, { desc = "Next Error" })
map("n", "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, { desc = "Prev Error" })
map("n", "]w", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN }) end, { desc = "Next Warning" })
map("n", "[w", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN }) end, { desc = "Prev Warning" })

map("n", "<leader>uf", function()
  local formatters = require("conform").list_formatters(0)
  if #formatters > 0 then
    require("conform").format({ formatters = { formatters[1].name } })
  end
end, { desc = "Format Document" })

map("n", "<leader>ur", function()
  local word = vim.fn.expand("<cword>")
  return ":%s/\\<" .. word .. "\\>/" .. word .. "/gI<Left><Left><Left>"
end, { expr = true, desc = "Replace word under cursor" })

map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

map("n", "<Esc>", "<cmd>nohlsearch<CR>")

map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

map("x", "p", [["_dP]])

map("n", "<C-n>", "<cmd>cnext<CR>zz")
map("n", "<C-p>", "<cmd>cprev<CR>zz")
map("n", "<leader>k", "<cmd>lnext<CR>zz")
map("n", "<leader>j", "<cmd>lprev<CR>zz")

map("n", "<leader>cp", function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  vim.fn.setreg("*", path)
  print("Copied relative path: " .. path)
end, { desc = "Copy relative file path" })

map("n", "<leader>cP", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.fn.setreg("*", path)
  print("Copied absolute path: " .. path)
end, { desc = "Copy absolute file path" })

map("n", "<leader>cf", function()
  local filename = vim.fn.expand("%:t")
  vim.fn.setreg("+", filename)
  vim.fn.setreg("*", filename)
  print("Copied filename: " .. filename)
end, { desc = "Copy filename" })

map("n", "<leader>yw", "yiw", { desc = "Yank inner word" })
map("n", "<leader>yW", "yaw", { desc = "Yank a word" })