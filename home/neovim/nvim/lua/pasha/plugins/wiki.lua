return {
	{
		enabled = false,
		"vimwiki/vimwiki",
		init = function()
			vim.g.vimwiki_list = {
				{
					path = "~/Documents/Notes",
					syntax = "markdown",
					ext = ".md",
				},
			}
		end,
	},
}
