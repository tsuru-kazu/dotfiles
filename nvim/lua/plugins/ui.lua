return {
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          compile_path = vim.fn.stdpath("cache") .. "/github-theme",
          compile_file_suffix = "_compiled",
          hide_end_of_buffer = true,
          hide_nc_statusline = true,
          transparent = false,
          terminal_colors = true,
          dim_inactive = false,
          module_default = true,
          styles = {
            comments = "italic",
            functions = "NONE",
            keywords = "bold",
            variables = "NONE",
            conditionals = "NONE",
            constants = "NONE",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
          },
          inverse = {
            match_paren = false,
            visual = false,
            search = false,
          },
        },
        palettes = {},
        specs = {},
        groups = {},
      })
      vim.cmd.colorscheme("github_dark_high_contrast")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        vim.o.statusline = " "
      else
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      vim.o.laststatus = vim.g.lualine_laststatus

      return {
        options = {
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
        },
        sections = {
          lualine_a = { 
            {
              "mode",
              color = function()
                local gitsigns = vim.b.gitsigns_status_dict
                local is_modified = vim.bo.modified
                
                -- gitsignsの変更チェックを厳密に
                local has_git_changes = false
                if gitsigns then
                  has_git_changes = (gitsigns.added and gitsigns.added > 0) or
                                  (gitsigns.changed and gitsigns.changed > 0) or
                                  (gitsigns.removed and gitsigns.removed > 0)
                end
                
                if is_modified or has_git_changes then
                  -- 変更がある場合は赤
                  return { fg = "#000000", bg = "#ff6666", gui = "bold" }
                else
                  -- 変更がない場合はデフォルトテーマを使用
                  return {}
                end
              end,
            }
          },
          lualine_b = { 
            {
              "branch",
              color = function()
                local gitsigns = vim.b.gitsigns_status_dict
                local is_modified = vim.bo.modified
                
                -- gitsignsの変更チェックを厳密に
                local has_git_changes = false
                if gitsigns then
                  has_git_changes = (gitsigns.added and gitsigns.added > 0) or
                                  (gitsigns.changed and gitsigns.changed > 0) or
                                  (gitsigns.removed and gitsigns.removed > 0)
                end
                
                if is_modified or has_git_changes then
                  -- 変更がある場合は赤
                  return { fg = "#000000", bg = "#ff6666", gui = "bold" }
                else
                  -- 変更がない場合はデフォルトテーマを使用
                  return {}
                end
              end,
            }
          },

          lualine_c = {
            {
              "filename",
              path = 1,
              color = function()
                if vim.bo.modified then
                  return { fg = "#ff6b6b", gui = "bold" }
                end
                return {}
              end,
            },
            {
              "diagnostics",
              symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hint = " ",
              },
            },
          },
          lualine_x = {
            {
              function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  local status = ""
                  if gitsigns.added and gitsigns.added > 0 then
                    status = status .. " +" .. gitsigns.added
                  end
                  if gitsigns.changed and gitsigns.changed > 0 then
                    status = status .. " ~" .. gitsigns.changed
                  end
                  if gitsigns.removed and gitsigns.removed > 0 then
                    status = status .. " -" .. gitsigns.removed
                  end
                  return status ~= "" and "󰊢" .. status or ""
                end
                return ""
              end,
              color = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns and (gitsigns.added or gitsigns.changed or gitsigns.removed) then
                  return { fg = "#ff6b6b", gui = "bold" }
                end
                return { fg = "#50c878" }
              end,
            },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = { fg = "#ff9e64" },
            },
            {
              "diff",
              symbols = {
                added = " ",
                modified = " ",
                removed = " ",
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
            "encoding",
            "fileformat",
            "filetype",
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return " " .. os.date("%R")
            end,
          },
        },
        extensions = { "nvim-tree", "lazy" },
      }
    end,
    config = function(_, opts)
      require("lualine").setup(opts)
      
      -- ステータスラインの色を動的に更新するためのオートコマンド
      vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged", "TextChangedI", "User" }, {
        pattern = "*",
        callback = function()
          require("lualine").refresh()
        end,
      })
    end,
  },

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    },
    opts = {
      options = {
        close_command = function(n) require("mini.bufremove").delete(n, false) end,
        right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
    main = "ibl",
  },

  {
    "echasnovski/mini.icons",
    lazy = false,
    priority = 1000,
    config = function()
      require("mini.icons").setup()
      require("mini.icons").mock_nvim_web_devicons()
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      spec = {
        { "g", group = "+goto" },
        { "gz", group = "+surround" },
        { "]", group = "+next" },
        { "[", group = "+prev" },
        { "<leader><tab>", group = "+tabs" },
        { "<leader>b", group = "+buffer" },
        { "<leader>c", group = "+code" },
        { "<leader>f", group = "+file/find" },
        { "<leader>g", group = "+git" },
        { "<leader>gh", group = "+hunks" },
        { "<leader>q", group = "+quit/session" },
        { "<leader>s", group = "+search" },
        { "<leader>u", group = "+ui" },
        { "<leader>w", group = "+windows" },
        { "<leader>x", group = "+diagnostics/quickfix" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
    end,
  },

  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<leader>bd",
        function()
          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = "Delete Buffer",
      },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
    opts = {},
  },

  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      local function lazy_load()
        vim.ui.select = function(...)
          require("lazy").load({ plugins = { "dressing.nvim" } })
          return vim.ui.select(...)
        end
        vim.ui.input = function(...)
          require("lazy").load({ plugins = { "dressing.nvim" } })
          return vim.ui.input(...)
        end
      end
      
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = lazy_load,
        once = true,
      })
    end,
  },

  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
      providers = {
        "lsp",
        "regex",
      },
      filetypes_denylist = {
        "dirvish",
        "fugitive",
        "alpha",
        "NvimTree",
        "lazy",
        "neogitstatus",
        "Trouble",
        "lir",
        "Outline",
        "spectre_panel",
        "toggleterm",
        "DressingSelect",
        "TelescopePrompt",
      },
      min_count_to_highlight = 1,
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
              { find = "Node%.js v%d+%.%d+%.%d+" },
            },
          },
          view = "mini",
        },
        {
          filter = {
            event = "msg_show",
            find = "Node%.js v%d+%.%d+%.%d+",
          },
          opts = { skip = true },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
}
