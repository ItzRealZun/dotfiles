-- Unbind arrows and bind Alt-hjkl to navigate in Insert mode
local bind = vim.keymap.set
bind('n', '<Up>', '<Nop>', { noremap = true, silent = true })
bind('n', '<Down>', '<Nop>', { noremap = true, silent = true })
bind('n', '<Left>', '<Nop>', { noremap = true, silent = true })
bind('n', '<Right>', '<Nop>', { noremap = true, silent = true })

bind('i', '<Up>', '<Nop>', { noremap = true, silent = true })
bind('i', '<Down>', '<Nop>', { noremap = true, silent = true })
bind('i', '<Left>', '<Nop>', { noremap = true, silent = true })
bind('i', '<Right>', '<Nop>', { noremap = true, silent = true })

bind('v', '<Up>', '<Nop>', { noremap = true, silent = true })
bind('v', '<Down>', '<Nop>', { noremap = true, silent = true })
bind('v', '<Left>', '<Nop>', { noremap = true, silent = true })
bind('v', '<Right>', '<Nop>', { noremap = true, silent = true })

bind('i', '<A-h>', '<Left>', { noremap = true, silent = true })
bind('i', '<A-j>', '<Down>', { noremap = true, silent = true })
bind('i', '<A-k>', '<Up>', { noremap = true, silent = true })
bind('i', '<A-l>', '<Right>', { noremap = true, silent = true })

-- Bind russian letters
bind('i', '<A-р>', '<Left>', { noremap = true, silent = true })
bind('i', '<A-о>', '<Down>', { noremap = true, silent = true })
bind('i', '<A-л>', '<Up>', { noremap = true, silent = true })
bind('i', '<A-д>', '<Right>', { noremap = true, silent = true })

bind('n', 'ф', 'a', { noremap = true, silent = true })
bind('n', 'ш', 'i', { noremap = true, silent = true })

bind('n', 'р', '<Left>', { noremap = true, silent = true })
bind('n', 'о', '<Down>', { noremap = true, silent = true })
bind('n', 'л', '<Up>', { noremap = true, silent = true })
bind('n', 'д', '<Right>', { noremap = true, silent = true })

-- Buffers, filemanagers, terminals
bind('n', '<A-f>', ':! prettier --write %<CR><CR>')
bind('n', '<Tab>', ':BufferLineCycleNext<CR>')
bind('n', '<s-Tab>', ':BufferLineCyclePrev<CR>')
bind('n', '<space>nf', ':Neotree float reveal toggle<CR>')
bind('n', '<space>nl', ':Neotree left reveal toggle<CR>')
bind('t', '<Esc><Esc>', "<C-\\><C-N>")
bind('n', '<space>tf', ':ToggleTerm direction=float<CR>')
bind('n', '<space>tv', ':ToggleTerm size=45 direction=vertical<CR>')
bind('n', '<space>ff', ':FzfLua files cwd=~/git/<CR>')
bind('n', '<space>fn', ':let @+=expand("%")<CR>') -- copy relative path of file


-- Developing mappings
local opts = { noremap = true, silent = true }
bind('n', 'gD', vim.lsp.buf.declaration, opts)
bind('n', 'gd', vim.lsp.buf.definition, opts)
bind('n', 'gr', vim.lsp.buf.references, opts)
bind('n', 'K', vim.lsp.buf.hover, opts)
bind('n', 'gi', vim.lsp.buf.implementation, opts)
bind('n', '<C-k>', vim.lsp.buf.signature_help, opts)
bind('i', '<C-k>', vim.lsp.buf.signature_help, opts)
bind('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
bind('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
bind('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts)
bind('n', '<space>td', vim.lsp.buf.type_definition, opts)
bind('n', '<space>rn', vim.lsp.buf.rename, opts)
bind('n', '<space>od', vim.diagnostic.open_float, opts)
bind('n', '<space>q', vim.diagnostic.setloclist, opts)
