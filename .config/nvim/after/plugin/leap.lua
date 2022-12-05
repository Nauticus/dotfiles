local has_leap, leap = pcall(require, "leap")
if not has_leap then
    vim.notify("leap is missing", vim.log.levels.WARN)
    return
end

leap.add_default_mappings()
leap.opts.safe_labels = {}

local has_flit, flit = pcall(require, "flit")
if not has_flit then
    vim.notify("flit is missing", vim.log.levels.WARN)
    return
end

flit.setup {
    labeled_modes = "nv",
}
