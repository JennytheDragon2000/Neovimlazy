return {
	"ThePrimeagen/git-worktree.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{
			"<leader>gwl",
			function()
				require("telescope").extensions.git_worktree.git_worktrees()
			end,
			desc = "List git worktrees",
		},
		{
			"<leader>gwc",
			function()
				require("telescope").extensions.git_worktree.create_git_worktree()
			end,
			desc = "Create git worktree",
		},
	},
	config = function()
		require("git-worktree").setup()
		require("telescope").load_extension("git_worktree")
	end,
}
