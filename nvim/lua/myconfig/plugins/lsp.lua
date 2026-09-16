return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "l3mon4d3/luasnip",
  },
  config = function()
    require("mason").setup()

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- 1. Configure Julia natively via Neovim 0.11+ API
    vim.lsp.config("julials", {
      cmd = {
        "julia",
        "--startup-file=no",
        "--history-file=no",
        "-e",
        [[
          using LanguageServer
          using Pkg
          import StaticLint
          import SymbolServer
          
          env_path = get(ENV, "JULIA_PROJECT", "project")
          server = LanguageServer.LanguageServerInstance(stdin, stdout, false, env_path)
          server.runlinter = true
          run(server)
        ]],
      },
      capabilities = capabilities,
    })
    vim.lsp.enable("julials")

    -- 2. Configure Mason-managed LSPs using modern handlers
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "pyright",
        "clangd",
        "jdtls",
        "bashls",
      },
      handlers = {
        function(server_name)
          vim.lsp.config(server_name, {
            capabilities = capabilities,
          })
          vim.lsp.enable(server_name)
        end,
      },
    })

    -- 3. Autocompletion setup
    local cmp = require("cmp")
    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ["<c-p>"] = cmp.mapping.select_prev_item(),
        ["<c-n>"] = cmp.mapping.select_next_item(),
        ["<c-y>"] = cmp.mapping.confirm({ select = true }),
        ["<c-space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
      }),
    })

    -- 4. Keymaps on LSP attach
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
      end,
    })
  end,
}
