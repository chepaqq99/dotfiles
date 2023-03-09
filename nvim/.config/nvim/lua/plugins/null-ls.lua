-----------------------------------------------------------
-- null-ls configuration file
-----------------------------------------------------------

-- Plugin: null-ls
-- url: https://github.com/jose-elias-alvarez/null-ls.nvim


local status_ok, null_ls = pcall(require, 'null-ls')
if not status_ok then
  return
end

sources = {
  null_ls.builtins.formatting.gofumpt,
  null_ls.builtins.diagnostics.golangci_lint,
  null_ls.builtins.formatting.clang_format,
  null_ls.builtins.formatting.rustfmt,
  null_ls.builtins.diagnostics.clang_check,
  null_ls.builtins.formatting.golines.with({
    extra_args = {
      "--max-len=180",
      "--base-formatter=gofumpt",
    },
  })
}

null_ls.setup({ sources = sources, debounce = 1000, default_timeout = 5000 })
