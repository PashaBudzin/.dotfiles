local builtin = require("telescope.builtin")

require("telescope").setup({
	defaults = {
		previewer = false,
		-- Try forcing a normal buffer
		buffer_previewer_maker = function(filepath, bufnr, opts)
			opts.use_ft_detect = true
			require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, opts)
		end,
	},
})

require("telescope").load_extension("fzf")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
