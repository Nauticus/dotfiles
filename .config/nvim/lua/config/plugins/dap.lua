local wk = require("which-key")
local dap = require('dap')
local dapui = require('dapui')

local keymap_debug = {
    name = '+debug',
    c = { dap.continue, 'Continue or Start' },
    q = { dap.close, 'Close' },
    d = { dap.disconnect, 'Disconnect' },
    t = { dap.toggle_breakpoint, 'Toggle Breakpoint' },
    x = { dap.run_to_cursor, 'Run to Cursor' },
    n = {
        name = '+exec',
        o = { dap.step_over, 'Step over' },
        b = { dap.step_back, 'Step back' },
        i = { dap.step_into, 'Step Into' },
        O = { dap.step_out, 'Step out' },
        p = { dap.pause, 'Toggle start/pause' }
    },
    s = { dap.session, 'Session' },
    r = { dap.repl.toggle, 'Toggle Repl' },
    u = { dapui.toggle, 'Toggle debugger UI' }
}

wk.register(keymap_debug, { prefix = '<leader>d' })

