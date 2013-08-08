
"xnoremap <expr> p v:register=='"'?'pgvy':'p'

"set list
set tags=tags;/
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
noremap \g\ :!find ~/dev/yahoo/properties/ \| grep -v CVS \| grep -v package \| xargs grep ""<Left>


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
map # :s/^/\/\//<CR>

map l :set invlist<CR>


map M z.

cmap w!! %!sudo tee > /dev/null %                                                                                                                        


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

"map F :call GnarleyBuzzGrep(Prompt("0","1"))<CR>



"""""""""""" depricated mappings """"""""""""""""""

map GT :call DepricatedMapping()<CR>
map GF :call DepricatedMapping()<CR>
map GP :call DepricatedMapping()<CR>
map F :call DepricatedMapping()<CR>

function DepricatedMapping()
	echo "Dummy! That's depricated"
endfunction


"""""" Start custom function stuff """"""""""""""""
map ,pm :call GnarleyPHPManual()<CR>

set pastetoggle=<C-P> " Ctrl-P toggles paste mode
map ,o :tabe<CR>:Ex<CR>
nmap t <C-w><C-]><C-w>T
"nnoremap <silent> ,t :TlistToggle<CR>
map ,gt :call GnarleyBuzzTree()<CR>
map ,gg :call GnarleyBuzzGrep()<CR>
map ,df :call GnarleyBuzzDefinedGrep()<CR>
map ,gp :call GnarleyBuzzPromptGrep()<CR>
map ,gf :call GnarleyBuzzFind()<CR>
map ,x <Esc>:1,$!xmllint --format -<CR>
map ,n <Esc>:NERDTree<CR>

map ,f <Esc><Esc><Esc>?function<CR><Down>V<Up>$<Left>%<Up>zf/function<CR><Down>



map R :registers<CR>

" resize horzontal split window
"nmap <C-Left> <C-W>-<C-W>-
"nmap <C-Right> <C-W>+<C-W>+
" resize vertical split window
"nmap <C-Up> <C-W>><C-W>>
"nmap <C-Down> <C-W><<C-W><
"nmap <C-.> <C-W>><C-W>>
"nmap <C-,> <C-W><<C-W><







function GnarleyPHPManual()
	normal `<
	execute "let startcol = col(\".\")"
	normal `>
	execute "let endcol = col(\".\")"
	if startcol <= endcol
		let firstcol = startcol
		let lastcol = endcol
	else
		let firstcol = endcol
		let lastcol = startcol
	endif

	let searchterm = strpart(getline("."),firstcol-1,(lastcol-firstcol)+1)
	"execute ":tabe"
	"echo "links -dump http://php.corp.yahoo.com/" . searchterm
	"execute ":r ! links -dump http://php.corp.yahoo.com/" . searchterm
	"execute ":!links http://php.corp.yahoo.com/manual-lookup.php?pattern=" . searchterm . ""
	execute ":! clear && ~/gnarley/gnarley/code/python/phpmanual/./getPHPManual.py " . searchterm . ""
endfunction

function GnarleyBuzzTree()
	normal `<
	execute "let startcol = col(\".\")"
	normal `>
	execute "let endcol = col(\".\")"
	if startcol <= endcol
		let firstcol = startcol
		let lastcol = endcol
	else
		let firstcol = endcol
		let lastcol = startcol
	endif

	let searchterm = strpart(getline("."),firstcol-1,(lastcol-firstcol)+1)
	"echo "FINDING: " searchterm " | " firstcol " | " lastcol
	execute ":tabe"
	"execute ":r ! find ~/dev/yahoo/properties -name"searchterm"-print"
	execute ":r ! ~/bin/gnarleyShowPHPIncludeTree " searchterm
endfunction

function GnarleyBuzzFind()
	normal `<
	execute "let startcol = col(\".\")"
	normal `>
	execute "let endcol = col(\".\")"
	if startcol <= endcol
		let firstcol = startcol
		let lastcol = endcol
	else
		let firstcol = endcol
		let lastcol = startcol
	endif

	let searchterm = strpart(getline("."),firstcol-1,(lastcol-firstcol)+1)
	"echo "FINDING: " searchterm " | " firstcol " | " lastcol
	execute ":tabe"
	"execute ":r ! find ~/dev/yahoo/properties -name"searchterm"-print"
	execute ":r ! ~/bin/gnarleyVimFind '" searchterm "'"
	execute "map <Enter> :call GnarleyGotoBuzzFile()<CR>"
	execute "map ,GF :call GnarleyCloseBuzzGrep()<CR>"
	execute "map F :call GnarleyCloseBuzzGrep()<CR>"
endfunction

function GnarleyBuzzGrep()

	normal `<
	execute "let startcol = col(\".\")"
	normal `>
	execute "let endcol = col(\".\")"
	if startcol <= endcol
		let firstcol = startcol
		let lastcol = endcol
	else
		let firstcol = endcol
		let lastcol = startcol
	endif

	let searchterm = strpart(getline("."),firstcol-1,(lastcol-firstcol)+1)
	"call SortR(a:firstline, a:lastline, firstcol, lastcol, a:wnum, a:order, a:cmp)
        call DoGnarleyBuzzGrep(searchterm)
endfunction

function GnarleyBuzzDefinedGrep()

	normal `<
	execute "let startcol = col(\".\")"
	normal `>
	execute "let endcol = col(\".\")"
	if startcol <= endcol
		let firstcol = startcol
		let lastcol = endcol
	else
		let firstcol = endcol
		let lastcol = startcol
	endif

	let searchterm = strpart(getline("."),firstcol-1,(lastcol-firstcol)+1)
	"call SortR(a:firstline, a:lastline, firstcol, lastcol, a:wnum, a:order, a:cmp)
	echo "Grepping Buzz for: " searchterm
	execute ":tabe"
	execute ":r ! ~/bin/gnarleyVimGrep '" searchterm "' 2>/dev/null | grep -v 'No such' | grep -i function"
	execute "map <Enter> :call GnarleyGotoBuzzFile()<CR>"
	execute "map F :call GnarleyCloseBuzzGrep()<CR>"
endfunction

function GnarleyBuzzPromptGrep()
	let searchterm = input("Grep Buzz:  ")
        call DoGnarleyBuzzGrep(searchterm)
endfunction

function DoGnarleyBuzzGrep(searchterm)
	echo "Grepping Buzz for: " a:searchterm
	execute ":tabe"
	execute ":r ! ~/bin/gnarleyVimGrep '" a:searchterm "' 2>/dev/null | grep -v 'No such'"
	execute "map <Enter> :call GnarleyGotoBuzzFile()<CR>"
	execute "map F :call GnarleyCloseBuzzGrep()<CR>"
endfunction


function! GnarleyCloseBuzzGrep()
	execute ":q!"
	execute "map ,GF :call GnarleyBuzzGrep()<CR>"
	execute "map ,F :call GnarleyBuzzFind()<CR>"
	execute "map <Enter> O<ESC><Down>"
endfunction

function! GnarleyGotoBuzzFile()
	normal gf
	execute ":tabp"
	call GnarleyCloseBuzzGrep()
endfunction

"prompt user for settings
function Prompt(question)
  let default = a:0 ? a:1 : ""
  if a:str == "0"
    let str = "Sort by which word [(0)whole line (<0)count from right]? "
  elseif a:str == "1"
    let str = "Order [(f)orward (r)everse]? "
  endif

  execute "let ret = input(\"".str."\", \"".default."\")"

  return ret
endfunction


"""""""""""""""""" vim tab stuff """""""""""""""""""""""""""""
