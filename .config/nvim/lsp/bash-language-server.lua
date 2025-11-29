return {
  cmd = { 'bash-language-server', 'start' },
  settings = {
    bashIde = {
      globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command|.zsh|.fish)',
    },
  },
  filetypes = { 'bash', 'sh', 'zsh', 'fish' },
  root_markers = { '.git' },
}
