-----------------------------------------------------------
-- Neovim LSP configuration file
-----------------------------------------------------------

-- Plugin: nvim-lspconfig
-- url: https://github.com/neovim/nvim-lspconfig

local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lsp_status_ok then
  return
end

local cmp_status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_status_ok then
  return
end

local navic_ok, navic = pcall(require, 'nvim-navic')
if not navic_ok then
  return
end

local rt_ok, rt = pcall(require, 'rust-tools')
if not rt_ok then
  return
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Keymaps
  require("lsp.keymaps").setup(client, bufnr)
  -- Code context
  if client.server_capabilities.documentSymbolProvider then
    vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    navic.attach(client, bufnr)
  end

  -- Highlighting references.
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "Document Highlight",
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "Clear All the References",
    })
  end

  -- Formatting on save
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormatting", {}),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({
          filter = function(client)
            return client.name == "null-ls"
          end,
          bufnr = bufnr,
        })
      end
    })
  end

  if client.name == "rust_analyzer" then
    -- Hover actions
    vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
    -- Code action groups
    vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
  end
end

vim.diagnostic.config({
  update_in_insert = false,
  virtual_text = false,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Rust
local extension_path = vim.env.HOME .. '/.local/share/nvim/mason/packages/codelldb/extension/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'


rt.setup({
  tools = {
    inlay_hints = {
      auto = false
    }
  },
  dap = {
    adapter = require('rust-tools.dap').get_codelldb_adapter(
      codelldb_path, liblldb_path)
  },
  server = {
    on_attach = on_attach,
    capabilities = capabilities
  },
})

-- Golang
local go_ok, go = pcall(require, 'go')
if not go_ok then
  return
end

go.setup({
  lsp_inlay_hints = { enable = true },
  lsp_diag_virtual_text = false,
  lsp_on_attach = on_attach,
  lsp_cfg = {
    capabilities = capabilities,
  },
})

local servers = { 'bashls', 'pyright', 'clangd', 'jsonls', 'cssls', 'html' }
-- Call setup
for _, lsp in ipairs(servers) do
  if lsp == "clangd" then
    capabilities.offsetEncoding = { "utf-16" }
  end
  lspconfig[lsp].setup ({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end


local inlayhints_status_ok, inlayhints_lsp = pcall(require, 'lsp-inlayhints')
if not inlayhints_status_ok then
  return
end

