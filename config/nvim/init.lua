_G.motch = {}

require("motch.plugins")

_ = require("underscore")

local augroup = require("motch.utils").augroup
local opt = vim.opt

function RemoveNetrwMap()
  if vim.fn.hasmapto("<Plug>NetrwRefresh") > 0 then
    vim.cmd([[unmap <buffer> <C-l>]])
  end
end

vim.api.nvim_exec(
  [[
function! FzfWrapHelper(opts)
  call fzf#run(fzf#wrap(a:opts))
endfunction
]],
  false
)

FZF = vim.fn["FzfWrapHelper"]

vim.env.WALLABY_DRIVER = "chrome"

NVIM = require("nvim")
opt.colorcolumn = "99999"
opt.guifont = "JetBrains Mono"
opt.foldmethod = "syntax"
opt.foldlevelstart = 99
opt.smartindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.number = true
opt.termguicolors = true
opt.backupdir = vim.fn.expand("~/.tmp/backup")
opt.directory = vim.fn.expand("~/.tmp/swp")
opt.splitbelow = true
opt.splitright = true
opt.lazyredraw = true
opt.showmode = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.undofile = true
opt.undodir = vim.fn.expand("~/.tmp")
opt.mouse = "a"
opt.errorbells = false
opt.visualbell = true
-- opt.t_vb = ""
opt.cursorline = true
opt.inccommand = "nosplit"
opt.background = "dark"
opt.autoread = true

opt.title = true

vim.g.forest_night_enable_italic = 1
vim.g.forest_night_diagnostic_text_highlight = 1

-- vim.cmd([[color thicc_forest]])

vim.g.indentLine_fileTypeExclude = { "json" }
vim.g.indentLine_char = "│"

vim.cmd([[command! Q q]])
vim.cmd([[command! Qall qall]])
vim.cmd([[command! QA qall]])
vim.cmd([[command! E e]])
vim.cmd([[command! W w]])
vim.cmd([[command! Wq wq]])

vim.keymap.set("n", "Y", "y$", { remap = false })
vim.keymap.set("n", "cn", ":cnext<cr>", { remap = false })
vim.keymap.set("n", "<leader><space>", ":set hls!<cr>", { remap = false })
vim.keymap.set("n", "<leader>ev", ":vsplit ~/.vimrc<cr>", { remap = false })
vim.keymap.set("n", "<leader>sv", [[:luafile $MYVIMRC<cr>]], { remap = false })
vim.keymap.set("n", "<c-p>", ":Files<cr>", { remap = false })
vim.keymap.set("n", "<space>vp", ":Files ~/.local/share/nvim/site/pack/packer/start<cr>", { remap = false })
vim.keymap.set("n", "<space>df", ":lua motch.projects(, {remap = false})<cr>")
vim.keymap.set("n", "gl", ":BLines<cr>", { remap = false })
vim.keymap.set("n", "<leader>a", ":LocalProjectSearch<cr>", { remap = false })
vim.keymap.set("n", "<space>a", ":GlobalProjectSearch<cr>", { remap = false })
vim.keymap.set("n", "<leader>gr", ":grep<cr>", { remap = false })
vim.keymap.set("n", "<leader>c", ":botright copen 20<cr>", { remap = false })
vim.keymap.set("n", "<leader>gd", ":silent !tmux popup -K -w '90\\%' -h '90\\%' -R 'git diff'<cr>", { remap = false })
vim.keymap.set("n", "<leader>gs", ":silent !tmux popup -K -w '90\\%' -h '90\\%' -R 'git status'<cr>", { remap = false })

vim.cmd([[tnoremap <esc> <C-\><C-n>]])

vim.g.dispatch_handlers = { "job" }

-- ctags
vim.keymap.set("n", "<leader>ct", ":!ctags -R .<cr>", { remap = false })
-- vim.keymap.set("n", "<leader>t", ":Tags<cr>")
-- vim.keymap.set("n", "<leader>r", ":BTags")

opt.completeopt = { "menu", "menuone", "noselect" }

vim.g.blamer_enabled = 1
vim.g.blamer_relative_time = 1

vim.g.zig_fmt_autosave = 0

require("motch.treesitter")

opt.grepprg = "ag --vimgrep -Q $*"
opt.grepformat = "%f:%l:%c:%m"

vim.g.jsx_ext_required = 0

