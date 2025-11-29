return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        require('dashboard').setup {
            theme = 'doom',
            config = {
                header = {
                    '                                                                               ',
                    '                                                                               ',
                    '██╗████████╗███████╗██████╗ ███████╗ █████╗ ██╗     ███████╗██╗   ██╗███╗   ██╗',
                    '██║╚══██╔══╝╚══███╔╝██╔══██╗██╔════╝██╔══██╗██║     ╚══███╔╝██║   ██║████╗  ██║',
                    '██║   ██║     ███╔╝ ██████╔╝█████╗  ███████║██║       ███╔╝ ██║   ██║██╔██╗ ██║',
                    '██║   ██║    ███╔╝  ██╔══██╗██╔══╝  ██╔══██║██║      ███╔╝  ██║   ██║██║╚██╗██║',
                    '██║   ██║   ███████╗██║  ██║███████╗██║  ██║███████╗███████╗╚██████╔╝██║ ╚████║',
                    '╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝',
                    '                                                                               ',
                    '                                                                               ',
                    '                                                                               ',
                    header_hl = 'Title'
                },
                center = {
                    {
                        icon = '  ',
                        icon_hl = 'Title',
                        desc = 'Open filesystem   ',
                        desc_hl = 'String',
                        key = 'o',
                        key_hl = 'Number',
                        key_format = ' %s', -- `%s` will be substituted with value of `key`
                        action = ':Neotree float',
                    },
                    {
                        icon = '🔍 ',
                        icon_hl = 'Title',
                        desc = 'Find files   ',
                        desc_hl = 'String',
                        key = 'f',
                        key_hl = 'Number',
                        key_format = ' %s', -- `%s` will be substituted with value of `key`
                        action = ':FzfLua files',
                    },
                    {
                        icon = '📖 ',
                        icon_hl = 'Title',
                        desc = 'Recent files   ',
                        desc_hl = 'String',
                        key = 'r',
                        key_hl = 'Number',
                        key_format = ' %s', -- `%s` will be substituted with value of `key`
                        action = ':FzfLua oldfiles',
                    },
                    {
                        icon = '  ',
                        icon_hl = 'Title',
                        desc = 'Git branches   ',
                        desc_hl = 'String',
                        key = 'g',
                        key_hl = 'Number',
                        key_format = ' %s', -- `%s` will be substituted with value of `key`
                        action = ':FzfLua git_branches',
                    }
                },
                footer = {}
            }
        }
    end,
    dependencies = 'nvim-tree/nvim-web-devicons'
}

