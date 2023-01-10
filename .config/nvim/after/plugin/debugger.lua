local has_dapui, dapui = pcall(require, "dapui")
if not has_dapui then
    vim.notify("dapui is missing", vim.log.levels.WARN)
    return
end

dapui.setup()
