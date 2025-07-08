local M = {}

function M.save_theme(string)
    local filename = vim.fn.stdpath("config") .. "color"
    local file = io.open(filename, "w")
    if file then
        file:write(string)
        file:close()
    else
        error("Error: Unable to open file for writing: " .. filename)
    end
end

function M.load_theme(fallback)
    local filename = vim.fn.stdpath("config") .. "color"

    local file = io.open(filename, "r")

    if file then
        local theme = file:read("*all")
        file:close()
        return theme
    else
        M.save_theme(fallback)
        return fallback
    end
end

return M
