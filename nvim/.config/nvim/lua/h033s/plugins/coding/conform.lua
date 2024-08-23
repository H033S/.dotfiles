return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				python = { "isort", "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				lua = { "stylua" },
			},
		})

		vim.keymap.set({ "v", "n" }, "<leader>fb", function()
			conform.format({

				async = false,
				timeout_ms = 500,
				lsp_format = "fallback",
			})
		end, { desc = "[F]ormat [B]uffer" })
	end,
}
