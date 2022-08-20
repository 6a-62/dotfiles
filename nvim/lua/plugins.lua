local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
 
function lsp_config()
  local nvim_lsp = require 'lspconfig'
  local coq = require "coq"
  local on_attach = function(_, bufnr)
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
    end
 
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
 
    -- Mappings.
    local opts = { noremap = true, silent = true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  end
 
  nvim_lsp.pylsp.setup {
      on_attach = on_attach,
      handlers = {
          ["textDocument/publishDiagnostics"] = vim.lsp.with(
              vim.lsp.diagnostic.on_publish_diagnostics, {
                  virtual_text = true
              }),
      }
  }
 
  nvim_lsp.clangd.setup(coq.lsp_ensure_capabilities({
      on_attach = on_attach,
          cmd = {
            "clangd", "--background-index", "--pch-storage=memory",
            "--clang-tidy", "--suggest-missing-includes"
    },
 
      handlers = {
          ["textDocument/publishDiagnostics"] = vim.lsp.with(
              vim.lsp.diagnostic.on_publish_diagnostics, {
                  virtual_text = true
              }),
      }
  }))
 
  vim.api.nvim_command([[
  autocmd CursorHold * lua vim.lsp.buf.hover()
  ]])
end
 
function treesitter_config()
    require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = true,
    },
    indent = {
        enable = false,
        disable = {},
    },
 
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    ensure_installed = {
        "c", "cpp", "python"
    },
  })
end

function lualina_config()
  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = ')', right = '('},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'filetype'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
  }

  require 'tabline'.setup {
      enable = true,
      options = {
        show_tabs_always = false,
        show_devicons = true, 
        show_filename_only = true, 
        show_tabs_only = false, 
      }
    }
end
 
function plugin_config()
  lsp_config()
  treesitter_config()
  --lualina_config()
end
 
return require('packer').startup(function(use)
  -- vim plugin manager
  use 'wbthomason/packer.nvim'
 
  -- Language support
  use 'neovim/nvim-lspconfig'
  --use 'nvim-lua/completion-nvim' no longer maintained
  use 'ms-jpq/coq_nvim'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'Pokinawa/vim-lisa'
 
  -- Quickly jump to files
  use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end}
  use 'junegunn/fzf.vim'
 
  -- Code nagivation/editing convenience
  use 'majutsushi/tagbar'              -- File overview for C/C++
  use 'vim-scripts/argtextobj.vim'     -- Argument manipulation (cia -> change inner argument)
  use 'godlygeek/tabular'              -- Create tables by :Tab /<symbol> to tabularize based on symbol
  --use 'scrooloose/nerdtree'            -- Support for nicer file browsing
  use 'ms-jpq/chadtree'            -- Support for nicer file browsing
  use 'MattesGroeger/vim-bookmarks'    -- mm - toggle bookmark on line
                                       -- mi - add/edit/remove annotation
                                       -- ma - show all bookmarks
  use 'vim-scripts/a.vim'              -- Jump between .cpp and .h with :A
  use 'vim-scripts/Rename'             -- Rename files with :Rename
  use 'bogado/file-line'               -- Open files to specific line number on the command line with 'nvim file.cpp:17'
 
  -- Git
  use 'tpope/vim-fugitive'             -- Git integration
  use 'airblade/vim-gitgutter'         -- Visual indicator of uncommitted changes

  -- Style
  use { 'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use 'kdheepak/tabline.nvim'
  use 'dracula/vim'
 
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
  plugin_config()
end)
