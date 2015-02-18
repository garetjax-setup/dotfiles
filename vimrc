" #################################################################
" VIM Configuration file
" #################################################################

"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup

" Ctrl-P plugin configuration
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<silent> <leader>t'
let g:ctrlp_working_path_mode = ''
let g:ctrlp_user_command = ['.git', 'git ls-files %s --cached --exclude-standard --others']
nmap <silent> <leader>r :CtrlPMRU<CR>

" Disable vi-compatibility mode (should be set to off automatically
" when loadin a .vimrc file, but we set it here to be explicit).
set nocompatible

" Supertab configuration
let g:SuperTabMappingTabLiteral = '<M-tab>'

let xml_no_html = 0

com! FormatJSON %!python -m json.tool

" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory.
call pathogen#infect()

" Change the mapleader from '\' to '.'. This allows to digit
" .<command> and having a custom command executed (even without
" having to press tne RETRUN key).
let mapleader=','
let maplocalleader='§'

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :vsplit $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
nmap <silent> <leader>f :retab!<CR>
"nmap <silent> <leader>r :CommandTBuffer<CR>

" Hide the current buffer instead of closing it. This means that
" you can have unwritten changes to a file and open a new file
" using :e, without being forced to write or undo your changes
" first. Also, undo buffers and marks are preserved while the
" buffer is open.
set hidden

" Switch splits simply by overing them with the mouse pointer
set mousefocus

noremap <S-space> <C-b>
noremap <space> <C-f>

nnoremap <space> za
vnoremap <space> zf

" Allow navigation of wrapped lines using arrows
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk
vmap <silent> <Down> gj
vmap <silent> <Up> gk
vmap <silent> <Left> h
vmap <silent> <Right> l

" Quickly enter presentation mode
command! Pres call Presentation()

" Presentation mode
fu! Presentation()
	colorscheme blackboard
	let &colorcolumn=0
	set cursorcolumn!
	hi Normal guibg=black
	set guifont=Monaco:h24
endfunction

"autocmd VimEnter * xunmap s

set nowrap			  " Don't wrap lines
set tabstop=4		  " Set a tab to 4 spaces
set smarttab
set shiftwidth=4
set shiftround
set autoindent
set copyindent
set noexpandtab
set backspace=indent,eol,start
					  " Allow backspacing over everything in insert mode

"set selection=exclusive " Ignore the character under the cursor when operating on selections

set showmatch
set matchtime=1

set ignorecase
set smartcase
set hlsearch
set incsearch

set splitright
set splitbelow

set number
set numberwidth=5

" Printing options
set printfont=Menlo:h9
set printoptions=number:y,syntax:a,left:10mm,top:15mm,bottom:15mm,right:10mm


" Enable syntax highlighting
syntax enable
set background=dark
colorscheme solarized

" Set history lines
set history=999
set undolevels=1000

