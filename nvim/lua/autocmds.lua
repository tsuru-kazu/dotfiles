-- ターミナルを開いたらに常にinsertモードに入る
vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        vim.cmd("startinsert")
    end
})
  
-- ターミナルモードで行番号を非表示
vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
    end
})