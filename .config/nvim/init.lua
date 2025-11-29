-- Include options of nvim and mappings
require("config.lazy")
require("config.options")
require("config.mappings")
require("config.autocmd")
require("config.lsp")

-- Autoupdate of Lazy
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("VimEnter", {
    group = augroup("autoupdate"),
    callback = function()
        if require("lazy.status").has_updates then
            require("lazy").update({ show = false, })
        end
    end,
})

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    float = {
        border = "rounded",
    },
})