" Ignore the following file types when cycling through tab
" autocompletion
set wildignore=*.swp,*.bak,*.pyc,*.class,.git/*,build/*,dist/*,*.egg-info/*,collected-static/*

" Enable filetype plugin
filetype on
filetype plugin on
filetype indent on

" Automatically reload file when a file is changed
set autoread

" Disable backup and swap files
set nobackup
set noswapfile
set nowritebackup

" Display special chars and whitespace
set list
set listchars=tab:‣\ ,trail:◇,extends:¶,nbsp:◆,eol:¬

" Enable mouse integration
set mouse=a

" Highlight current line and column
set cursorline
if (has("gui_running"))
	set cursorcolumn
endif

" Set chars which are part of words
set iskeyword+=_

" Don't make noise
set noerrorbells

" Enable folding
set foldenable
set foldmarker={,}
set foldmethod=marker
set foldlevel=100

" Reap the : command leader to ; for speed
nnoremap ; :

" Allow to save with sudo privileges using w!!
cmap w!! w !sudo tee % >/dev/null

" Toggle short key
set pastetoggle=<F2>

set ruler

set shell=zsh

" Autosave all buffers when buffer changes
set autowriteall


if has("gui_running")
	set guioptions-=T  " Remove toolbar
	set guioptions-=r  " Remove right scrollbar
	set guioptions-=L  " Remove left scrollbar
	set guioptions-=e  " Remove tab bar

	if has("gui_macvim")
		set guifont=Monaco:h12
		set guioptions-=R
		set guioptions-=l

		" Automatically split windows when opening
		autocmd GUIEnter * set fu
		"| bel vnew | bel vnew
		autocmd VimResized * wincmd =

		" Enable OSX-style shift+movement text selection
		" let macvim_hig_shift_movement = 1

		" Autosave files when losing focus
		autocmd BufLeave,FocusLost * nested silent! wall

		" Switch splits using Command-Alt-Up/Down/Right/Left
		map <A-D-Right> <C-W><Right>
		imap <A-D-Right> <C-W><Right>
		map <A-D-Left> <C-W><Left>
		imap <A-D-Left> <C-W><Left>
		map <A-D-Up> <C-W><Up>
		imap <A-D-Up> <C-W><Up>
		map <A-D-Down> <C-W><Down>
		imap <A-D-Down> <C-W><Down>

		" Create splits with Command + D (same as in iTerm 2)
		map <D-d> :vnew<CR>
		imap <D-d> <C-O>:vnew<CR>
		map <D-D> :new<CR>
		imap <D-D> <C-O>:new<CR>
	elseif has("gui_gtk2")
		set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 9
		set guioptions-=m  " Remove menu bar
		set columns=190 lines=50

		" Autosave files when losing focus
		autocmd FocusLost * nested silent! wall

		" Switch splits using Command-Alt-Up/Down/Right/Left
		map <A-T-Right> <C-W><Right>
		imap <A-T-Right> <C-W><Right>
		map <A-T-Left> <C-W><Left>
		imap <A-T-Left> <C-W><Left>
		map <A-T-Up> <C-W><Up>
		imap <A-T-Up> <C-W><Up>
		map <A-T-Down> <C-W><Down>
		imap <A-T-Down> <C-W><Down>

		" Create splits with Command + D (same as in iTerm 2)
		map <A-d> :vnew<CR>
		imap <A-d> <C-O>:vnew<CR>
		map <A-D> :new<CR>
		imap <A-D> <C-O>:new<CR>
	endif
endif

" Autosave upon lost focus in iTerm
"if &term =~ "xterm.*"
"	let &t_ti = &t_ti . "\e[?1004h"
"	let &t_te = "\e[?1004l" . &t_te
"	map <ESC>[O :wall<CR>
"endif

" Create parent directory on save if does not exist
augroup BWCCreateDir
	au!
	autocmd BufWritePre,BufNewFile * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p ".shellescape(expand('%:h'), 1) | redraw! | endif
augroup END

" Set line height
set linespace=2

let &colorcolumn=join(range(80,335),",")

" Highlight chars over 80 columns
"hi! OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%80v.\+/

"hi ColorColumn guibg=#052f3b ctermbg=0
hi SignColumn guibg=#052f3b

" -------------------------------------------
" Syntastic configuration option
" -------------------------------------------
let g:syntastic_check_on_open = 1

command! Py2 call Python2Support()
command! Py3 call Python3Support()

fu! Python2Support()
	let g:syntastic_python_python_exec = $HOME . '/.vimenvs/py2/bin/python'
	let g:syntastic_python_pyflakes_exec = $HOME . '/.vimenvs/py2/bin/pyflakes'
	let g:syntastic_python_flake8_exec = $HOME . '/.vimenvs/py2/bin/flake8'
	let g:syntastic_python_pylint_exec = $HOME . '/.vimenvs/py2/bin/pylint'
	let g:syntastic_python_py3kwarn_exec = $HOME . '/.vimenvs/py2/bin/py3kwarn'
	let g:syntastic_python_checkers = ['flake8', 'py3kwarn'] ", 'pylint']
	execute 'SyntasticCheck'
endfunction

fu! Python3Support()
	let g:syntastic_python_python_exec = $HOME . '/.vimenvs/py3/bin/python'
	let g:syntastic_python_pyflakes_exec = $HOME . '/.vimenvs/py3/bin/pyflakes'
	let g:syntastic_python_flake8_exec = $HOME . '/.vimenvs/py3/bin/flake8'
	let g:syntastic_python_pylint_exec = $HOME . '/.vimenvs/py3/bin/pylint'
	let g:syntastic_python_checkers = ['flake8'] ", 'pylint']
	execute 'SyntasticCheck'
endfunction

let g:syntastic_python_python_exec = $HOME . '/.vimenvs/py2/bin/python'
let g:syntastic_python_pyflakes_exec = $HOME . '/.vimenvs/py2/bin/pyflakes'
let g:syntastic_python_flake8_exec = $HOME . '/.vimenvs/py2/bin/flake8'
let g:syntastic_python_pylint_exec = $HOME . '/.vimenvs/py2/bin/pylint'
let g:syntastic_python_py3kwarn_exec = $HOME . '/.vimenvs/py2/bin/py3kwarn'
let g:syntastic_python_checkers = ['flake8', 'py3kwarn'] ", 'pylint']

" -------------------------------------------
" Django HTML templates surrounding blocks
" -------------------------------------------

let g:surround_{char2nr("b")} = "{% block\1 \r..*\r &\1%}\r{% endblock %}"
let g:surround_{char2nr("i")} = "{% if\1 \r..*\r &\1%}\r{% endif %}"
let g:surround_{char2nr("w")} = "{% with\1 \r..*\r &\1%}\r{% endwith %}"
let g:surround_{char2nr("c")} = "{% comment\1 \r..*\r &\1%}\r{% endcomment %}"
let g:surround_{char2nr("f")} = "{% for\1 \r..*\r &\1%}\r{% endfor %}"
let g:surround_{char2nr("v")} = "{{ \1 \r..*\r &\1\r }}"


" -------------------------------------------
" Python specific configuration
" -------------------------------------------

" Expand tabs when working on python files
autocmd filetype python setlocal expandtab
autocmd filetype pyhton setlocal shiftwidth=4
autocmd filetype pyhton setlocal tabstop=4
autocmd filetype python setlocal foldmethod=indent

" Automatically strip whitespace on saving and switching buffer
"autocmd FocusLost,BufLeave,BufWritePre *.py,*.c,*.cpp,*.h :exe "normal! ma" | :%s/\s\+$//e | :exe "normal `a"
autocmd FocusLost *.py nested SyntasticCheck
autocmd FocusLost,BufLeave,BufWrite *.py nested let b:spacestrip_view=winsaveview()|%s/\s\+$//e|%s/\_.\_^\n*\%$//e|call winrestview(b:spacestrip_view)

" Load the python autocompletion dictionary
let g:pydiction_location = '~/.vim/support/pydiction/complete-dict'

"autocmd filetype python setlocal ft=python.django " For SnipMate


" -------------------------------------------
" Markdown files
" -------------------------------------------

" Expand tabs when working on rst files
autocmd filetype markdown setlocal expandtab
autocmd filetype markdown setlocal shiftwidth=4
autocmd filetype markdown setlocal tabstop=4

" -------------------------------------------
" ReStructuredText files
" -------------------------------------------

" Expand tabs when working on rst files
autocmd filetype rst setlocal expandtab
autocmd filetype rst setlocal shiftwidth=3
autocmd filetype rst setlocal tabstop=3
autocmd filetype rst setlocal foldmethod=indent

" -------------------------------------------
" Coffeescripts specific configuration
" -------------------------------------------

" Expand tabs when working on python files
autocmd filetype coffee setlocal expandtab
autocmd filetype coffee setlocal shiftwidth=4
autocmd filetype coffee setlocal tabstop=4
autocmd filetype coffee setlocal foldmethod=marker

" Automatically strip whitespace on saving and switching buffer
"autocmd FocusLost,BufLeave,BufWritePre *.py,*.c,*.cpp,*.h :exe "normal! ma" | :%s/\s\+$//e | :exe "normal `a"
autocmd FocusLost,BufLeave,BufWrite *.coffee let b:spacestrip_view=winsaveview()|%s/\s\+$//e|%s/\_.\_^\n*\%$//e|call winrestview(b:spacestrip_view)


" -------------------------------------------
" Shell scripts specific configuration
" -------------------------------------------

" Expand tabs when working on shell files
autocmd filetype zsh,bash,sh setlocal expandtab
autocmd filetype zsh,bash,sh setlocal shiftwidth=4
autocmd filetype zsh,bash,sh setlocal tabstop=4
autocmd filetype zsh,bash,sh setlocal foldmethod=indent

" Automatically strip whitespace on saving and switching buffer
"autocmd FocusLost,BufLeave,BufWritePre *.py,*.c,*.cpp,*.h :exe "normal! ma" | :%s/\s\+$//e | :exe "normal `a"
autocmd FocusLost,BufLeave,BufWrite *.sh let b:spacestrip_view=winsaveview()|%s/\s\+$//e|%s/\_.\_^\n*\%$//e|call winrestview(b:spacestrip_view)


" -------------------------------------------
" SASS secific configuration
" -------------------------------------------

autocmd filetype sass setlocal shiftwidth=4
autocmd filetype sass setlocal tabstop=4
autocmd filetype sass setlocal noexpandtab
autocmd filetype sass setlocal foldmethod=marker

" Automatically strip whitespace from SASS files
autocmd BufWritePre *.sass :%s/\s\+$//e


" -------------------------------------------
" Conf specific configuration
" -------------------------------------------

" Expand tabs when working on configuration files
"autocmd filetype conf set expandtab

" -------------------------------------------
" HTML specific configuration
" -------------------------------------------

"autocmd filetype html,xml,xsl source ~/.vim/scripts/closetag.vim
"autocmd filetype html,xml,xsl setlocal noexpandtab
"autocmd filetype html setlocal ft=htmldjango.html " For SnipMate
autocmd BufNewFile,BufRead *.tmpl set filetype=html
autocmd filetype html,htmljinja,htmldjango,xml,xsl,xslt setlocal expandtab
autocmd filetype html,htmljinja,htmldjango,xml,xsl,xslt setlocal shiftwidth=4
autocmd filetype html,htmljinja,htmldjango,xml,xsl,xslt setlocal tabstop=4
autocmd filetype html,htmljinja,htmldjango,xml,xsl,xslt setlocal foldmethod=syntax


" -------------------------------------------
" Salt state files specific configuration
" -------------------------------------------

autocmd BufRead,BufNewFile *.sls setlocal filetype=yaml
autocmd filetype yaml setlocal expandtab
autocmd filetype yaml setlocal shiftwidth=2
autocmd filetype yaml setlocal tabstop=2
autocmd filetype yaml setlocal foldmethod=indent

" -------------------------------------------
" C++ specific configuration
" -------------------------------------------

autocmd BufRead,BufNewFile *.cu setlocal filetype=cuda
autocmd filetype cpp,c,cuda setlocal expandtab

" -------------------------------------------
" LaTeX specific configuration
" -------------------------------------------

au BufNewFile,BufRead *.gls set filetype=tex
autocmd filetype tex setlocal shiftwidth=2
autocmd filetype tex setlocal tabstop=2
autocmd filetype tex setlocal expandtab
autocmd filetype tex setlocal linebreak
autocmd filetype tex setlocal wrap
autocmd filetype tex setlocal showbreak=→\ 
autocmd filetype tex setlocal nolist " list disables linebreak
autocmd filetype tex setlocal breakindent
autocmd filetype tex setlocal colorcolumn=0
autocmd filetype tex setlocal spell spelllang=en_us
"autocmd filetype tex hi NonText guifg=#ba5757

"autocmd filetype tex set textwidth=100
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

" Use tab and shift+tab to indent and dedent.
" Also keep selection while moving
noremap <Tab> >>
noremap <S-Tab> <<
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
