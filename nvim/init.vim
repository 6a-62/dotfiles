lua require('plugins')

" Behaviour
set encoding=utf-8
set mouse=a
set clipboard=unnamed

set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent

set wildmode=longest:list,full
set wildmenu
set incsearch
set hlsearch
set ignorecase
set smartcase

" Apperance
set number
set showmatch
set splitbelow 
set scrolloff=3

colorscheme dracula
highlight normal ctermbg=none
highlight StatusLine ctermfg=0 ctermbg=lightblue  

" Keybinds
" clear hl on spacebar
noremap <silent> <Space> :silent noh<CR>:pclose<Bar>echo<CR>
" extra LSP stuff
noremap gt :tab split<CR>:lua vim.lsp.buf.definition()<CR>
COQnow [--shut-up]
" open file browser
noremap <leader>f <cmd>CHADopen<cr>
" open tag browser
noremap <leader>t <cmd>Tagbar<cr>
