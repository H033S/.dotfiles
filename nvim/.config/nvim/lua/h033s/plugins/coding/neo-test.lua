return {
	{
		"rcasia/neotest-java",
		ft = "java",
	},
	{
		"nvim-neotest/neotest-python",
		ft = "python",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{

		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},

		config = function()
			local neotest = require("neotest")

			neotest.setup({

				adapters = {
					require("neotest-python"),
					require("neotest-java"),
				},
			})

            vim.keymap.set("n", "<leader>trA", function()
                neotest.run.run(vim.uv.cwd())
            end, { desc = "Run All Test Files" })

			vim.keymap.set("n", "<leader>tr", function()
				neotest.run.run(vim.fn.expand("%"))
			end, { desc = "Run File" })

			vim.keymap.set("n", "<leader>tra", function()
				neotest.run.run()
			end, { desc = "Run Nearest Test" })

			vim.keymap.set("n", "<leader>ts", function()
				neotest.summary.toggle()
			end, { desc = "Toggle Summary" })

			vim.keymap.set("n", "<leader>to", function()
				require("neotest").output.open({ enter = true, auto_close = true })
			end, { desc = "Show Output" })

			vim.keymap.set("n", "<leader>tS", function()
				require("neotest").run.stop()
			end, { desc = "Stop" })

		end,
	},
}
