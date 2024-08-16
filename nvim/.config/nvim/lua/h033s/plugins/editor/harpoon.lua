return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { "nvim-lua/plenary.nvim" },

    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        vim.keymap.set("n", "<leader>ha", function()
            harpoon:list():add()
        end)
        vim.keymap.set("n", "<leader>hw", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)

        vim.keymap.set("n", "<leader>wh", function()
            harpoon:list():select(1)
        end)
        vim.keymap.set("n", "<leader>wj", function()
            harpoon:list():select(2)
        end)
        vim.keymap.set("n", "<leader>wk", function()
            harpoon:list():select(3)
        end)
        vim.keymap.set("n", "<leader>wl", function()
            harpoon:list():select(4)
        end)
    end,
}
