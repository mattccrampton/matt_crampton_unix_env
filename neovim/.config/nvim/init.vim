
""" PLUGINS """"""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
call plug#end()

lua << CATPPUCCIN
require("catppuccin").setup {
  color_overrides = {
    mocha = { base = "#000000", mantle = "#000000", crust = "#000000" }
  }
}
CATPPUCCIN
colorscheme catppuccin-mocha

" Enable treesitter highlighting for these filetypes
lua << EOF
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'typescript', 'lua', 'python', 'json', 'html', 'css' },
  callback = function() vim.treesitter.start() end,
})
EOF

""" SETTINGS """"""""""""""""""""""""""""""""""""""""""""""""""
set nowrap
set scrolloff=1
set tabpagemax=50
set autoindent

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase
set nohlsearch

set expandtab
set shiftwidth=2

" USE THIS FOR TABS...
"set autoindent noexpandtab tabstop=4 shiftwidth=4
" USE THIS FOR SPACES...
set tabstop=2 shiftwidth=2 expandtab

set wildmode=list:longest,full
set virtualedit=all

set history=50
set showmode
set showcmd

" disable mouse
set mouse=

set formatoptions-=t
set matchpairs+=<:>
set ruler

" https://til.hashrocket.com/posts/t8osyzywau-treat-words-with-dash-as-a-word-in-vim
set iskeyword+=-

" https://superuser.com/questions/271023/can-i-disable-continuation-of-comments-to-the-next-line-in-vim
set formatoptions-=cro

" Disable matching bracket highlighting
" https://medium.com/usevim/vim-101-working-with-brackets-a0b4cc628e4f
" Or.. :NoMatchParen
let loaded_matchparen = 1


""" GLOBAL KEY BINDINGS """"""""""""""""""""""""""""""""""""""""""""""

""" Move Vertically
" 2025-12-30 too much shit is mapped to [ and ], so I need to just learn to use <C-Y> and <C-E>
" OLD
" note: use :verbose map [ to figure out what's remapping the key if this
" doens't work or is choppy
"noremap <PageUp> 1<C-Y>
"noremap <PageDown> 1<C-E>
"noremap [ 1<C-Y>
"noremap ] 1<C-E>
"map j 1<C-Y>
"map k 1<C-E>

""" Move Horizontally
noremap ' 10zl
noremap ; 10zh

""" Switch Tabs
map j :tabp<CR>
map k :tabn<CR>
"map <C-j> :tabp<CR>
"map <C-k> :tabn<CR>


""" Move tab placement
map <C-j> :tabm -1<CR>
map <C-k> :tabm +1<CR>
"map j :tabp<CR><C-W><C-W>
"map k :tabn<CR><C-W><C-W>

"" buffer movement
"map j :bp<CR>
"map k :bn<CR>

" fix del key behavior
map <DEL> <Backspace>x
imap <DEL> <Backspace>

" Wordwrap
noremap { :set wrap<CR>
noremap } :set nowrap<CR>

" open file in new tab
map ,o :tabe %:h<CR>
map ,v :vsp %:h<CR><C-w>L

" goto file in new tab
nnoremap gf <C-w>gf

noremap Y y$

map <Enter> O<ESC><ESC><Down>
"map <Enter> I<CR><ESC>
noremap \\ :%s:::cg<Left><Left><Left><Left>

"set pastetoggle=<C-P> " Ctrl-P toggles paste mode

map l :set invlist<CR>

""" Paging
noremap <Space> <PageDown>
noremap - <PageUp>
" noremap <Space> <C-U>
" noremap - <C-B>


""" FILETYPES """"""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab













