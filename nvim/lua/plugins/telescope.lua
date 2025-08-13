return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    keys = {
      {
        "<leader>,",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      { "<leader>/", function() require("telescope.builtin").live_grep() end, desc = "Grep (root dir)" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader><space>", function() require("telescope.builtin").find_files() end, desc = "Find Files (root dir)" },
      { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { "<leader>fc", function() require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find Files (root dir)" },
      { "<leader>fF", function() require("telescope.builtin").find_files({ hidden = true, no_ignore = true }) end, desc = "Find Files (hidden)" },
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>fR", function() require("telescope.builtin").oldfiles({ cwd = vim.loop.cwd() }) end, desc = "Recent (cwd)" },
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
      { "<leader>s\"", "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
      { "<leader>sg", function() require("telescope.builtin").live_grep() end, desc = "Grep (root dir)" },
      { "<leader>sG", function() require("telescope.builtin").live_grep({ cwd = false }) end, desc = "Grep (cwd)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      { "<leader>sw", function() require("telescope.builtin").grep_string({ word_match = "-w" }) end, desc = "Word (root dir)" },
      { "<leader>sW", function() require("telescope.builtin").grep_string({ cwd = false, word_match = "-w" }) end, desc = "Word (cwd)" },
      { "<leader>sw", function() require("telescope.builtin").grep_string() end, mode = "v", desc = "Selection (root dir)" },
      { "<leader>sW", function() require("telescope.builtin").grep_string({ cwd = false }) end, mode = "v", desc = "Selection (cwd)" },
      { "<leader>uC", function() require("telescope.builtin").colorscheme({ enable_preview = true }) end, desc = "Colorscheme with preview" },
      {
        "<leader>ss",
        "<cmd>Telescope lsp_document_symbols<cr>",
        desc = "Goto Symbol",
      },
      {
        "<leader>sS",
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        desc = "Goto Symbol (Workspace)",
      },
    },
    opts = function()
      local actions = require("telescope.actions")

      return {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
          mappings = {
            i = {
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-b>"] = actions.preview_scrolling_up,
            },
            n = {
              ["q"] = actions.close,
            },
          },
        },
      }
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {},
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer NvimTree" },
    },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
        git = {
          enable = true,
        },
        actions = {
          open_file = {
            quit_on_open = false,
          },
        },
        update_focused_file = {
          enable = true,
          update_cwd = false,
          ignore_list = {},
        },
      })
    end,
  },
}