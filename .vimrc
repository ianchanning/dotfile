" Initially copied from https://github.com/amix/vimrc

" Vundle "{{{
" ======

set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
" git
Plugin 'tpope/vim-fugitive'
" put quotes and brackets around expressions
Plugin 'tpope/vim-surround'
" use [ / ] for next / previous with lots of options
Plugin 'tpope/vim-unimpaired'
" Allow . to work with surround and unimpaired
Plugin 'tpope/vim-repeat'
" store sessions that plays nicely with Airline and PDV
Plugin 'tpope/vim-obsession'
" improve the file explorer
Plugin 'tpope/vim-vinegar'
" database explorer
Plugin 'tpope/vim-dadbod'
" comment stuff
Plugin 'tpope/vim-commentary'

" status bar
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Searching
Plugin 'jremmen/vim-ripgrep'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'mileszs/ack.vim'
" Zeal
Plugin 'KabbAmine/zeavim.vim'
" highlight tabs and spaces at the end of lines
" Plugin 'vim-scripts/cream-showinvisibles' "appeared to cause slowdown on Eee
" syntax checking
Plugin 'w0rp/ale'
Plugin 'neomake/neomake'
" Plugin 'vim-syntastic/syntastic'
" distraction free mode
" Plugin 'junegunn/goyo.vim'
" autocomplete matching brackets and quotes
Plugin 'Raimondi/delimitMate' "this caused minor slowdown/refreshing issues on my Eee
" tab autocomplete
Plugin 'ervandew/supertab'
" JavaScript
" Plugin 'mtscout6/syntastic-local-eslint.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
" ReasonML
Plugin 'reasonml-editor/vim-reason-plus'
" docblocks
Plugin 'heavenshell/vim-jsdoc'
" Plugin 'shawncplus/phpcomplete.vim'
" Formatting docblocks
" Plugin 'godlygeek/tabular' "appeared to cause slowdown on Eee
" Plugin 'tobyS/vmustache'
" Plugin 'tobyS/pdv'
" Plugin has problems with saving sessions
" This is fixed by using the vim-obsession plugin
" It is useful to use this plugin with pdv to replicate functionality from ST
" Plugin 'SirVer/ultisnips'
" Python
" Plugin 'davidhalter/jedi-vim'
" Plugin 'cjrh/vim-conda'
" @link https://www.youtube.com/watch?v=YhqsjUUHj6g
" Plugin 'python-mode/python-mode'
" Plugin 'Bogdanp/pyrepl.vim'
" Align SQL
" Plugin 'Align'
" Plugin 'SQLUtilities'
" Haskell @link https://monicalent.com/blog/2017/11/19/haskell-in-vim/
" ghc-mod fails with the stack install :(
" Plugin 'eagletmt/ghcmod-vim'
" Plugin 'Shougo/vimproc'
" Try intero-vim instead
" Plugin 'parsonsmatt/intero-neovim'
" Language Server Protocol
" This requires extra step of install.sh
" Plugin 'autozimu/LanguageClient-neovim'
" Markdown
" Causes slow down when viewing a markdown page
Plugin 'plasticboy/vim-markdown'
" Plugin 'euclio/vim-markdown-composer'
" Asynchronous tasks
" Plugin 'skywind3000/asyncrun.vim'
" Powershell
" Plugin 'PProvost/vim-ps1'
Plugin 'cespare/vim-toml'
call vundle#end()            " required
filetype plugin indent on    " required


" }}}
" General"{{{
" =======

" Sets how many lines of history VIM has to remember (default=50)
set history=500
" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
let mapleader = ","
let g:mapleader = ","


" }}}
" Plugin config"{{{
" =============

" ALE

" *** failed attempt to figure out the correct path for ALE + javascript-typescript-langserver
" try
"     call ale#Set('javascript_tsls_executable', 'javascript-typescript-langserver')
"     call ale#Set('javascript_tsls_config_path', '')
"     call ale#Set('javascript_tsls_use_global', get(g:, 'ale_use_global_executables', 0))

"     call ale#linter#Define('javascript', {
"     \   'name': 'javascript-typescript-langserver',
"     \   'lsp': 'stdio',
"     \   'executable_callback': ale#node#FindExecutableFunc('javascript_tsls', [
"     \       'javascript-typescript-langserver',
"     \   ]),
"     \   'command': '%e',
"     \   'project_root_callback': {-> ''},
"     \   'language': '',
"     \})
" catch
" endtry

" LSP
try
    let g:LanguageClient_serverCommands = { 
          \ 'haskell': ['hie-wrapper'],
          \ 'javascript': ['tcp://127.0.0.1:2089']
          \ }
catch
endtry

nnoremap <F5> :call LanguageClient_contextMenu()<cr>
map <leader>lk :call LanguageClient#textDocument_hover()<cr>
map <leader>lg :call LanguageClient#textDocument_definition()<cr>
map <leader>lr :call LanguageClient#textDocument_rename()<cr>
map <leader>lf :call LanguageClient#textDocument_formatting()<cr>
map <leader>lb :call LanguageClient#textDocument_references()<cr>
map <leader>la :call LanguageClient#textDocument_codeAction()<cr>
map <leader>ls :call LanguageClient#textDocument_documentSymbol()<cr>

" Vim Markdown
try
    let g:vim_markdown_folding_disabled = 1
catch
endtry

" Airline
" override the default and turn off whitespace warnings
try
    let g:airline_section_warning = airline#section#create(['ycm_warning_count', 'syntastic-warn'])
    if exists("g:asyncrun_status")
        let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])
    endif
    let g:airline_powerline_fonts = 1
    if !exists('g:airline_symbols')
      let g:airline_symbols = {}
    endif

    " unicode symbols
    let g:airline_left_sep = '»'
    let g:airline_left_sep = '▶'
    let g:airline_right_sep = '«'
    let g:airline_right_sep = '◀'
    let g:airline_symbols.crypt = '🔒'
    let g:airline_symbols.linenr = '☰'
    let g:airline_symbols.linenr = '␊'
    let g:airline_symbols.linenr = '␤'
    let g:airline_symbols.linenr = '¶'
    let g:airline_symbols.maxlinenr = ''
    let g:airline_symbols.maxlinenr = '㏑'
    let g:airline_symbols.branch = '⎇'
    let g:airline_symbols.paste = 'ρ'
    let g:airline_symbols.paste = 'Þ'
    let g:airline_symbols.paste = '∥'
    let g:airline_symbols.spell = 'Ꞩ'
    let g:airline_symbols.notexists = 'Ɇ'
    let g:airline_symbols.whitespace = 'Ξ'

    " powerline symbols
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = '☰'
    let g:airline_symbols.maxlinenr = ''
catch
endtry

" vim-surround with quotes
map <leader>' ysiw'
map <leader>" ysiw"

" PHP doc block
" @link https://github.com/tobyS/pdv
" try
"     let g:pdv_template_dir = $HOME ."\\.vim\\bundle\\pdv\\templates_snip"
" catch
" endtry
" " nnoremap <buffer> <C-d> :call pdv#DocumentWithSnip()<cr>
" map <leader>d :call pdv#DocumentWithSnip()<cr>

try
    " @link https://github.com/pangloss/vim-javascript#configuration-variables
    let g:javascript_plugin_jsdoc = 1
    " @link https://github.com/heavenshell/vim-jsdoc
    let g:jsdoc_allow_input_prompt = 1
    let g:jsdoc_input_description = 1
    let g:jsdoc_enable_es6 = 1
catch
endtry

" toggle distraction free
" map <leader>gg :Goyo<cr>

" Javascript doc block
" map <leader>// :JsDoc<cr>

" Tabularize PHP docblock at the $var
" there was a conflict with tt in the Align plugin, so switched to td
" map <leader>td :Tabularize /\$\w*/l1<cr>

" python-mode
try
    " try and prevent rope slowdown
    " let g:pymode_rope_lookup_project = 0
    " Override go-to.definition key shortcut to Ctrl-]
    " let g:pymode_rope_goto_definition_bind = "<C-]>"

    " Override run current python file key shortcut to Ctrl-Shift-e
    " let g:pymode_run_bind = "<C-S-e>"

    " Override view python doc key shortcut to Ctrl-Shift-d
    " let g:pymode_doc_bind = "<C-S-d>"

    " let g:pymode_python = 'python3'
    " PEP-8 options
    " let g:pymode_options = 1
    " let g:pymode_indent = 1
    " let g:pymode_run = 1
    " let g:pymode_run_bind = '<leader>r'
    " let g:pymode_lint = 1
    " let g:pymode_syntax = 1
catch
endtry

" jedi-vim
try
    " turn off preview
    " autocmd FileType python setlocal completeopt-=preview
    " let g:jedi#popup_on_dot = 0
catch
endtry

" ripgrep
try
    " remove a few directories from the search
    let g:rg_command = 'rg --vimgrep --glob !node_modules --glob !build --glob !*.log --glob !output --glob !tags'
    " Ack adds some augmentation to the quickfix list
    if executable('rg')
        let g:ackprg = 'rg --vimgrep --glob !node_modules --glob !build --glob !*.log --glob !output --glob !tags'
    endif
catch
endtry
map <leader>rg :Ack!<cr>
" current word in the current buffer
map <leader>rb :Ack! <cword> %<cr>
" php
map <leader>rp :Ack! -tphp --type-add "ctp:*.ctp" -tctp <cword><cr>
" add a ( on the end to search for functions
map <leader>rf :Ack! <cword>\\\(<cr>
" web
map <leader>rw :Ack! -tjs -tcss -thtml <cword><cr>
" xml
map <leader>rx :Ack! -Txml -Ttags <cword><cr>
" javascript
map <leader>rj :Ack! -tjs --type-add "jsx:*.jsx" -tjsx -tjson -w <cword><cr>

" FZF
if has("gui_running")
    map <leader>f :Files!<cr>
    map <leader>ft :BTags!<cr>
    map <leader>fb :Buffers!<cr>
else
    map <leader>f :Files<cr>
    map <leader>ft :BTags<cr>
    map <leader>fb :Buffers<cr>
endif

" Async Tags
map <leader>at :AsyncRun ctags -R .<cr>

try
    let g:SuperTabDefaultCompletionType = "context"
catch
endtry

" SQL Formatter
try
    " let g:sqlutil_align_comma = 1
catch
endtry

" Syntastic + eslint
try
    if has('gui_running')
        set statusline+=%#warningmsg#
        set statusline+=%{SyntasticStatuslineFlag()}
        set statusline+=%*
    endif

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 0
    let g:syntastic_check_on_wq = 1
    " eslint
    " @todo add link to where I got these from
    let g:syntastic_javascript_checkers = ['eslint']
    let g:syntastic_javascript_eslint_exe = 'npm run lint --'
    " let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
    let g:syntastic_php_checkers = ['php']

    " Sillyness with unicode
    " @link https://codeyarns.com/2014/11/06/how-to-use-syntastic-plugin-for-vim/
    let g:syntastic_error_symbol = "✗"
catch
endtry

" vim-commentary
autocmd FileType rust setlocal commentstring=//\ %s


" }}}
" Colors and Fonts"{{{
" ================

" Enable syntax highlighting
syntax enable
if &diff
    " setup for diff/cmd mode
    set background=dark
else
    " setup for non-diff/gui mode
    set background=dark
endif

try
    " In a Gnome terminal, 
    " Edit | Preferences | [Profile] | Colors | Palette = Solarized
    colorscheme solarized
catch
endtry

" Get us some nice fonts for GVim
if has("gui_running")
    if has("gui_gtk2")
        set guifont=Inconsolata\ 15
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h15
    elseif has("gui_win32")
        if &diff
            set guifont=Source\ Code\ Pro\ for\ Powerline:h11:cANSI
        else
            set guifont=Source\ Code\ Pro\ for\ Powerline:h15:cANSI
        endif
    endif
endif

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

set encoding=utf8 " Set utf8 as standard encoding and en_US as the standard language
set ffs=unix,dos,mac " Use Unix as the standard file type
set showmatch " Show matching brackets when text indicator is over them
set matchtime=2 " How many tenths of a second to blink when matching brackets
set hidden " A buffer becomes hidden when it is abandoned
set hlsearch " Highlight search results
set incsearch " Makes search act like search in modern browsers 
set lazyredraw " Don't redraw while executing macros (good performance config)
set magic " For regular expressions turn magic on

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set timeoutlen=500


" }}}
" Files, backups and undo"{{{
" =======================

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile


" }}}
" Text, tab and indent related"{{{
" ============================

set expandtab " Use spaces instead of tabs
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set autoindent "Auto indent
set smartindent "Smart indent

" set number " line numbers
set colorcolumn=80 " highlight when text gets too long

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :nohlsearch<cr>


" }}}
" Functions"{{{
" =========

" Delete trailing white space on save
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
" create a work log file for today
" if the file doesn't exist create it from a template
function! OpenLog()
    " @todo change this to ~/log
    let logdir = '~/sparklebox/log/'
    let logfile = logdir . strftime("%Y-%m-%d.md")
    " @link https://stackoverflow.com/a/3098685/327074
    if !filereadable(logfile)
        execute ':!cp ' . logdir . 'template.md ' . logfile
    endif
    execute ':e ' . logfile
endfunction

" }}}
" GUI Options"{{{
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
    " F10 toggle
    map <F10> <Esc>:call ToggleGUICruft()<cr>
    " by default, hide gui menus
    set guioptions=i
endif

" }}}
" PHP specific"{{{
" ============

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
au BufWinEnter *.md set mps-=<:>

" }}}
" JSX specific"{{{
" ============
au FileType javascript set softtabstop=2 | set shiftwidth=2
au FileType javascript.jsx set softtabstop=2 | set shiftwidth=2

" }}}
" Plugin independent shortcuts"{{{
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


" }}}
" Windows/Browser/ST3 familiarity"{{{
" ===============================

" MRU Buffer
map <leader><tab> :b#<cr>
" Ctrl-S baby
map <leader>s :w<cr>

" Ctrl-V baby
" Have to use vimx in Fedora (requires +paste option, which isn't enabled in Fedora by default)
" @link https://vi.stackexchange.com/q/2063/11986
" Clipboard paste
map <leader>V "+P
map <leader>v "+p

" current buffer grep
nnoremap <leader>gp yiw<cr>:g/<C-R>"/p<cr>
nnoremap <leader>gr yiw<cr>:lvimgrep <C-R>" %<cr>:lopen<cr>
" copy of SublimeText's @
nnoremap @ :lvimgrep function %<cr>:lopen<cr>

" }}}
" Diff"{{{
" ====

set diffopt+=iwhite " ignore whitespace for diff
" }}}
