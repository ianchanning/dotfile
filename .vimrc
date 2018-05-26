
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Amir Salihefendic
"       http://amix.dk - amix@amix.dk
"
" Version: 
"       5.0 - 29/05/12 15:43:36
"
" Blog_post: 
"       http://amix.dk/blog/post/19691#The-ultimate-Vim-configuration-on-Github
"
" Awesome_version:
"       Get this config, nice color schemes and lots of plugins!
"
"       Install the awesome version from:
"
"           https://github.com/amix/vimrc
"
" Syntax_highlighted:
"       http://amix.dk/vim/vimrc.html
"
" Raw_version: 
"       http://amix.dk/vim/vimrc.txt
"
" Sections:
"    -> Vundle
"    -> General
"    -> Plugin config
"    -> Syntastic + eslint
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"    -> Trailing whitespace
"    -> ICC Hacks
"    -> ICC plugin independent shortcuts
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" @link https://unix.stackexchange.com/a/306188/8224
if exists('py2') && has('python')
elseif has('python3')
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle <https://github.com/VundleVim/Vundle.vim>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" syntax checking
" Plugin 'vim-syntastic/syntastic'
Plugin 'w0rp/ale'
" put quotes and brackets around expressions
Plugin 'tpope/vim-surround'
" use [ / ] for next / previous with lots of options
Plugin 'tpope/vim-unimpaired'
" git
Plugin 'tpope/vim-fugitive'
" store sessions that plays nicely with Airline and PDV
Plugin 'tpope/vim-obsession'
" improve the file explorer
Plugin 'tpope/vim-vinegar'
Plugin 'altercation/vim-colors-solarized'
" highlight tabs and spaces at the end of lines
Plugin 'vim-scripts/cream-showinvisibles'
" distraction free mode
Plugin 'junegunn/goyo.vim'
" autocomplete matching brackets and quotes
Plugin 'Raimondi/delimitMate'
" Airline seems to have an issue with my session saving
" @link https://github.com/vim-airline/vim-airline/issues/1505
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'mattn/emmet-vim'
" Syntax
Plugin 'mtscout6/syntastic-local-eslint.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
" Plugin 'ndreynolds/vim-cakephp'
" Plugin 'shawncplus/phpcomplete.vim'
" docblocks
Plugin 'heavenshell/vim-jsdoc'

" Python
" @link https://www.youtube.com/watch?v=YhqsjUUHj6g
" Plugin 'python-mode/python-mode'
" Plugin 'Bogdanp/pyrepl.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'cjrh/vim-conda'
" Plugin 'jpalardy/vim-slime'

Plugin 'ervandew/supertab'
" Searching
Plugin 'jremmen/vim-ripgrep'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
" Plugin 'rking/ag.vim'
" Zeal
Plugin 'KabbAmine/zeavim.vim'

" Haskell
Plugin 'eagletmt/ghcmod-vim'
Plugin 'Shougo/vimproc'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" Markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Airline
" override the default and turnoff whitespace warnings
try 
    let g:airline_section_warning = airline#section#create(['ycm_warning_count', 'syntastic-warn'])
    " enable buffers as tabs
    " let g:airline#extensions#tabline#enabled = 1
catch
endtry


" @link https://github.com/heavenshell/vim-jsdoc
try 
    let g:jsdoc_allow_input_prompt = 1
    let g:jsdoc_input_description = 1
catch
endtry

" toggle distraction free
map <leader>gg :Goyo<cr>
" Javascript doc block
map <leader>// :JsDoc<cr>
" vim-surround with quotes
map <leader>' ysiw'
map <leader>" ysiw"
" Tabularize PHP docblock at the $var
" there was a conflict with tt in the Align plugin, so switched to td
map <leader>td :Tabularize /\$\w*/l1<cr>

" python-mode

" try and prevent rope slowdown
let g:pymode_rope_lookup_project = 0
" Override go-to.definition key shortcut to Ctrl-]
let g:pymode_rope_goto_definition_bind = "<C-]>"

" Override run current python file key shortcut to Ctrl-Shift-e
let g:pymode_run_bind = "<C-S-e>"

" Override view python doc key shortcut to Ctrl-Shift-d
let g:pymode_doc_bind = "<C-S-d>"

let g:pymode_python = 'python3'
" PEP-8 options
let g:pymode_options = 1
let g:pymode_indent = 1
let g:pymode_run = 1
let g:pymode_run_bind = '<leader>r'
let g:pymode_lint = 1
let g:pymode_syntax = 1

