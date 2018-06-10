set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
call vundle#end()            " required
filetype plugin indent on    " required

syntax enable
set background=dark
try
    colorscheme solarized
endtry

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2

" A buffer becomes hidden when it is abandoned
set hidden

" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch 

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Use spaces instead of tabs
set expandtab
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

set autoindent "Auto indent
set smartindent "Smart indent

set number " line numbers
set colorcolumn=80 " highlight when text gets too long

" Delete trailing white space on save
" ===================================

function! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunction

autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
autocmd BufWrite *.nsi :call DeleteTrailingWS()
autocmd BufWrite *.js :call DeleteTrailingWS()
autocmd BufWrite *.jsx :call DeleteTrailingWS()
autocmd BufWrite *.php :call DeleteTrailingWS()
autocmd BufWrite *.ctp :call DeleteTrailingWS()

" Logbook
" =======

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

" PHP specific
" ===========

" Add a ; to the end of the line
map <leader>; A;<esc>

" CakePHP navigation 
map <leader>ct yiw<cr>:tag /^<C-R>"<cr>
map <leader>ch yiw<cr>:tag /^<C-R>"Helper<cr>
map <leader>cc yiw<cr>:tag /^<C-R>"Component<cr>

" turn off the > beep
" @link https://stackoverflow.com/a/24242461/327074
au BufWinEnter *.php set mps-=<:>
au BufWinEnter *.ctp set mps-=<:>

" GUI Options
" ===========

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
    " Get us some nice fonts for GVim
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

    " F10 toggle
    map <F10> <Esc>:call ToggleGUICruft()<cr>
    " by default, hide gui menus
    set guioptions=i
endif

" Plugin independent shortcuts
" ============================

" better file finder
" @link http://vim.wikia.com/wiki/Easier_buffer_switching
" @link https://stackoverflow.com/a/44647932/327074
" nnoremap <leader>bb :set nomore<bar>:ls<bar>:set more<cr>:b<space>
" I prefer to allow the 'more' so you can see the previous pages of buffers
nnoremap <leader>bb :buffers<cr>:b<space>

" hide/show the quickfix lists
" similar bracket syntax to vim-unimpaired 
map [qq :cclose<cr>
map ]qq :copen<cr>
map [ll :lclose<cr>
map ]ll :lopen<cr>
map [pp :pclose<cr>
map ]pp :popen<cr>

" Windows/Browser/ST3 familiarity
" ===============================

" MRU Buffer
map <leader><tab> :b#<cr>

" Ctrl-S baby
map <leader>s :w<cr>

" Ctrl-V baby (requires +paste option, which isn't enabled in Fedora by default)
" Switch to + as * doesn't appear to be available
" Have to use vimx in Fedora
" @link https://vi.stackexchange.com/q/2063/11986
" Clipboard Paste
map <leader>V "+P
map <leader>v "+p

" current buffer grep
" copy of SublimeText's @
nnoremap <leader>@ :lvimgrep function %<cr>:lopen<cr>
