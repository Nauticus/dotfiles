local remap = vim.api.nvim_set_keymap
local wk = require('whichkey_setup')

local keymap_leader = {
    r = { l = { '<CMD>luafile %<CR>', 'Reload lua' }, v = { '<CMD>so %<CR>', 'Reload vim' } },
    p = {
        name = '+fzf',
        h = { '<CMD>History<CR>', 'History' },
        b = { '<CMD>Buffers<CR>', 'Buffers' },
        f = { '<CMD>Files<CR>', 'Files' },
        c = { '<CMD>Files %:h<CR>', 'Files in current directory' },
        r = { ':Rg <C-R>" <BS><CR>', 'Grep word under cursor' }
    }
}

wk.register_keymap('leader', keymap_leader)

remap('n', '<SPACE>', '<Nop>', { noremap = true })
remap('n', '<leader>', ':WhichKey \'<Space>\'<CR>', { noremap = true, silent = true })

remap('i', '<CR>', 'v:lua.utils.completion_confirm()', { expr = true, noremap = true })

remap("i", "<Tab>",
      table.concat({ "pumvisible() ? \"<C-n>\" : v:lua.utils.check_backspace()", "? \"<Tab>\" : compe#confirm()" }),
      { silent = true, noremap = true, expr = true })

remap("i", "<S-Tab>", "pumvisible() ? \"<C-p>\" : \"<S-Tab>\"", { noremap = true, expr = true })

remap('n', "<A-Up>", "<cmd>resize -2<CR>", { noremap = true, silent = true })
remap('n', "<A-Down>", "<cmd>resize +2<CR>", { noremap = true, silent = true })
remap('n', "<A-Right>", "<cmd>vertical resize +2<CR>", { noremap = true, silent = true })
remap('n', "<A-Left>", "<cmd>vertical resize -2<CR>", { noremap = true, silent = true })

remap('n', "<C-k>", [[<C-w>k]], { noremap = true, silent = true })
remap('n', "<C-j>", [[<C-w>j]], { noremap = true, silent = true })
remap('n', "<C-l>", [[<C-w>l]], { noremap = true, silent = true })
remap('n', "<C-h>", [[<C-w>h]], { noremap = true, silent = true })

remap('n', "<F10>", ":TSHighlightCapturesUnderCursor<CR>", { noremap = true, silent = true })
remap('n', "<F9>", ":lua _G.utils.echo_highlight()<CR>", { noremap = true, silent = true })
remap('n', "<F5>", ":UndotreeToggle<CR>", { noremap = true, silent = true })

