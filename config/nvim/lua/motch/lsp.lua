local lspconfig = require("lspconfig")

M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local has_run = {}

M.on_attach = function(_, bufnr)
  local map_opts = { remap = false, silent = true, buffer = bufnr }

  vim.keymap.set("n", "df", vim.lsp.buf.formatting_seq_sync, map_opts)
  vim.keymap.set("n", "gd", vim.diagnostic.open_float, map_opts)
  vim.keymap.set("n", "dt", vim.lsp.buf.definition, map_opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, map_opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.implementation, map_opts)
  -- vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, map_opts)
  vim.keymap.set("n", "1gD", vim.lsp.buf.type_definition, map_opts)
  vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, map_opts)
  vim.keymap.set("n", "g0", require("telescope.builtin").lsp_document_symbols, map_opts)
  vim.keymap.set("n", "gW", require("telescope.builtin").lsp_workspace_symbols, map_opts)

  vim.keymap.set(
    { "i", "s" },
    "<C-l>",
    [[vsnip#available(1) ? "\<Plug>(vsnip-expand-or-jump)" : "\<C-l>"]],
    { buffer = bufnr, expr = true, replace_keycodes = true, remap = true }
  )
  -- vim.cmd([[imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']])
  -- vim.cmd([[smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']])

  require("cmp_nvim_lsp").update_capabilities(capabilities)
end

local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "vsnip" },
    { name = "vim-dadbod-completion" },
    { name = "spell", keyword_length = 5 },
    -- { name = "rg", keyword_length = 3 },
    -- { name = "buffer", keyword_length = 5 },
    { name = "emoji" },
    { name = "path" },
    { name = "gh_issues" },
  },
  formatting = {
    format = require("lspkind").cmp_format({
      with_text = true,
      menu = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        emoji = "[Emoji]",
        spell = "[Spell]",
        path = "[Path]",
        -- rg = "[Rg]",
      },
    }),
  },
})

M.setup = function(name, opts)
  if not has_run[name] then
    has_run[name] = true

    lspconfig[name].setup(vim.tbl_extend("force", {
      log_level = vim.lsp.protocol.MessageType.Log,
      message_level = vim.lsp.protocol.MessageType.Log,
      capabilities = capabilities,
      on_attach = M.on_attach,
    }, opts))
  end
end

if
  vim.fn.executable(
    vim.fn.expand("~/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server")
  ) > 0
then
  require("nlua.lsp.nvim").setup(require("lspconfig"), {
    on_attach = M.on_attach,
    globals = { "vim", "hs" },
    library = { [vim.fn.expand("~/.hammerspoon/Spoons/EmmyLua.spoon/annotations")] = true },
  })
end

vim.lsp.set_log_level(0)

M.default_config = function(name)
  return require("lspconfig.server_configurations." .. name).default_config
end

return M
