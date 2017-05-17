" 2-16-2-10: need to figure this out: https://github.com/davidhalter/jedi-vim/blob/master/doc/jedi-vim.txt
" https://github.com/tpope/vim-pathogen
" execute pathogen#infect()
filetype plugin indent on
"filetype plugin on

set backupdir=~/.vim/backup_files//
set directory=~/.vim/swap_files//
set undodir=~/.vim/undo_files//
set undodir=/tmp
set undofile

""" https://github.com/wincent/command-t/blob/master/doc/command-t.txt
let g:CommandTMaxHeight=0
let g:CommandTTraverseSCM='pwd'
let g:CommandTMinHeight=15
let g:CommandTAlwaysShowDotFiles=1
"let g:CommandTCursorColor='red'
let g:CommandTAcceptSelectionCommand='tabe'


""" https://github.com/scrooloose/nerdtree
"let g:NERDTreeDirArrowExpandable = '>'
"let g:NERDTreeDirArrowCollapsible = 'v'
"let NERDTreeMapOpenInTab='\r'
"let g:nerdtree_tabs_synchronize_view=1
"let NERDTreeShowHidden=1
"let g:NERDTreeWinSize=25


""" https://github.com/jistr/vim-nerdtree-tabs
"let g:nerdtree_tabs_open_on_console_startup=1
"let g:nerdtree_tabs_autofind=1
"let g:nerdtree_tabs_smart_startup_focus=2
"let g:nerdtree_tabs_focus_on_files=1


""" https://github.com/Xuyuanp/nerdtree-git-plugin
"let g:NERDTreeIndicatorMapCustom = {
"    \ "Modified"  : "*",
"    \ "Staged"    : "+",
"    \ "Untracked" : "@",
"    \ "Renamed"   : ">",
"    \ "Unmerged"  : "=",
"    \ "Deleted"   : "x",
"    \ "Dirty"     : "X",
"    \ "Clean"     : "C",
"    \ "Unknown"   : "?"
"    \ }


""" https://github.com/scrooloose/nerdcommenter
map # \ci<Down>
map ,# yyp#<UP><UP>

""" https://github.com/airblade/vim-gitgutter
let g:gitgutter_map_keys = 0
set updatetime=250
let g:gitgutter_sign_column_always=1

"https://github.com/fholgado/minibufexpl.vim/blob/master/doc/minibufexpl.txt
"let g:miniBufExplVSplit = 35
"let g:miniBufExplorerAutoStart = 1
"let g:miniBufExplMaxSize = 0
"let g:miniBufExplBRSplit = 0
"let g:miniBufExplBuffersNeeded = 0
"let g:miniBufExplStatusLineText = ""
"let g:miniBufExplShowBufNumbers = 0
"set fillchars+=vert:\ 
"let g:did_minibufexplorer_syntax_inits = 1
"let g:miniBufExplHideWhenDiff = 1
""let g:miniBufExplSortBy='mru' 
""let g:miniBufExplSortBy='name' 
"map ,b :MBEToggle<CR>
""https://github.com/techlivezheng/vim-plugin-minibufexpl/issues/12
"map j :MBEbp<CR><C-W><C-W>
"map k :MBEbn<CR><C-W><C-W>
"map j :bp<CR>
"map k :bn<CR>
"map j :tabp<CR><C-W><C-W>
"map k :tabn<CR><C-W><C-W>
"map j :tabp<CR>
"map k :tabn<CR>


"map ,o kkkkkkkkkkkkkkkkkk:e .<CR>
"map ,o :MBEOpen<CR>kkkkkkkkkk:e .<CR>
"map ,v kkkkkkkkkkkkkkkkkk:e ~/.vimrc<CR>:so $MYVIMRC<CR>:MBEToggle<CR>:MBEToggle<CR>

set backspace=2

imap <D-V> ^O"+p
let g:netrw_list_hide= '.*\.pyc$'

"xnoremap <expr> p v:register=='"'?'pgvy':'p'
"control T for tagbar
"nnoremap <C-T>  <C-w><C-]><C-w>T
"nmap <C-T> :TagbarToggle<CR>


"let g:netrw_liststyle= 3
"let g:netrw_browse_split=3

"colorscheme jelleybeans
"colorscheme blackboard
" colorscheme pychimp

"http://www.vim.org/scripts/script.php?script_id=42
let g:bufExplorerDefaultHelp=1
let g:bufExplorerShowNoName=1
let g:bufExplorerShowRelativePath=1
"let g:bufExplorerShowUnlisted=1
let g:bufExplorerSortBy='fullpath'
"map ,b \be
set hidden


"set list
"set tags=tags;/
"set tags=~/.vim/my_ctags/gigwalk
"set listchars=tab:>.*/
"set listchars=tab:>.,trail:.,extends:#,nbsp:.
"set listchars=tab:>-     " > is shown at the beginning, - throughout*/
"set listchars=eol:$,tab:>-,trail:~ " pre-2017-2-3
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:.

set scrolloff=1
"set scrolloff=10
"set scrolloff=999

