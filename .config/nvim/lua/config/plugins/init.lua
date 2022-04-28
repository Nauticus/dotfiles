local install_path = vim.fn.stdpath "data" .. "/site/Pack/packer/start/packer.nvim"

---@diagnostic disable-next-line: missing-parameter
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.cmd "packadd packer.nvim"

local packer = require "packer"

packer.init {
    max_jobs = 6,
    profile = { enable = false },
}

return packer.startup(function(use)
    local function use_set(name)
        local status_ok, set = pcall(require, "config.plugins.sets." .. name)
        if not status_ok then
            vim.notify(
                vim.fn.printf([[Set with name "%s" was not found.]], name),
                vim.log.levels.WARN,
                { title = "Packer sets" }
            )
            return
        end

        return use(set)
    end

    use "wbthomason/packer.nvim"
    use_set "colorscheme"
    use_set "treesitter"
    use_set "motions"
    use_set "sessions"
    use_set "git"
    use_set "utilities"
    use_set "lines"
    use_set "lsp"
    use_set "completion"
    use_set "file_management"
    use_set "fuzzy_finder"
    use_set "debug"
    use_set "databases"
end)
