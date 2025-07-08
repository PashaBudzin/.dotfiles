-- Helper function for transparency formatting
local alpha = function()
    return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
end

if vim.g.neovide then
    vim.g.transparency = 0.8
end
