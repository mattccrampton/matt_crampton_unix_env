
"xnoremap <expr> p v:register=='"'?'pgvy':'p'

nnoremap <C-T>  <C-w><C-]><C-w>T

"set list
set tags=/tmp/vim_ctags
"set tags=~/.vim/my_ctags/gigwalk
set listchars=tab:>.
"set listchars=tab:>.,trail:.,extends:#,nbsp:.
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<


set scrolloff=1
"set scrolloff=10
"set scrolloff=999

set wildmode=list:longest,full
"set wildmode=list
set virtualedit=all
set tabpagemax=50


" don't have files trying to override this .vimrc:
set nomodeline

set background=dark

"Window Min Height
set wmh=0

"clear any existing autocommands:
autocmd!

syntax enable

"command-line (etc) history:
set history=50

"set mouse=a

" display the current mode and partially-typed commands in the status line:
set showmode
set showcmd
set notimeout


"status line
set laststatus=2 
"define 3 custom highlight groups
hi User1 ctermbg=black ctermfg=yellow   guibg=green guifg=red
hi User2 ctermbg=black ctermfg=red  guibg=red   guifg=blue
hi User3 ctermbg=black ctermfg=white guibg=blue  guifg=green

set statusline=
set statusline+=%1*  "switch to User1 highlight
set statusline+=%=      "left/right separator
set statusline+=%t       "tail of the filename
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%2*  "switch to User2 highlight
set statusline+=%y      "filetype
set statusline+=%3*  "switch to User3 highlight
set statusline+=%3.c,     "cursor column
set statusline+=%3.l/%L   "cursor line/total lines
set statusline+=%1*  "switch to User1 highlight
set statusline+=\ %P    "percent through file




set nowrap

set autoindent

set formatoptions-=t
" set textwidth=79

filetype on

" for CSS, also have things in braces indented:
autocmd FileType css set smartindent

" for both CSS and HTML, use genuine tab characters for indentation, to make
" files a few bytes smaller:
autocmd FileType html,css,htm,xsl,php,inc,js,txt,java, set noexpandtab tabstop=8 shiftwidth=8

" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
autocmd FileType make set noexpandtab shiftwidth=8

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase
set nohlsearch

" assume the /g flag on :s substitutions to replace all matches in a line:
set gdefault

" have % bounce between angled brackets, as well as t'other kinds:
set matchpairs+=<:>

" have Q reformat the current paragraph (or selected text if there is any):
nnoremap Q gqap
vnoremap Q gq

" have Y behave analogously to D and C rather than to dd and cc (which is
" already done by yy):
noremap Y y$

" set up syntax highlighting for my e-mail
au BufRead,BufNewFile .followup,.article,.letter,/tmp/pico*,nn.*,snd.*,/tmp/mutt* :set ft=mail 

"set backspace=indent,eol,start

set ruler

let loaded_matchparen = 1

"Turns off beep
autocmd VimEnter * set vb t_vb=

set wildmenu

autocmd BufEnter * let &titlestring = hostname() . "[vim(" . expand("%:t") . ")]"

"set lcs=tab:»-


"""""" Keyboard Mappings """""""
map <Enter> O<ESC><ESC><Down>
"map <Enter> I<CR><ESC>
noremap \\ :%s:::c<Left><Left><Left>

fixdel

noremap <Space> <PageDown>
noremap - <PageUp>

noremap [ 3<C-Y>
noremap ] 3<C-E>
noremap ' 10zl
noremap ; 10zh 

map j :tabp<CR><C-W><C-W>
map k :tabn<CR><C-W><C-W>

map <DEL> <Backspace>x
imap <DEL> <Backspace>

noremap { :set wrap<CR>
noremap } :set nowrap<CR>

map gf :tabe <cfile><CR>
"map gx :tabe ../xsl/<cfile>.xsl<CR>
"map # :s/^/\/\//<CR>

map l :set invlist<CR>


map M z.

"cmap w!! %!sudo tee > /dev/null %


"map s :setlocal spell spelllang=en_us<CR>:syntax clear<CR>




vmap <space> zf

"function GnarleyTest1(theString)
"	echo "This is gnarleyTest1"
"	echo a:theString
"endfunction

"function ToggleFold()
"	if foldlevel('.') == 0
"		" No fold exists at the current line,
"		" so create a fold based on braces
"		let x = line('.')    " the current line number
"		normal 0
"		call search("{")
"		normal %
"		let y = line('.')    " the current line number
"		" Create the fold from x to y
"		execute x . "," . y . " fold"
"	else
"		" Delete the fold on the current line
"		normal zd
"	endif
"endfunction
"
"nmap F :call ToggleFold()<CR>


"""""" Start custom function stuff """"""""""""""""
map ,pm :call GnarleyPHPManual()<CR>

set pastetoggle=<C-P> " Ctrl-P toggles paste mode
map ,o :tabe<CR>:Ex<CR>
nmap t <C-w><C-]><C-w>T
"nnoremap <silent> ,t :TlistToggle<CR>

map R :registers<CR>



"""""""""""""""""" vim tab stuff """""""""""""""""""""""""""""


:so ~/matt_crampton_unix_env/vim/plugin/supertab.vim
