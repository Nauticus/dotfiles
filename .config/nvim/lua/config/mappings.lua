local remap = vim.api.nvim_set_keymap

remap('i' , '<CR>','v:lua.utils.completion_confirm()', {expr = true , noremap = true})

remap("i", "<Tab>",
      table.concat({ "pumvisible() ? \"<C-n>\" : v:lua.utils.check_backspace()", "? \"<Tab>\" : compe#confirm()" }),
      { silent = true, noremap = true, expr = true })

remap("i", "<S-Tab>", "pumvisible() ? \"<C-p>\" : \"<S-Tab>\"", { noremap = true, expr = true })

remap("n", "<leader>rl", "<CMD>luafile %<CR>", { noremap = true })

remap('n', "<F10>", ":TSHighlightCapturesUnderCursor<CR>", { noremap = true, silent = true })
remap('n', "<F9>", ":lua _G.utils.echo_highlight()<CR>", { noremap = true, silent = true })
