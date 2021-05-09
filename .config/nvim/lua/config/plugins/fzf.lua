vim.env['FZF_DEFAULT_OPTS'] = '+m'
vim.env['FZF_DEFAULT_COMMAND'] = 'fd --type f --hidden --follow --exclude .git'

vim.g.fzf_layout = { down = '40%' }
vim.g.fzf_preview_window = {}

vim.cmd('autocmd FileType fzf set noshowmode noruler nospell nonu nornu')

