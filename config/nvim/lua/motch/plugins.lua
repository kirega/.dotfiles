local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.cmd [[packadd packer.nvim]]

local startup = require("packer").startup

startup(
  function(use, use_rocks)
    use {"wbthomason/packer.nvim", opt = true}
    use "tjdevries/nlua.nvim"
    use "norcalli/nvim.lua"
    use "tpope/vim-repeat"
    use "bakpakin/fennel.vim"
    use "sainnhe/vim-color-forest-night"
    use "christoomey/vim-tmux-runner"
    use {"rrethy/vim-hexokinase", run = "make hexokinase"}
    use "alvan/vim-closetag"
    use "junegunn/goyo.vim"
    use "AndrewRadev/splitjoin.vim"
    use "tpope/vim-vinegar"
    use "tpope/vim-commentary"
    use "tpope/vim-dispatch"
    use "vim-ruby/vim-ruby"
    use "tpope/vim-rsi"
    use "elixir-editors/vim-elixir"
    -- use "tpope/vim-endwise"
    use "tpope/vim-fugitive"
    use "junegunn/gv.vim"
    use "airblade/vim-gitgutter"
    use "tpope/vim-rails"
    use "tpope/vim-sensible"
    use "vim-test/vim-test"
    use "christoomey/vim-tmux-navigator"
    use "tpope/vim-liquid"
    use "pangloss/vim-javascript"
    use "isRuslan/vim-es6"
    -- use "mxw/vim-jsx"
    -- use "jiangmiao/auto-pairs"
    use "tpope/vim-surround"
    use "tpope/vim-eunuch"
    use "tpope/vim-projectionist"
    use "avakhov/vim-yaml"
    use "chr4/nginx.vim"
    use "mattn/emmet-vim"
    use "tpope/vim-markdown"
    use "matze/vim-move"
    -- use "Yggdroot/indentLine"
    use {"lukas-reineke/indent-blankline.nvim"}
    use {
      "junegunn/fzf",
      run = function()
        vim.fn["fzf#install"]()
      end
    }
    use "junegunn/fzf.vim"
    use "farmergreg/vim-lastplace"
    use {"mg979/vim-visual-multi", branch = "master"}
    use "ekalinin/Dockerfile.vim"
    use "kana/vim-textobj-user"
    use "amiralies/vim-textobj-elixir"
    use "stsewd/fzf-checkout.vim"
    use "reedes/vim-wordy"

    use "neovim/nvim-lspconfig"
    use "hrsh7th/nvim-compe"
    use "hrsh7th/vim-vsnip"
    use "hrsh7th/vim-vsnip-integ"

    use "kabouzeid/nvim-lspinstall"

    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use "nvim-lua/telescope.nvim"
    use "APZelos/blamer.nvim"
    use "hashivim/vim-terraform"
    use "pwntester/octo.nvim"
    -- use {
    --   "ojroques/nvim-lspfuzzy",
    --   requires = {
    --     {"junegunn/fzf"},
    --     {"junegunn/fzf.vim"} -- to enable preview (optional)
    --   }
    -- }
    -- use {
      -- "glacambre/firenvim",
      -- run = function()
       --  vim.fn["firenvim#install"](0)
     --  end
   --  }

    -- use "powerman/vim-plugin-AnsiEsc"
    use {
      "nvim-treesitter/nvim-treesitter",
      run = function()
        vim.cmd [[TSUpdate]]
      end
    }

    use "voldikss/vim-floaterm"
    use "kassio/neoterm"

    use {
      "npxbr/glow.nvim",
      run = function()
        vim.cmd [[GlowInstall]]
      end
    }

    use "glepnir/lspsaga.nvim"
    use "rktjmp/lush.nvim"

    use "mjlbach/neovim-ui"

    use "~/Development/thicc-forest"

    use {"ojroques/nvim-hardline"}

    use {"tjdevries/astronauta.nvim"}
    use {
      "megalithic/zk.nvim",
      requires = {{"vijaymarupudi/nvim-fzf"}}
    }

    -- use {"Olical/conjure"}
    use {"wlangstroth/vim-racket"}
    use {
      "jpalardy/vim-slime",
      run = function()
        vim.cmd [[let g:slime_target = "neovim"]]
      end
    }

    use_rocks {"underscore"}
  end
)

require("packer.luarocks").setup_paths()

_ = require("underscore")
