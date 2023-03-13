local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("FormatOptions", { clear = true })
augroup("TerminalOptions", { clear = true })
augroup("GitBufferOptions", { clear = true })
augroup("SourcePacker", { clear = true })
augroup("HighlightYank", { clear = true })
augroup("KeymapSyntax", { clear = true })

autocmd("BufEnter", {
    desc = "Disable continuation of line comments on new lines.",
    group = "FormatOptions",
    pattern = "*",
    command = "setlocal formatoptions-=c formatoptions-=o",
})

autocmd("TermOpen", {
    desc = "Customize the terminal buffers.",
    group = "TerminalOptions",
    pattern = "*",
    command = "setlocal nonumber bufhidden=hide norelativenumber nospell",
})

autocmd({ "TermOpen", "TermEnter" }, {
    desc = "Set terminal initial mode.",
    group = "TerminalOptions",
    pattern = "*",
    command = "startinsert",
})

autocmd("FileType", {
    desc = "Force the use of default fold method on git (fugitive) files.",
    group = "GitBufferOptions",
    pattern = "git",
    command = "setlocal foldmethod=syntax foldlevel=0",
})

autocmd("TextYankPost", {
    desc = "Highlight region on yank.",
    group = "HighlightYank",
    command = "silent! lua vim.highlight.on_yank() {higroup='IncSearch', timeout=800}",
})

autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.keymap",
    group = "KeymapSyntax",
    command = "setlocal filetype=dts",
})
