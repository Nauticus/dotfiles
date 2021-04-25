" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time("Luarocks path setup", true)
local package_path_str = "/Users/emanuilganchev/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/emanuilganchev/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/emanuilganchev/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/emanuilganchev/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/emanuilganchev/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time("Luarocks path setup", false)
time("try_loadstring definition", true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

time("try_loadstring definition", false)
time("Defining packer_plugins", true)
_G.packer_plugins = {
  ["completion-treesitter"] = {
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/completion-treesitter"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/editorconfig-vim"
  },
  fzf = {
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    config = { "require('config.plugins.fzf')" },
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["gitsigns.nvim"] = {
    config = { "require('config.plugins.gitsigns')" },
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  gruvbox = {
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/gruvbox"
  },
  ["lualine.nvim"] = {
    config = { "require('config.plugins.lualine')" },
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "require('config.plugins.autopairs')" },
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-compe"] = {
    config = { "require('config.plugins.compe')" },
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    config = { "require('config.plugins.lsp')" },
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    config = { "require('config.plugins.treesitter')" },
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ultisnips = {
    config = { "\27LJ\2\n>\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\n<nop>\27UltiSnipsExpandTrigger\6g\bvim\0" },
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/ultisnips"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-dirvish"] = {
    config = { "require('config.plugins.dirvish')" },
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/vim-dirvish"
  },
  ["vim-dirvish-git"] = {
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/vim-dirvish-git"
  },
  ["vim-fubitive"] = {
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/vim-fubitive"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-gruvbox8"] = {
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/vim-gruvbox8"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/vim-rhubarb"
  },
  ["vim-sneak"] = {
    config = { "require('config.plugins.sneak')" },
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/vim-sneak"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/vim-snippets"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/emanuilganchev/.local/share/nvim/site/pack/packer/start/vim-surround"
  }
}

time("Defining packer_plugins", false)
-- Config for: nvim-lspconfig
time("Config for nvim-lspconfig", true)
require('config.plugins.lsp')
time("Config for nvim-lspconfig", false)
-- Config for: nvim-autopairs
time("Config for nvim-autopairs", true)
require('config.plugins.autopairs')
time("Config for nvim-autopairs", false)
-- Config for: fzf.vim
time("Config for fzf.vim", true)
require('config.plugins.fzf')
time("Config for fzf.vim", false)
-- Config for: nvim-compe
time("Config for nvim-compe", true)
require('config.plugins.compe')
time("Config for nvim-compe", false)
-- Config for: vim-sneak
time("Config for vim-sneak", true)
require('config.plugins.sneak')
time("Config for vim-sneak", false)
-- Config for: gitsigns.nvim
time("Config for gitsigns.nvim", true)
require('config.plugins.gitsigns')
time("Config for gitsigns.nvim", false)
-- Config for: vim-dirvish
time("Config for vim-dirvish", true)
require('config.plugins.dirvish')
time("Config for vim-dirvish", false)
-- Config for: nvim-treesitter
time("Config for nvim-treesitter", true)
require('config.plugins.treesitter')
time("Config for nvim-treesitter", false)
-- Config for: ultisnips
time("Config for ultisnips", true)
try_loadstring("\27LJ\2\n>\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\n<nop>\27UltiSnipsExpandTrigger\6g\bvim\0", "config", "ultisnips")
time("Config for ultisnips", false)
-- Config for: lualine.nvim
time("Config for lualine.nvim", true)
require('config.plugins.lualine')
time("Config for lualine.nvim", false)
if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
