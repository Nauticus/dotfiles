local has_nvim_surround, nvim_surround = pcall(require, "nvim-surround")
if not has_nvim_surround then
    vim.notify("nvim-surround is missing", vim.log.levels.WARN)
    return
end

nvim_surround.setup {}
