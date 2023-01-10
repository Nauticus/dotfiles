local has_harpoon, harpoon = pcall(require, "harpoon")
if not has_harpoon then
    vim.notify("harpoon is missing", vim.log.levels.WARN)
    return
end

local harpoon_ui = require("harpoon.ui")

harpoon.setup {
    menu = {
        width = 90,
        height = 20,
    },
}
-- stylua: ignore start
vim.keymap.set("n", "[h",         harpoon_ui.nav_prev,              { desc = "Previous mark (Harpoon)" })
vim.keymap.set("n", "]h",         harpoon_ui.nav_next,              { desc = "Next mark (Harpoon)" })

vim.keymap.set("n", "<leader>hh", harpoon_ui.toggle_quick_menu,     { desc = "Toggle Harpoon UI" })
vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file, { desc = "Mark file (Harpoon)" })
