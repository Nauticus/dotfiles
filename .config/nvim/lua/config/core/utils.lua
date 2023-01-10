local fn = vim.fn

_G.utils = {}

_G.utils.check_backspace = function()
    local curr_col = fn.col "."
    local is_first_col = fn.col "." - 1 == 0
    local prev_char = fn.getline("."):sub(curr_col - 1, curr_col - 1)

    if is_first_col or prev_char:match "%s" then
        return true
    else
        return false
    end
end

_G.utils.echo_highlight = function()
    local hi = fn.synIDattr(fn.synID(fn.line ".", fn.col ".", 1), "name")
    local trans = fn.synIDattr(fn.synID(fn.line ".", fn.col ".", 0), "name")
    local lo = fn.synIDattr(fn.synIDtrans(fn.synID(fn.line ".", fn.col ".", 1)), "name")

    print(string.format("hi<%s> trans<%s> lo<%s>", hi, trans, lo))
end

_G.utils.get_visual_selection_text = function()
    local modeInfo = vim.api.nvim_get_mode()
    local mode = modeInfo.mode

    local cursor = vim.api.nvim_win_get_cursor(0)
    local cline, ccol = cursor[1], cursor[2]
    local vline, vcol = vim.fn.line "v", vim.fn.col "v"

    local sline, scol
    local eline, ecol
    if cline == vline then
        if ccol <= vcol then
            sline, scol = cline, ccol
            eline, ecol = vline, vcol
            scol = scol + 1
        else
            sline, scol = vline, vcol
            eline, ecol = cline, ccol
            ecol = ecol + 1
        end
    elseif cline < vline then
        sline, scol = cline, ccol
        eline, ecol = vline, vcol
        scol = scol + 1
    else
        sline, scol = vline, vcol
        eline, ecol = cline, ccol
        ecol = ecol + 1
    end

    if mode == "V" or mode == "CTRL-V" or mode == "\22" then
        scol = 1
        ecol = nil
    end

    local lines = vim.api.nvim_buf_get_lines(0, sline - 1, eline, false)
    if #lines == 0 then
        return
    end

    local startText, endText
    if #lines == 1 then
        startText = string.sub(lines[1], scol, ecol)
    else
        startText = string.sub(lines[1], scol)
        endText = string.sub(lines[#lines], 1, ecol)
    end

    local selection = { startText }
    if #lines > 2 then
        vim.list_extend(selection, vim.list_slice(lines, 2, #lines - 1))
    end
    table.insert(selection, endText)

    return selection
end
