require('user.base')
require('user.highlights')
require('user.maps')
require('user.plugins')

local has = vim.fn.has
local is_mac = has "macunix"
local is_win = has "win32"
local is_wsl = has "wsl"

if is_mac == 1 then
  require('user.macos')
end
if is_win == 1 then
  require('user.windows')
end
if is_wsl == 1 then
  require('user.wsl')
end
