
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
set shiftwidth=4

" USE THIS FOR TABS...
"set autoindent noexpandtab tabstop=4 shiftwidth=4
" USE THIS FOR SPACES...
set tabstop=4 shiftwidth=4 expandtab

set wildmode=list:longest,full
set virtualedit=all

set history=50
set showmode
set showcmd

set formatoptions-=t
set matchpairs+=<:>
set ruler


""" GLOBAL KEY BINDINGS """"""""""""""""""""""""""""""""""""""""""""""

""" Move Vertically
" note: use :verbose map [ to figure out what's remapping the key if this
" doens't work or is choppy
noremap [ 1<C-Y>
noremap ] 1<C-E>
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

noremap Y y$

map <Enter> O<ESC><ESC><Down>
"map <Enter> I<CR><ESC>
noremap \\ "zyiw:%s:<C-R>z::c<Left><Left>

set pastetoggle=<C-P> " Ctrl-P toggles paste mode

map l :set invlist<CR>


""" PLUGINS """"""""""""""""""""""""""""""""""""""""""""""""""
""" https://github.com/junegunn/vim-plug
call plug#begin('~/.local/share/nvim/plugged')

""" https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" let g:airline_powerline_fonts = 1

""" https://github.com/scrooloose/nerdcommenter
Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDCommentEmptyLines = 0
map # \ci<Down>
map ,# yyp#<UP><UP>

""" https://github.com/pangloss/vim-javascript
Plug 'pangloss/vim-javascript'
let g:javascript_plugin_flow = 1

""" https://github.com/mxw/vim-jsx
Plug 'pangloss/vim-javascript'
let g:jsx_ext_required = 0

""" https://github.com/w0rp/ale
Plug 'w0rp/ale'
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
" highlight clear ALEErrorSign
" highlight clear ALEWarningSign
" let g:ale_set_highlights = 0
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_enter = 0
let g:ale_lint_delay = 500
" highlight ALEWarning ctermbg=DarkMagenta
highlight SignColumn ctermbg=Black

""" https://github.com/davidhalter/jedi-vim
Plug 'davidhalter/jedi-vim'
let g:jedi#use_tabs_not_buffers = 1

""" https://github.com/cakebaker/scss-syntax.vim
Plug 'cakebaker/scss-syntax.vim'

""" https://github.com/airblade/vim-gitgutter
Plug 'airblade/vim-gitgutter'
let g:gitgutter_map_keys = 0
set updatetime=250
" let g:gitgutter_sign_column_always=1
set signcolumn=yes

""" https://github.com/Shougo/denite.nvim
" Plug 'Shougo/denite.nvim'
" nnoremap ,g :<C-u>DeniteCursorWord grep:. -mode=normal -default-action=tabopen<CR>
" nnoremap ,g :<C-u>Denite grep:. -auto-preview -mode=normal <CR>
" nnoremap ,d :Denite -default-action=tabopen file/rec -mode=normal<CR>
" call denite#custom#option('_', 'root_markers', 'store.js')
" call denite#custom#source('grep', 'converters', ['converter/abbr_word'])

""" https://github.com/junegunn/fzf.vim
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
let g:fzf_action = { 'enter': 'tabedit' }
let g:fzf_layout = { 'window': '-tabnew' }
" vnoremap ,g "zy:Rg <C-R>z<CR>
vnoremap ,f "zy:Locate <C-R>z<CR>
noremap ,g "zyiw:Rg <C-R>z<CR>
noremap ,f :Files<CR>
" noremap ,f "zyiw:FZF -q <C-R>z<CR>
noremap gf "zyiw:FZF -q <C-R>z<CR>

call plug#end()
" run when updating...
" :PlugInstall
" :UpdateRemotePlugins