set wildmode=list:longest,full
set wildignore+=*.o,*.pyc,*venv/*,*vendor_BACKUP/*,*vendor_custom/*,*vendor/*,*node_modules/*
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
"set notimeout
"set timeoutlen=100


"status line
"set laststatus=0 
set laststatus=2 
"define 3 custom highlight groups
hi User1 ctermbg=black ctermfg=DarkGray   guibg=green guifg=red
hi User2 ctermbg=black ctermfg=red  guibg=red   guifg=blue
hi User3 ctermbg=black ctermfg=white guibg=blue  guifg=green
"
set statusline=
set statusline+=%3*  "switch to User3 highlight
set statusline+=%-0.80F
set statusline+=%=      "left/right separator
"set statusline+=%t       "tail of the filename
"set statusline+=%m      "modified flag
"set statusline+=%r      "read only flag
"set statusline+=%2*  "switch to User2 highlight
"set statusline+=%y      "filetype
set statusline+=%1*  "switch to User1 highlight
set statusline+=[
"set statusline+=%-0.50{@0}
set statusline+=%-.40{GnarleyGetRegisterA()}
set statusline+=]

set statusline+=%3*  "switch to User3 highlight
set statusline+=%4.l   "cursor line/total lines
set statusline+=%2*  "switch to User2 highlight
set statusline+=/
set statusline+=%3*  "switch to User3 highlight
set statusline+=%L   "cursor line/total lines
set statusline+=%2*  "switch to User2 highlight
set statusline+=\ %P    "percent through file





set nowrap

set autoindent

set formatoptions-=t
" set textwidth=79

filetype on


"http://stackoverflow.com/questions/815548/how-do-i-tidy-up-an-html-files-indentation-in-vi
filetype indent on

" for CSS, also have things in braces indented:
autocmd FileType css set smartindent

""" TAB SETTINGS """

" for both CSS and HTML, use genuine tab characters for indentation, to make
" files a few bytes smaller:
"autocmd FileType html,css,htm,xsl,php,inc,js,txt,java, set noexpandtab tabstop=5 shiftwidth=5 smartindent

" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
"autocmd FileType make set noexpandtab shiftwidth=5

set expandtab
set shiftwidth=2
"set softtabstop=2
"set noexpandtab
"set tabstop=4

" USE THIS FOR TABS...
"set autoindent noexpandtab tabstop=4 shiftwidth=4

" USE THIS FOR SPACES...
set tabstop=2 shiftwidth=2 expandtab

"format ejs files
au BufNewFile,BufRead *.ejs set filetype=html

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

"autocmd BufEnter * let &titlestring = hostname() . "[vim(" . expand("%:t") . ")]"

"set lcs=tab:»-


"""""" Keyboard Mappings """""""
"yank to osx clipboard
map ,y "+Y
"paste from osx clipboard
"map ,p "+P
map ,p <ESC><ESC>:set paste<Enter>
"set pastetoggle=,p

map <Enter> O<ESC><ESC><Down>
"map <Enter> I<CR><ESC>
noremap \\ :%s:::c<Left><Left><Left>

fixdel

noremap <Space> <PageDown>
noremap - <PageUp>

""" Move Vertically
" 2016-2-10: I had to rename  /usr/local/Cellar/vim/7.4.891/share/vim/vim74/ftplugin.vim to ftplugin.vim.2016-2-10 to 
" get around that plugin using the [ and ] bindings.
" 2017-4-21 needed to nuke 4 lines from /usr/share/vim/vim74/ftplugin/python.vim to nuke the key bindings on mac
" plus I had to turn off the mac restrictions on editing /usr files first.
" note: use :verbose map [ to figure out what's remapping the key
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
"map ,pm :call GnarleyPHPManual()<CR>

set pastetoggle=<C-P> " Ctrl-P toggles paste mode

"trying nerdtree 2016-3-14
map ,o :tabe<CR>:tabm 9<CR>:Ex<CR>:tabm +1<CR>
"map ,o :NERDTreeToggle<CR>
"map ,o :tabe<CR>:tabm 9<CR>:NERDTreeFocusToggle<CR>

"nmap t <C-w><C-]><C-w>T
"nnoremap <silent> ,t :TlistToggle<CR>

map R :registers<CR>



"""""""""""""""""" vim tab stuff """""""""""""""""""""""""""""
":so ~/matt_crampton_unix_env/vim/plugin/supertab.vim

"""""""""""""""""" ctrl p stuff """""""""""""""""""""""""""""
"http://kien.github.io/ctrlp.vim/#installation
"control-o opens fuzzy finder
map <C-o> :tabe<CR>:CtrlP getcwd()<CR>


"hi StatusLine cterm=NONE ctermbg=darkgreen ctermfg=white 
"	\ gui=bold guibg=green guifg=black 
"hi StatusLineNC cterm=NONE ctermbg=lightgrey ctermfg=black 
"	\ gui=bold guibg=#060606 guifg=black 

"hi StatusLine cterm=NONE ctermbg=darkgreen ctermfg=white 
"	\ gui=bold guibg=green guifg=black 
"hi StatusLineNC cterm=NONE ctermbg=black ctermfg=black 
"	\ gui=bold guibg=#060606 guifg=black 


function GnarleyGetRegisterA()
	let l = substitute(@a, '\n', '', 'g')
	let l = substitute(l, '\t', '', 'g')
	let l = substitute(l, '\r', '', 'g')
	if strlen(l) < 40
		return l
	endif
	return strpart(l, 0, 39) . ">"
endfunction

function GnarleyGetUnnamedRegister()
	let l = substitute(@0, '\n', '', 'g')
	let l = substitute(l, '\t', '', 'g')
	let l = substitute(l, '\r', '', 'g')
	if strlen(l) < 40
		return l
	endif
	return strpart(l, 0, 39) . ">"
endfunction

