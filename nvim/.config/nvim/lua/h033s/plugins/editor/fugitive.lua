return {
    "tpope/vim-fugitive",

    config = function ()

        vim.keymap.set('n', '<leader>gs', ':Git<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit!<CR>')
        vim.keymap.set('n', '<leader>ah', ':diffget //2<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>al', ':diffget //3<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>ch', '[c', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>cl', ']c', { noremap = true, silent = true })
    end
}
