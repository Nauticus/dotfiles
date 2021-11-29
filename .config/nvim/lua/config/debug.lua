local dap = require('dap')

dap.set_log_level('TRACE')

dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = { os.getenv("HOME") .. "/code/dependancies/vscode-chrome-debug/out/src/chromeDebug.js" }
}

dap.adapters.node2 = {
    type = "executable",
    command = "node",
    args = { os.getenv("HOME") .. "/code/dependancies/vscode-node-debug2/out/src/nodeDebug.js" }
}

dap.configurations.vue = { -- change this to javascript if needed
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        trace = true,
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}/src"
    }
}

dap.configurations.typescript = { -- change this to javascript if needed
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        trace = true,
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}/src"
    }
}

dap.configurations.javascript = { -- change this to javascript if needed
    {
        name = 'Attach to Chrome with remote debugging',
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        trace = true,
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}/src"
    },
    {
        name = 'Attach to node debugger',
        type = 'node2',
        request = 'attach',
        program = '${workspaceFolder}/${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal'
    }
}

