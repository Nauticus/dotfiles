---@diagnostic disable: undefined-global

hs.window.animationDuration = 0.1
PaperWM = hs.loadSpoon("PaperWM")
PaperWM.window_gap = 0
PaperWM:bindHotkeys({
-- switch to a new focused window in tiled grid
    focus_left  = {{"ctrl", "alt", "cmd"}, "left"},
    focus_right = {{"ctrl", "alt", "cmd"}, "right"},
    focus_up    = {{"ctrl", "alt", "cmd"}, "up"},
    focus_down  = {{"ctrl", "alt", "cmd"}, "down"},

    -- move windows around in tiled grid
    swap_left  = {{"ctrl", "alt", "cmd", "shift"}, "left"},
    swap_right = {{"ctrl", "alt", "cmd", "shift"}, "right"},
    swap_up    = {{"ctrl", "alt", "cmd", "shift"}, "up"},
    swap_down  = {{"ctrl", "alt", "cmd", "shift"}, "down"},

    -- position and resize focused window
    center_window = { { "ctrl", "alt", "cmd" }, "c" },
    full_width = { { "ctrl", "alt", "cmd" }, "f" },
    cycle_width = { { "ctrl", "alt", "cmd" }, "r" },
    cycle_height = { { "ctrl", "alt", "cmd", "shift" }, "r" },

    -- move focused window into / out of a column
    slurp_in = { { "ctrl", "alt", "cmd" }, "i" },
    barf_out = { { "ctrl", "alt", "cmd" }, "o" },

    -- switch to a new Mission Control space
    switch_space_1 = { { "ctrl", "alt", "cmd" }, "1" },
    switch_space_2 = { { "ctrl", "alt", "cmd" }, "2" },
    switch_space_3 = { { "ctrl", "alt", "cmd" }, "3" },
    switch_space_4 = { { "ctrl", "alt", "cmd" }, "4" },
    switch_space_5 = { { "ctrl", "alt", "cmd" }, "5" },
    switch_space_6 = { { "ctrl", "alt", "cmd" }, "6" },
    switch_space_7 = { { "ctrl", "alt", "cmd" }, "7" },
    switch_space_8 = { { "ctrl", "alt", "cmd" }, "8" },
    switch_space_9 = { { "ctrl", "alt", "cmd" }, "9" },

    -- move focused window to a new space and tile
    move_window_1 = { { "ctrl", "alt", "cmd", "shift" }, "1" },
    move_window_2 = { { "ctrl", "alt", "cmd", "shift" }, "2" },
    move_window_3 = { { "ctrl", "alt", "cmd", "shift" }, "3" },
    move_window_4 = { { "ctrl", "alt", "cmd", "shift" }, "4" },
    move_window_5 = { { "ctrl", "alt", "cmd", "shift" }, "5" },
    move_window_6 = { { "ctrl", "alt", "cmd", "shift" }, "6" },
    move_window_7 = { { "ctrl", "alt", "cmd", "shift" }, "7" },
    move_window_8 = { { "ctrl", "alt", "cmd", "shift" }, "8" },
    move_window_9 = { { "ctrl", "alt", "cmd", "shift" }, "9" },
})
PaperWM.window_filter = PaperWM.window_filter:setFilters({
    ["Brave Browser"] = { rejectTitles = "Picture in Picture" },
    ["Google Chrome"] = { rejectTitles = "Picture in Picture" },
    ["Hammerspoon"] = { rejectTitles = "Hammerspoon Console" },
    ["1Password"] = { rejectTitles = "Preferences" },
})
PaperWM:start()

-- --------------------------------------------------------------------------
-- -- Constants
-- --------------------------------------------------------------------------
-- local winfocus = { "alt", "ctrl" }
-- local winmove = { "cmd", "alt", "ctrl" }
--
-- hs.grid.setGrid("6x6")
-- hs.grid.setMargins("0x0")
--
-- hs.hotkey.bind(winfocus, "r", function()
--     hs.reload()
-- end)
--
-- --------------------------------------------------------------------------
-- -- Window Movement Bindings
-- --------------------------------------------------------------------------
-- local resizebindings = {
--     -- Shift focus and snap focused window to half-screen positions
--     { key = "H", position = "[0,0,50,100]", focus = hs.window.filter.focusWest },
--     { key = "L", position = "[50,0,100,100]", focus = hs.window.filter.focusEast },
--     --TODO instead of focusing north/south maybe use raise/sendToBack on the current screen/space?
--     { key = "K", position = "[0,0,100,50]", focus = hs.window.filter.focusNorth },
--     { key = "J", position = "[0,50,100,100]", focus = hs.window.filter.focusSouth },
--
--     -- Resize focused window on grid
--     { key = "space", gridFunc = hs.grid.maximizeWindow },
--     { key = "/", gridFunc = hs.grid.snap },
--     { key = ".", gridFunc = hs.grid.resizeWindowWider },
--     { key = "N", gridFunc = hs.grid.resizeWindowThinner },
--     { key = "M", gridFunc = hs.grid.resizeWindowTaller },
--     { key = ",", gridFunc = hs.grid.resizeWindowShorter },
--     -- Move focused window on grid
--     { key = "Y", gridFunc = hs.grid.pushWindowLeft },
--     { key = "U", gridFunc = hs.grid.pushWindowDown },
--     { key = "I", gridFunc = hs.grid.pushWindowUp },
--     { key = "O", gridFunc = hs.grid.pushWindowRight },
-- }
--
-- local function centerMouse()
--     local window = hs.window.focusedWindow()
--     local windowMidpoint = hs.geometry.rectMidPoint(window:frame())
--     hs.mouse.absolutePosition(windowMidpoint)
-- end
--
-- for _, v in ipairs(resizebindings) do
--     if v.position then
--         hs.hotkey.bind(winmove, v.key, function()
--             hs.alert(v.position)
--             hs.window.focusedWindow():moveToUnit(v.position)
--         end)
--     end
--     if v.focus then
--         hs.hotkey.bind(winfocus, v.key, function()
--             v.focus()
--             centerMouse()
--         end)
--     end
--     if v.gridFunc then
--         hs.hotkey.bind(winfocus, v.key, function()
--             v.gridFunc(hs.window.focusedWindow())
--         end)
--     end
-- end
