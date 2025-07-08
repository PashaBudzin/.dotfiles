local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local colorsaver = require("pasha.colors.save-colors")

local themes = vim.fn.getcompletion('', 'color')

local colors = function(opts)
    opts = opts or {}
    pickers.new(opts, {
        prompt_title = "colors",
        finder = finders.new_table {
            results = themes
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()

                local selected = selection[1]
                vim.cmd.colorscheme(selected)
                colorsaver.save_theme(selected)
            end)

            return true
        end,
        on_input = function(prompt_bufnr, input)
            local selected = actions.get_selected_entry(prompt_bufnr)

            vim.cmd.colorscheme(selected.value)
        end,
    }):find()
end

vim.api.nvim_create_user_command("PickColors", function()
    colors(require("telescope.themes"))
end, {})
