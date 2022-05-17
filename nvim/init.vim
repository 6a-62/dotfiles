set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
"set cc=80                  " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
"set cursorline              " highlight current cursorline

" PLUGINS
call plug#begin()
 " Plugin Section
 Plug 'dracula/vim'
 Plug 'nvim-lua/plenary.nvim'
 Plug 'nvim-telescope/telescope.nvim'
 Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
 Plug 'phaazon/hop.nvim'
 Plug 'lukas-reineke/indent-blankline.nvim'
 "Plug 'ryanoasis/vim-devicons'
 "Plug 'SirVer/ultisnips'
 "Plug 'honza/vim-snippets'
 "Plug 'scrooloose/nerdtree'
 Plug 'preservim/nerdcommenter'
 "Plug 'mhinz/vim-startify'
 "Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" COLOR SCHEME
colorscheme dracula
"set termguicolors
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight StatusLine ctermbg=darkblue ctermfg=black
highlight ColorColumn ctermbg=0
highlight Visual cterm=reverse
highlight Visual ctermbg=none
highlight IndentBlanklineChar ctermfg=black

" KEY MAPPINGS
" Find files using Telescope command-line sugar.
" theme: dropdown, cursor, ivy
nnoremap <leader>ff <cmd>Telescope find_files theme=dropdown<cr>
nnoremap <leader>fg <cmd>Telescope live_grep theme=dropdown<cr>
nnoremap <leader>fb <cmd>Telescope buffers theme=dropdown<cr>
nnoremap <leader>fm <cmd>Telescope theme=dropdown<cr>
