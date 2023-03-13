---@diagnostic disable: undefined-global

hs.window.animationDuration = 0.1
PaperWM = hs.loadSpoon("PaperWM")
PaperWM.window_gap = 0

local hyper = { "ctrl", "alt", "cmd" }
local hyper_shift = { "ctrl", "alt", "cmd", "shift" }

PaperWM:bindHotkeys({
	-- switch to a new focused window in tiled grid
    -- stylua: ignore start
    focus_left     = { hyper, "left" },
    focus_right    = { hyper, "right" },
    focus_up       = { hyper, "up" },
    focus_down     = { hyper, "down" },

	-- move windows around in tiled grid
    swap_left      = { hyper_shift, "left" },
    swap_right     = { hyper_shift, "right" },
    swap_up        = { hyper_shift, "up" },
    swap_down      = { hyper_shift, "down" },

	-- position and resize focused window
	center_window  = { hyper, "c" },
	full_width     = { hyper, "f" },
	cycle_width    = { hyper, "r" },
	cycle_height   = { hyper_shift, "r" },

	-- move focused window into / out of a column
	slurp_in       = { hyper, "i" },
	barf_out       = { hyper, "o" },

	-- move focused window to a new space and tile
	move_window_1  = { hyper, "1" },
	move_window_2  = { hyper, "2" },
	move_window_3  = { hyper, "3" },
	move_window_4  = { hyper, "4" },
	move_window_5  = { hyper, "5" },
	move_window_6  = { hyper, "6" },
	move_window_7  = { hyper, "7" },
	move_window_8  = { hyper, "8" },
	move_window_9  = { hyper, "9" },
    -- stylua: ignore end
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