vim.keymap.set("n", "<leader>gy", ":Goyo<cr>", { remap = false })
vim.g.goyo_width = 120
vim.g.goyo_height = 100

vim.g.markdown_syntax_conceal = 0

vim.g.Hexokinase_optInPatterns = { "full_hex", "triple_hex", "rgb", "rgba", "hsl", "hsla" }

-- vim.diagnostic.config({ virtual_text = true, virtual_lines = false })

local LSP = require("motch.lsp")

LSP.setup("elixirls", {
  settings = {
    elixirLS = {
      dialyzerEnabled = false,
      fetchDeps = false,
      enableTestLenses = true,
    },
  },
  cmd = { "elixir-ls" },
})
LSP.setup("efm", {
  filetypes = {
    "elixir",
    "javascript",
    "typescript",
    "lua",
    "bash",
    "zsh",
    "sh",
    "sql",
  },
})
LSP.setup("rust_analyzer", {})
-- LSP.setup("solargraph", {})
LSP.setup("omnisharp", {})
LSP.setup("tsserver", {})
LSP.setup("vimls", {})

local zk = require("zk")

zk.setup({
  filetypes = { "markdown", "liquid" },
  on_attach = function(client, bufnr)
    local opts = { remap = false, silent = true }

    LSP.on_attach(client, bufnr)
    vim.keymap.set("n", "<C-p>", [[:Notes<cr>]], opts)
    vim.keymap.set("n", "<space>zt", [[:Tags<cr>]], opts)
    vim.keymap.set("n", "<space>zl", [[:Links<cr>]], opts)
    vim.keymap.set("n", "<space>zb", [[:Backlinks<cr>]], opts)
    vim.keymap.set("n", "<space>zd", ":ZkDaily<cr>", opts)
    vim.keymap.set("v", "<leader>zn", ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts)

    if vim.fn.expand("%:h") == "dnd" then
      vim.keymap.set("n", "<A-j>", function()
        require("motch.dnd").move_to("previous")
      end, opts)
      vim.keymap.set("n", "<A-k>", function()
        require("motch.dnd").move_to("next")
      end, opts)
    end
  end,
})

LSP.setup("zls", {})
LSP.setup("gopls", {})

LSP.setup(
  "tailwindcss",
  vim.tbl_extend("force", {
    settings = {
      tailwindCSS = {
        experimental = {
          classRegex = {
            [[class: "([^"]*)]],
          },
        },
      },
    },
    filetypes = { "elixir", "eelixir", "html", "liquid" },
  }, LSP.default_config("tailwindcss"))
)

augroup("random", function(autocmd)
  autocmd([[BufWritePost plugins.lua PackerCompile]])
  -- autocmd [[User FloatermOpen execute "normal G" | wincmd p]]
  autocmd([[VimResized * :wincmd =]])
  autocmd([[GUIEnter * set visualbell t_vb=]])
  autocmd([[FileType netrw :lua RemoveNetrwMap()]])
  autocmd([[FileType fzf :tnoremap <buffer> <esc> <C-c>]])
  autocmd([[BufRead,BufNewFile *.zsh-theme set filetype=zsh]])
  autocmd([[BufRead,BufNewFile aliases.local set filetype=zsh]])
  autocmd([[BufRead,BufNewFile *.lexs set filetype=elixir]])
  autocmd([[BufRead,BufNewFile *.exs set filetype=elixir]])
  autocmd([[BufRead,BufNewFile *.ex set filetype=elixir]])
  autocmd([[FileType elixir setlocal commentstring=#\ %s]])
end)

augroup("clojure", function(autocmd)
  autocmd([[BufWritePost *.clj :silent Require]])
end)

augroup("markdown", function(autocmd)
  autocmd([[BufRead,BufNewFile *.md setlocal spell]])
  autocmd([[BufRead,BufNewFile *.md setlocal linebreak]])
  -- autocmd([[BufRead,BufNewFile,WinEnter,VimEnter,TabNew,TabEnter *.md lua motch.zkify()]])
end)
-- augroup("tabs", function(autocmd)
--   autocmd([[TabNew * lua MARK_TAB()]])
-- end)

vim.cmd([[let g:test#javascript#jest#file_pattern = '\v(.*|(spec|test))\.(js|jsx|coffee|ts|tsx)$']])
