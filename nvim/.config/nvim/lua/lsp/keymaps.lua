-----------------------------------------------------------
-- Neovim LSP keymaps configuration file
-----------------------------------------------------------

local M = {}

local status_ok, whichkey = pcall(require, 'which-key')
if not status_ok then
  return
end

function M.setup(client, bufnr)
  local opts = { noremap=true, silent=true, buffer = bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  local mappings = {
    l = {
      name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
      c = { "<cmd>CodeActionMenu<CR>", "Code action menu" },
      d = { "<cmd>lua require('telescope.builtin').diagnostics()<CR>", "Diagnostics" },
      f = { "<cmd>Lspsaga lsp_finder<CR>", "Finder" },
      i = { "<cmd>LspInfo<CR>", "Lsp Info" },
      r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
      R = { "<cmd>lua require('telescope.builtin').lsp_references()<CR>", "References" },
      s = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", "Document Symbols" },
      S = { "<cmd>Vista!!<CR>", "Document symbols tree" },
      L = { "<cmd>lua vim.lsp.codelens.refresh()<CR>", "Refresh CodeLens" },
      l = { "<cmd>lua vim.lsp.codelens.run()<CR>", "Run CodeLens" },
      f = {function() vim.lsp.buf.format {
        async = true,
        filter = function(client)
          return client.name == "null-ls"
        end,
      } end, "Format document"}
    },

    d = {
      name = "Debug",
      R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
      E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
      C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
      U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
      b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
      c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
      d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
      e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
      g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
      i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
      o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
      p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
      q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
      r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
      s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
      t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
      x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
      u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
      w = {
        name = "Widgets",
        h = { function()
          require('dap.ui.widgets').hover()
        end, "Hover Variables" },
        s = { function()
          local widgets = require('dap.ui.widgets')
          widgets.centered_float(widgets.scopes)
        end, "Scopes" },
        p = { function()
          require('dap.ui.widgets').preview()
        end, "Preview" },
        f = { function()
          local widgets = require('dap.ui.widgets')
          widgets.centered_float(widgets.frames)
        end, "Frames" },
      }
    },

    x = {
      name = "Diagnostic",
      x = { "<cmd>TroubleToggle<cr>", "Diagnostics list" },
      w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace diagnostics" },
      d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document diagnostics" },
      l = { "<cmd>TroubleToggle loclist<cr>", "Location list" },
      q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
      f = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Float diagnostics"},
    },

    g = {
      name = "Goto",
      d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
      D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
      h = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
      i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
      t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition" },
    },
    w = {
      name = "Workspace",
      a = { "<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add workspace"},
      r = { "<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove workspace"},
      l = { function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "Print workspace folders" },
    },
  }

  local keymap_v = {
    name = "Debug",
    e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
  }

  whichkey.register(mappings, {
    mode = "n",
    prefix = "<leader>",
    buffer = bufnr,
    silent = true,
    noremap = true,
    nowait = false,
  })

  whichkey.register(keymap_v, {
    mode = "v",
    prefix = "<leader>",
    buffer = bufnr,
    silent = true,
    noremap = true,
    nowait = false,
  })
end

return M
