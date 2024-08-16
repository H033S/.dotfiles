-- return {
--     -- 'sainnhe/sonokai',
--     -- 'jacoborus/tender.vim',
--     --
--     'AlexvZyl/nordic.nvim',
--
--     lazy = false,
--     priority = 1000,
--     config = function()
--
--         require("nordic").setup({
--             override = {
--                 CursorLineNr = {
--                     fg ="#C0C8D8"
--                 },
--                 CursorLine = {
--                     bg = "#434C5E"
--                 },
--                 Visual = {
--                     bg = "#434C5E"
--                 }
--             }
--         })
--         vim.cmd.colorscheme('nordic')
--         vim.cmd [[g:lightline = { 'colorscheme': 'nordic' }]]
--         vim.api.nvim_set_hl(0, 'NormalFloat', {bg = 'none'})
--         vim.api.nvim_set_hl(0, 'Normal', {bg = 'none'})
--     end
-- }

return {
    "rose-pine/neovim",
    name = "rose-pine",

    config = function()

        require("rose-pine").setup({
            styles = {
                transparency = false--true,
            },
        })

        vim.cmd.colorscheme("rose-pine-moon")
        vim.api.nvim_set_hl(0, 'NormalFloat', {bg = 'none'})
        vim.api.nvim_set_hl(0, 'Normal', {bg = 'none'})
    end,

}





