return {
    "folke/todo-comments.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    opts = {},
    keys = {
        { "]t",         function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
        { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
        { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
        { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
    },
}
