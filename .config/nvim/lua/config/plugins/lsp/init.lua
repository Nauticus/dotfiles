vim.lsp.set_log_level("debug")

local function setup()
    require'lspinstall'.setup()
    require('config.plugins.lsp.lua')
    require('config.plugins.lsp.efm')
    require('config.plugins.lsp.typescript')
    require('config.plugins.lsp.php')
    require('config.plugins.lsp.json')
    require('config.plugins.lsp.vue')
end

setup()

require'lspinstall'.post_install_hook = function ()
  setup()
  vim.cmd("bufdo e")
end