" jedi-vim
" turn off preview
autocmd FileType python setlocal completeopt-=preview
let g:jedi#popup_on_dot = 0

" restrict the search to only PHP and Javascript files
let g:rg_command = 'rg --vimgrep'
" let g:rg_command = 'rg --vimgrep -tphp -tjs -tcss -thtml --type-add "ctp:*.ctp" -tctp'
" let g:rg_command = 'rg --vimgrep -Txml -Ttags'
" map <leader>rg :Rg -tphp expand("<cword>")<cr>
map <leader>rg :Rg<cr>
" current word in the current buffer
map <leader>rb yiw<cr>:Rg <C-R>" %<cr>
" FZF
map <leader>f :Files!<cr>
map <leader>ft :BTags!<cr>
map <leader>fb :Buffers!<cr>
" Ag

" Async
map <leader>at :AsyncRun ctags -R .<cr>

let g:SuperTabDefaultCompletionType = "context"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntastic + eslint
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
   set statusline+=%#warningmsg#
   set statusline+=%{SyntasticStatuslineFlag()}
   set statusline+=%*

   let g:syntastic_always_populate_loc_list = 1
   let g:syntastic_auto_loc_list = 1
   let g:syntastic_check_on_open = 0
   let g:syntastic_check_on_wq = 1
   " eslint
   " @todo add link to where I got these from
   let g:syntastic_javascript_checkers = ['eslint']
   let g:syntastic_javascript_eslint_exe = 'npm run lint --'

   " Sillyness with unicode
   " @link https://codeyarns.com/2014/11/06/how-to-use-syntastic-plugin-for-vim/
   let g:syntastic_error_symbol = "✗"
catch
endtry


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 5 lines to the cursor - when moving vertically using j/k
" I find 7 sometimes too many
set scrolloff=0

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
" Enables tabbing between possibilities
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
" Allow Airline to set this
" set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hidden

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set matchtime=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set timeoutlen=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

set background=dark

try
    colorscheme solarized
catch
endtry

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Get us some nice fonts for GVim
if has("gui_running")
    if has("gui_gtk2")
        set guifont=Inconsolata\ 15
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h15
    elseif has("gui_win32")
		if &diff
			set guifont=Consolas:h11:cANSI
		else
			set guifont=Consolas:h15:cANSI
		endif
    endif
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set linebreak
set textwidth=500

set autoindent "Auto indent
set smartindent "Smart indent
set wrap "Wrap lines


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Specify the behavior when switching between buffers 
try
  " ICC - This seemed to create [No Name] buffers from quicklist 
  " set switchbuf=useopen,usetab,newtab
  " Always show the tabline
  " ICC - Allow Airline to control it
  " set showtabline=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Trailing whitespace
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
autocmd BufWrite *.nsi :call DeleteTrailingWS()
autocmd BufWrite *.js :call DeleteTrailingWS()
autocmd BufWrite *.jsx :call DeleteTrailingWS()
autocmd BufWrite *.php :call DeleteTrailingWS()
autocmd BufWrite *.ctp :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>  ICC hacks
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Commenting blocks of code.
" @link http://stackoverflow.com/a/24046914/327074
let s:comment_map = { 
    \   "c": '\/\/',
    \   "cpp": '\/\/',
    \   "go": '\/\/',
    \   "java": '\/\/',
    \   "javascript": '\/\/',
    \   "javascript.jsx": '\/\/',
    \   "lua": '--',
    \   "haskell": '--',
    \   "scala": '\/\/',
    \   "php": '\/\/',
    \   "ctp": '\/\/',
    \   "python": '#',
    \   "ruby": '#',
    \   "rust": '\/\/',
    \   "sh": '#',
    \   "desktop": '#',
    \   "fstab": '#',
    \   "conf": '#',
    \   "profile": '#',
    \   "bashrc": '#',
    \   "bash_profile": '#',
    \   "mail": '>',
    \   "eml": '>',
    \   "bat": 'rem',
    \   "cmd": 'rem',
    \   "dosbatch": 'rem',
    \   "nsis": ';',
    \   "ahk": ';',
    \   "vim": '"',
    \   "tex": '%',
    \   "sql": '--',
    \   "yaml": '#'
    \ }

