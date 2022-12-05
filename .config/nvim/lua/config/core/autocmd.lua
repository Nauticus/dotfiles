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

autocmd("BufWritePost", {
    desc = "Source plugins config on write.",
    group = "SourcePacker",
    pattern = "*/nvim/lua/config/plugins/*.lua",
    callback = function(context)
        local init_path = vim.fn.stdpath "config" .. "/lua/config/plugins/init.lua"
        local status_ok, reload = pcall(require, "plenary.reload")
        if not status_ok then
            vim.cmd(vim.fn.printf("source %s", context.file))
            vim.cmd(vim.fn.printf("source %s", init_path))
        end

        reload.reload_module("config.plugins", true)
        vim.cmd(vim.fn.printf("source %s", init_path))

        local confirm_compile = vim.fn.confirm("Run PackerCompile?", "&Yes\n&No", 1)
        if confirm_compile == 1 then
            vim.cmd [[PackerCompile]]
        end
    end,
})

autocmd("TextYankPost", {
    desc = "Highlight region on yank.",
    group = "HighlightYank",
    command = "silent! lua vim.highlight.on_yank() {higroup='IncSearch', timeout=800}",
})

autocmd("ColorScheme", {
    callback = function()
        vim.api.nvim_set_hl(0, "LeapMatch", { fg = "#000000", bg = "#FFFFFF", bold = true })
    end,
})

autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.keymap",
    group = "KeymapSyntax",
    command = "setlocal filetype=dts",
})
