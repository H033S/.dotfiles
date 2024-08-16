return {
    -- https://github.com/rcarriga/nvim-dap-ui
    'rcarriga/nvim-dap-ui',
    event = 'VeryLazy',
    dependencies = {
        'mfussenegger/nvim-dap',
        'nvim-neotest/nvim-nio',
        'theHamsta/nvim-dap-virtual-text',
        'nvim-telescope/telescope-dap.nvim',
    },
    opts = {
        controls = {
            element = "repl",
            enabled = false,
            icons = {
                disconnect = "",
                pause = "",
                play = "",
                run_last = "",
                step_back = "",
                step_into = "",
                step_out = "",
                step_over = "",
                terminate = ""
            }
        },
        element_mappings = {},
        expand_lines = true,
        floating = {
            border = "single",
            mappings = {
                close = { "q", "<Esc>" }
            }
        },
        force_buffers = true,
        icons = {
            collapsed = "",
            current_frame = "",
            expanded = ""
        },
        layouts = {
            {
                elements = {
                    {
                        id = "scopes",
                        size = 0.50
                    },
                    {
                        id = "stacks",
                        size = 0.30
                    },
                    {
                        id = "watches",
                        size = 0.10
                    },
                    {
                        id = "breakpoints",
                        size = 0.10
                    }
                },
                size = 40,
                position = "left", -- Can be "left" or "right"
            },
            {
                elements = {
                    "repl",
                    "console",
                },
                size = 10,
                position = "bottom", -- Can be "bottom" or "top"
            }
        },
        mappings = {
            edit = "e",
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            repl = "r",
            toggle = "t"
        },
        render = {
            indent = 1,
            max_value_lines = 100
        }
    },

    config = function (_, opts)

        local dap = require('dap')
        require('dapui').setup(opts)

        dap.listeners.after.event_initialized["dapui_config"] = function()
            require('dapui').open()
        end

        dap.listeners.before.event_terminated["dapui_config"] = function()
            -- Commented to prevent DAP UI from closing when unit tests finish
            -- require('dapui').close()
        end

        dap.listeners.before.event_exited["dapui_config"] = function()
            -- Commented to prevent DAP UI from closing when unit tests finish
            -- require('dapui').close()
        end

        vim.keymap.set("n", "<leader>bb", function() require'dap'.toggle_breakpoint() end)
        vim.keymap.set("n", "<leader>bc", function() require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
        vim.keymap.set("n", "<leader>bl", function() require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end )
        vim.keymap.set("n", '<leader>br', function() require'dap'.clear_breakpoints() end )
        vim.keymap.set("n", "<leader>dc", function() require'dap'.continue() end )
        vim.keymap.set("n", "<leader>dj", function() require'dap'.step_over() end )
        vim.keymap.set("n", "<leader>dk", function() require'dap'.step_into() end )
        vim.keymap.set("n", "<leader>do", function() require'dap'.step_out() end )
        vim.keymap.set("n", '<leader>dd', function() require('dap').disconnect(); require('dapui').close(); end)
        vim.keymap.set("n", '<leader>dt', function() require('dap').terminate(); require('dapui').close(); end)
        vim.keymap.set("n", "<leader>dr", function() require('dap').repl.toggle() end )
        vim.keymap.set("n", "<leader>dl", function() require('dap').run_last() end )
        vim.keymap.set("n", '<leader>di', function() require "dap.ui.widgets".hover() end)
        vim.keymap.set("n", '<leader>d?', function() local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes) end)
        vim.keymap.set("n", '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>')
        vim.keymap.set("n", '<leader>df', '<cmd>Telescope dap frames<cr>')
        vim.keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>')
        vim.keymap.set("n", '<leader>de', function() require('telescope.builtin').diagnostics({default_text=":E:"}) end)


        dap.configurations.java = {
            {
                name = "Debug Launch (2GB)";
                type = 'java';
                request = 'launch';
                vmArgs = "" ..
                    "-Xmx2g "
            },
            {
                name = "Debug Attach (8000)";
                type = 'java';
                request = 'attach';
                hostName = "127.0.0.1";
                port = 8000;
            },
            {
                name = "Debug Attach (5005)";
                type = 'java';
                request = 'attach';
                hostName = "127.0.0.1";
                port = 5005;
            },
        }
    end
}
