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
        file_ignore_patterns = M.ignore_pattern,
        layout_strategy = 'vertical',
        layout_config = { preview_cutoff = 10, mirror = false }
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = false, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case" -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    }

}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

M.find_dotfiles = function()
    require('telescope.builtin').fd { cwd = '~/code/dotfiles', hidden = true }
end

return M