function! ToggleComment()
    if has_key(s:comment_map, &filetype)
        let comment_leader = s:comment_map[&filetype]
        if getline('.') =~ "^\\s*" . comment_leader . " " 
            " Uncomment the line
            execute "silent s/^\\(\\s*\\)" . comment_leader . " /\\1/"
        else 
            if getline('.') =~ "^\\s*" . comment_leader
                " Uncomment the line
                execute "silent s/^\\(\\s*\\)" . comment_leader . "/\\1/"
            else
                " Comment the line
                execute "silent s/^\\(\\s*\\)/\\1" . comment_leader . " /"
            end
        end
    else
        echo "No comment leader found for filetype"
    end
endfunction

nnoremap <leader><Space> :call ToggleComment()<cr>
vnoremap <leader><Space> :call ToggleComment()<cr>

" Remove the menubar, toolbar and right scrollbar
" @link https://stackoverflow.com/a/13525844/327074
function! ToggleGUICruft()
    if &guioptions=='i'
        exec('set guioptions=imTrL')
    else
        exec('set guioptions=i')
    endif
endfunction

if has("gui_running")
    " F10 toggle
    map <F10> <Esc>:call ToggleGUICruft()<cr>
    " by default, hide gui menus
    set guioptions=i
endif

function! SortLines() range
    execute a:firstline . "," . a:lastline . 's/^\(.*\)$/\=strdisplaywidth( submatch(0) ) . " " . submatch(0)/'
    execute a:firstline . "," . a:lastline . 'sort n'
    execute a:firstline . "," . a:lastline . 's/^\d\+\s//'
endfunction

" PHP specific

" CakePHP navigation 
map <leader>ct yiw<cr>:tag /^<C-R>"<cr>
map <leader>ch yiw<cr>:tag /^<C-R>"Helper<cr>
map <leader>cc yiw<cr>:tag /^<C-R>"Component<cr>

" Add a ; to the end of the line
map <leader>; A;<esc>
" turn off the > beep
" @link https://stackoverflow.com/a/24242461/327074
au BufWinEnter *.php set mps-=<:>
au BufWinEnter *.ctp set mps-=<:>

" @link http://vim.wikia.com/wiki/VimTip159
:command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
:command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>  ICC plugin independent shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Windows familiarity

" MRU Buffer
map <leader><tab> :b#<cr>
" Ctrl-S baby
map <leader>s :w<cr>
" Ctrl-W baby
" Only close the tab and not kill the buffer
" as that has the high likelihood of losing code
" where's the land of confirmations when you need it?
map <leader>w :tabclose<cr>
" Ctrl-V baby (requires +paste option, which isn't enabled in Fedora by default)
" Switch to + as * doesn't appear to be available
" Have to use vimx 
" @link https://vi.stackexchange.com/q/2063/11986
" Clipboard Paste
map <leader>V "+P
map <leader>v "+p

" buffers
map <leader>ll :ls<cr>

" better file finder
" @link https://stackoverflow.com/a/44647932/327074
" nnoremap <leader>bb :set nomore<bar>:ls<bar>:set more<cr>:b<space>
" @link http://vim.wikia.com/wiki/Easier_buffer_switching
nnoremap <leader>bb :buffers<cr>:b<space>

" current buffer grep
nnoremap <leader>gp yiw<cr>:g/<C-R>"/p<cr>
nnoremap <leader>gr yiw<cr>:lvimgrep <C-R>" %<cr>:lopen<cr>
nnoremap <leader>gf :lvimgrep function %<cr>:lopen<cr>
nnoremap <leader>@ :lvimgrep function %<cr>:lopen<cr>


" tabs to 4-spaces
map <leader>ts :%s/\t/    /g<cr>
" 4-spaces to tabs
" this has an issue inside docblocks
map <leader>st :%s/    /\t/g<cr>

" hide/show the quickfix list
map [qq :cclose<cr>
map ]qq :copen<cr>
map [ll :lclose<cr>
map ]ll :lopen<cr>
map [pp :pclose<cr>
map ]pp :popen<cr>


" enable folds for filetypes
" autocmd FileType javascript.jsx setlocal foldmethod=indent
" autocmd FileType javascript setlocal foldmethod=indent
" autocmd FileType php setlocal foldmethod=indent

" logbook

" create a work log file for today
" if the file doesn't exist create it from a template
function! OpenLog()
	let logdir = 'C:\Users\Ian\SparkleShare\sparkleshare\work\log\'
	let logfile = logdir . strftime("%Y-%m-%d.md")
	" @link https://stackoverflow.com/a/3098685/327074
	if !filereadable(logfile)
		execute ':!cp ' . logdir . 'template.md ' . logfile
	endif
	execute ':e ' . logfile
endfunction

" Turn on line numbers by default
set number
set colorcolumn=80
