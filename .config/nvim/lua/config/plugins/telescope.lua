local M = {}

M.ignore_pattern = { '.git/.*', 'node_modules/.*' }
M.file_cmd = { 'fd', '--hidden', '--follow', '--type', 'f', '.' }

require('telescope').setup {
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
            [[--glob=!.git/*]],
            [[--glob=!node_modules/*]],
            [[--glob=!yarn.lock]],
            [[--glob=!package-lock.json]]
        },
        set_env = { ['COLORTERM'] = 'truecolor' },
        file_ignore_patterns = M.ignore_pattern
    },
    extensions = {
        fzf = {
            fuzzy = true
        }
    }
}

require('telescope').load_extension('fzf')

M.find_dotfiles = function()
    require('telescope.builtin').fd { cwd = '~/code/dotfiles', hidden = true }
end

return M
