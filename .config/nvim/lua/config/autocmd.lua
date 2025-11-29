-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
    callback = function()
        vim.defer_fn(function()
            local extension = vim.fn.expand("%:e")
            if extension == "txt" or extension == "log" or extension == "tex" or extension == "md" then
                vim.cmd.colorscheme("delek")
            else
                vim.cmd.colorscheme("nordic")
            end
        end, 20)
    end
})
