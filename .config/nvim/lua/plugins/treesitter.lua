return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "bash", "c", "cmake", "cpp", "css",
                "csv", "dockerfile", "html", "javascript",
                "json", "latex", "lua", "markdown",
                "python", "rust", "sql", "typescript", "tsx", "vim"
            },
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
