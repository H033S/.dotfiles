return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        --Complention
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",

        --Snippets
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",

        --Lsp Progress
        "j-hui/fidget.nvim",

        --Tool Installer
        "WhoIsSethDaniel/mason-tool-installer",

        --Schemas for Json Autocomplete
        "b0o/schemastore.nvim",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local border = {
            { '┌', 'FloatBorder' },
            { '─', 'FloatBorder' },
            { '┐', 'FloatBorder' },
            { '│', 'FloatBorder' },
            { '┘', 'FloatBorder' },
            { '─', 'FloatBorder' },
            { '└', 'FloatBorder' },
            { '│', 'FloatBorder' },
        }

        require("fidget").setup({})
        require("mason").setup({
            ui = {
                border = "rounded",
            },
        })
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "angularls",
                "html",
                "cssls",
                "tsserver",
                "pyright",
                "jdtls",
                "jsonls",
                "lemminx",
            },
            handlers = {

                -- Cannot setup JDTLS with normal setup
                function(server_name)
                    if server_name ~= "jdtls" then
                        lspconfig[server_name].setup({
                            capabilities = capabilities,
                            handlers = {
                                ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
                                ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = border})
                            }
                        })
                    end
                end,

                lspconfig["angularls"].setup({
                    capabilities = capabilities,
                    filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "angular.html" },
                }),

                lspconfig["jsonls"].setup({
                    capabilities = capabilities,
                    filetypes = { "json", "jsonc" },
                    settings = {
                        json = {
                            schemas = require("schemastore").json.schemas(),
                            validate = { enable = true },
                        },
                    },
                }),
            },
        })

        require("mason-tool-installer").setup({
            ensure_installed = {
                "java-debug-adapter",
                "java-test",

                --Angular
                "prettier",
                --Lua
                "stylua",
                -- Python
                "flake8",
                "black",
            },
        })

        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local icons = require("h033s.utils.icons")

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            completion = {
                preselect = "item",
                completeopt = "menu,menuone,noinsert",
            },
            window = {
                -- Add borders to completions popups
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<M-k>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<M-j>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<Tab>"] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            }),
            experimental = {
                ghost_text = false,
            },
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    vim_item.kind = icons.kind[vim_item.kind]
                    vim_item.menu = ({
                        nvim_lsp = "",
                        nvim_lua = "",
                        luasnip = "",
                        buffer = "",
                        path = "",
                        emoji = "",
                    })[entry.source.name]
                    if entry.source.name == "emoji" then
                        vim_item.kind = icons.misc.Smiley
                        vim_item.kind_hl_group = "CmpItemKindEmoji"
                    end
                    if entry.source.name == "cmp_tabnine" then
                        vim_item.kind = icons.misc.Robot
                        vim_item.kind_hl_group = "CmpItemKindTabnine"
                    end

                    return vim_item
                end,
            },
        })

        local signValues = {
            { name = "DiagnosticSignError", text = icons.diagnostics.Error },
            { name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
            { name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
            { name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
        }
        vim.diagnostic.config({
            signs = {
                active = true,
                values = signValues,
            },
            virtual_text = true,
            update_in_insert = true,
            underline = false,
            severity_sort = true,
            float = {
                focusable = true,
                style = "minimal",
                border = "rounded",
            },
        })
        -- Setting Signs
        for _, sign in ipairs(signValues) do
            vim.fn.sign_define(sign.name, {
                texthl = sign.name,
                text = sign.text,
                numhl = sign.name,
            })
        end
    end,
}
