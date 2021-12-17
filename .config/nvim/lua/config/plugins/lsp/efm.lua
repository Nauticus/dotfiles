local M = {}

M.efm_root_markers = { "package.json", ".git/", ".zshrc" }

M.prettier = {
    formatCommand = "prettier --find-config-path --stdin-filepath ${INPUT}",
    formatStdin = true,
}

M.eslint = {
    formatCommand = "./node_modules/.bin/eslint --fix-to-stdout --stdin --stdin-filename=${INPUT}",
    formatStdin = true,
}

M.eslint_and_prettier = {
    formatCommand = "./node_modules/.bin/prettier-eslint --stdin --stdin-filepath ${INPUT}",
    formatStdin = true,
}

M.lua_format = { formatCommand = "lua-format -i", formatStdin = true }

return M
