return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
      },
      inlay_hints = {
        enabled = true,
      },
      codelens = {
        enabled = false,
      },
      document_highlight = {
        enabled = true,
      },
      capabilities = {},
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        solargraph = {
          settings = {
            solargraph = {
              diagnostics = true,
              completion = true,
              definitions = true,
              references = true,
              rename = true,
              symbols = true,
              folding = true,
              useBundler = false,
            },
          },
        },
      },
      setup = {
        ruby_lsp = function()
          return true  -- ruby-lspを無効化
        end,
        solargraph = function(_, opts)
          -- Mason管理のsolargraphを明示的に使用
          require("lspconfig").solargraph.setup(vim.tbl_deep_extend("force", opts, {
            cmd = { vim.fn.stdpath("data") .. "/mason/bin/solargraph", "stdio" },
          }))
          return true
        end,
      },
    },
    config = function(_, opts)
      local function has_plugin(name)
        return require("lazy.core.config").spec.plugins[name] ~= nil
      end
      
      if has_plugin("neoconf.nvim") then
        local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
        require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local buffer = ev.buf
          local client = vim.lsp.get_client_by_id(ev.data.client_id)

          local function map(mode, lhs, rhs, opts)
            opts = opts or {}
            opts.buffer = buffer
            vim.keymap.set(mode, lhs, rhs, opts)
          end

          map("n", "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, { desc = "Goto Definition" })
          map("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
          map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
          map("n", "gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, { desc = "Goto Implementation" })
          map("n", "gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, { desc = "Goto T[y]pe Definition" })
          map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
          map("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
          map("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
          map("n", "<leader>cc", vim.lsp.codelens.run, { desc = "Run Codelens" })
          map("n", "<leader>cC", vim.lsp.codelens.refresh, { desc = "Refresh & Display Codelens" })
          map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })

          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = ev.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = ev.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
              end,
            })
          end

          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map("n", "<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(buffer), buffer)
            end, { desc = "Toggle Inlay Hints" })
          end
        end,
      })

      local signs = {
        Error = " ",
        Warn = " ",
        Hint = " ",
        Info = " ",
      }
      for name, icon in pairs(signs) do
        name = "DiagnosticSign" .. name
        vim.diagnostic.config({
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = signs.Error,
              [vim.diagnostic.severity.WARN] = signs.Warn,
              [vim.diagnostic.severity.HINT] = signs.Hint,
              [vim.diagnostic.severity.INFO] = signs.Info,
            }
          }
        })
      end

      if opts.inlay_hints.enabled then
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            if not (args.data and args.data.client_id) then
              return
            end

            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.server_capabilities.inlayHintProvider then
              vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end
          end,
        })
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      
      local ensure_installed = {}
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.mason == false then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if have_mason then
        mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
      end
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = "mason.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",           -- Lua
        "solargraph",       -- Ruby LSP (via Mason)
        -- "tsserver",      -- TypeScript/JavaScript (replaced by typescript-tools)
        "pyright",          -- Python
        "rust_analyzer",    -- Rust
        "gopls",            -- Go
        "clangd",           -- C/C++
        "html",             -- HTML
        "cssls",            -- CSS
        "jsonls",           -- JSON
        "yamlls",           -- YAML
      },
    },
  },
}