return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
        {
            "<leader>en",
            function()
                require("neo-tree.command").execute({ toggle = true, dir = vim.fn.stdpath("config") })
            end,
            desc = "Explorer NeoTree (Root Dir)",
        },
        {
            "<leader>ef",
            function()
                require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
            end,
            desc = "Explorer NeoTree (cwd)",
        },
        {
            "<leader>eg",
            function()
                require("neo-tree.command").execute({ source = "git_status", toggle = true })
            end,
            desc = "Git Explorer",
        },
        {
            "<leader>eb",
            function()
                require("neo-tree.command").execute({ source = "buffers", toggle = true })
            end,
            desc = "Buffer Explorer",
        },
    },
    init = function()
        vim.api.nvim_create_autocmd("BufEnter", {
            group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
            desc = "Start Neo-tree with directory",
            once = true,
            callback = function()
                if package.loaded["neo-tree"] then
                    return
                else
                    local stats = vim.uv.fs_stat(vim.fn.argv(0))
                    if stats and stats.type == "directory" then
                        require("neo-tree")
                    end
                end
            end,
        })
    end,
    deactivate = function()
        vim.cmd([[Neotree close]])
    end,
    config = function()
        local icons = require("h033s.utils.icons")

        require("neo-tree").setup({
            close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,
            sort_case_insensitive = false,
            default_component_configs = {
                indent = {
                    indent_size = 2,
                    padding = 1, -- extra padding on left hand side
                    -- indent guides
                    with_markers = true,
                    indent_marker = "│",
                    last_indent_marker = "└",
                    highlight = "NeoTreeIndentMarker",
                    -- expander config, needed for nesting files
                    with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = icons.ui.ChevronRight,
                    expander_expanded = icons.ui.ChevronShortDown,
                    expander_highlight = "NeoTreeExpander",
                },
                icon = {
                    folder_closed = icons.ui.Folder,
                    folder_open = icons.ui.FolderOpen,
                    folder_empty = icons.ui.EmptyFolder,
                    -- The next two settings are only a fallback, if you use nvim-web-devicons
                    -- and configure default icons there then these will never be used.
                    default = "*",
                    highlight = "NeoTreeFileIcon",
                },
                modified = {
                    symbol = "M",
                    highlight = "NeoTreeModified",
                },
                git_status = {
                    symbols = {
                        -- Change type
                        added = icons.git.LineAdded,
                        modified = icons.git.LineModified,
                        deleted = icons.git.FileDeleted,
                        renamed = icons.git.FileRenamed,
                        -- Status type
                        untracked = icons.git.FileUntracked,
                        ignored = icons.git.FileIgnored,
                        unstaged = icons.git.FileUnstaged,
                        staged = icons.git.FileStaged,
                        conflict = icons.git.Conflic,
                    },
                },
            },
            window = {
                position = "left",
                width = 40,
                mapping_options = {
                    noremap = true,
                    nowait = true,
                },

                mappings = {
                    ["l"] = "open",
                    ["h"] = "close_node",
                    ["C"] = "close_node",
                    ["S"] = "open_split",
                    ["s"] = "open_vsplit",
                    ["t"] = "open_tabnew",
                    ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
                    ["a"] = { "add", config = { show_path = "none" } }, -- "none", "relative", "absolute"
                    ["A"] = "add_directory",
                    ["d"] = "delete",
                    ["r"] = "rename",
                    ["y"] = "copy_to_clipboard",
                    ["x"] = "cut_to_clipboard",
                    ["p"] = "paste_from_clipboard",
                    ["<M-h>"] = "toggle_hidden",
                    ["H"] = "none",
                },
            },
            filesystem = {
                always_show = { -- remains visible even if other settings would normally hide it
                    ".gitignored",
                },
                never_show = {
                    ".DS_Store",
                    --"thumbs.db"
                },
                hijack_netrw_behavior = "open_default",
            },
        })
    end,
}
