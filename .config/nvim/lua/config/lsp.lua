vim.lsp.config("bash-language-server", {filetypes = {"bash", "sh", "zsh"}})
vim.lsp.config("clangd", {})
vim.lsp.config("cmake-language-server", {})
vim.lsp.config("css-lsp", {})
vim.lsp.config("docker-language-server", {})
vim.lsp.config("emmet-ls", {filetypes = { "html", "css", "javascriptreact", "typescriptreact", "svelte", "vue" }})
vim.lsp.config("eslint-lsp", {})
vim.lsp.config("json-lsp", {})

vim.lsp.config("lua-language-server", {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
    }
  }
})

vim.lsp.config("prettier", {})
vim.lsp.config("ruff", {})
vim.lsp.config("rust-analyzer", {})
vim.lsp.config("sqlls", {})
vim.lsp.config("ts-standard", {})
vim.lsp.config("vim-language-server", {})

vim.lsp.enable("bash-language-server")
vim.lsp.enable("clangd")
vim.lsp.enable("cmake-language-server")
vim.lsp.enable("css-lsp")
vim.lsp.enable("docker-language-server")
vim.lsp.enable("emmet-ls")
vim.lsp.enable("eslint-lsp")
vim.lsp.enable("json-lsp")
vim.lsp.enable("lua-language-server")
vim.lsp.enable("prettier")
vim.lsp.enable("ruff")
vim.lsp.enable("rust-analyzer")
vim.lsp.enable("sqlls")
vim.lsp.enable("ts-standard")
vim.lsp.enable("vim-language-server")
