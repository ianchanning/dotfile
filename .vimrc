" Vundle "{{{
" ======

set nocompatible              " be iMproved, required
call plug#begin('~/.vim/bundle')

" Plug 'altercation/vim-colors-solarized'
" Plug 'sickill/vim-monokai'
" 24-bit, requires termguicolors
Plug 'lifepillar/vim-solarized8'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
" Sensible defaults
Plug 'tpope/vim-sensible'
" git
Plug 'tpope/vim-fugitive'
" put quotes and brackets around expressions
Plug 'tpope/vim-surround'
" use [ / ] for next / previous with lots of options
Plug 'tpope/vim-unimpaired'
" store sessions that plays nicely with Airline and PDV
Plug 'tpope/vim-obsession'
" improve the file explorer
Plug 'tpope/vim-vinegar'
" comment stuff
Plug 'tpope/vim-commentary'
" Repeat unimpaired and surround expressions
Plug 'tpope/vim-repeat'
" Database connections
Plug 'tpope/vim-dadbod'
" JSON pretty print - gqaj
Plug 'tpope/vim-jdaddy'
" status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Searching
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Plug 'junegunn/vim-peekaboo'
" Git
" Plug 'junegunn/gv.vim'
" Plug 'gregsexton/gitv'
" Plug 'idanarye/vim-merginal'
" Zeal
Plug 'KabbAmine/zeavim.vim'
" highlight tabs and spaces at the end of lines
Plug 'vim-scripts/cream-showinvisibles' "appeared to cause slowdown on Eee
" syntax checking
Plug 'w0rp/ale'
" Plug 'neomake/neomake'
" Plug 'benjie/local-npm-bin.vim'
" distraction free mode
Plug 'junegunn/goyo.vim'
" autocomplete matching brackets and quotes
Plug 'Raimondi/delimitMate' "this caused minor slowdown/refreshing issues on my Eee
" has issues with YouCompleteMe
" @link https://github.com/Valloric/YouCompleteMe#nasty-bugs-happen-if-i-have-the-vim-autoclose-plugin-installed
Plug 'ervandew/supertab'
" Plug 'majutsushi/tagbar' " Browsing tags
" Asynchronous tasks - used for ctags
Plug 'skywind3000/asyncrun.vim'
" JavaScript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'jparise/vim-graphql'
" docblocks
Plug 'heavenshell/vim-jsdoc'
" PHP
" Plug 'shawncplus/phpcomplete.vim'
" Formatting docblocks
" Plug 'godlygeek/tabular' "slowdown on Eee, suggested for vim-markdown
" Plug 'tobyS/vmustache'
" Plug 'tobyS/pdv'
" Plug has problems with saving sessions
" This is fixed by using the vim-obsession plugin
" It is useful to use this plugin with pdv to replicate functionality from ST
" Plug 'SirVer/ultisnips'
" Python
" Plug 'davidhalter/jedi-vim'
" Plug 'cjrh/vim-conda'
" @link https://www.youtube.com/watch?v=YhqsjUUHj6g
" Plug 'python-mode/python-mode'
" Plug 'Bogdanp/pyrepl.vim'
" Align SQL
" Plug 'Align' " this creates lots of shortcuts which conflicts
" Plug 'SQLUtilities'
" Haskell
" Plug 'eagletmt/ghcmod-vim'
" Plug 'Shougo/vimproc'
" Markdown
" Causes slow down when viewing a mardown page
Plug 'plasticboy/vim-markdown'
" Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'suan/vim-instant-markdown'
Plug 'iamcco/markdown-preview.nvim'
" Powershell
" Plug 'PProvost/vim-ps1'

call plug#end()


" }}}
" General"{{{
" =======
" With a map leader it's possible to do extra key combinations
let mapleader = ","
let g:mapleader = ","


" }}}
" Plugin config"{{{
" =============

" Vim Markdown
try
    let g:vim_markdown_folding_disabled = 1
    let g:instant_markdown_autostart = 0
catch
endtry

" Ale
try
    " 'cleancode,codesize,controversial,design,naming,unusedcode'
    let g:ale_php_phpmd_ruleset = "cleancode,codesize,design"
    " @link https://unicode-table.com/en/blocks/dingbats/
    let g:ale_sign_error = '✘'
    " let g:ale_sign_warning = '✗'
    " @link https://unicode-table.com/en/#control-character
    " let g:ale_sign_error = '»'
    let g:ale_sign_warning = '»'
    " let g:ale_lint_on_enter = 0
    " let g:ale_lint_on_text_changed = 'normal'
    let g:ale_linters = {'javascript': ['eslint']}
    let g:ale_fixers = {'javascript': ['eslint']}
    " let g:ale_fix_on_save = 1
    " @link https://github.com/w0rp/ale/issues/1224#issuecomment-352248157
    " let g:ale_javascript_eslint_use_global = 1
    let g:ale_javascript_eslint_executable = 'eslint_d'
catch
endtry

" Neomake
try
    let g:neomake_javascript_enabled_makers = ['eslint_d']
    " @link https://github.com/mantoni/eslint_d.js#automatic-fixing
    " Autofix entire buffer with eslint_d:
    nnoremap <leader>nm mF:%!eslint_d --stdin --fix-to-stdout<CR>`F
    " Autofix visual selection with eslint_d:
    vnoremap <leader>nm :!eslint_d --stdin --fix-to-stdout<CR>gv
catch
endtry

" vim-commentary
try
    autocmd FileType php setlocal commentstring=\/\/\ %s
    autocmd FileType javascript setlocal commentstring=\/\/\ %s
    autocmd FileType dosbatch setlocal commentstring=rem\ %s
catch
endtry

" Airline
" override the default and turn off whitespace warnings
try
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

" PHP doc block
" @link https://github.com/tobyS/pdv
try
    let g:pdv_template_dir = $HOME ."\\.vim\\bundle\\pdv\\templates_snip"
catch
endtry
" nnoremap <buffer> <C-d> :call pdv#DocumentWithSnip()<CR>
" map <leader>d :call pdv#DocumentWithSnip()<CR>

" @link https://github.com/heavenshell/vim-jsdoc
try
    let g:jsdoc_allow_input_prompt = 1
    let g:jsdoc_input_description = 1
    let g:jsdoc_enable_es6 = 1
catch
endtry

" vim-javascript
try
    let g:javascript_plugin_jsdoc = 1
catch
endtry

" toggle distraction free
map <leader>gg :Goyo<cr>

" Javascript doc block
" map <leader>// :JsDoc<cr>

" vim-surround with quotes
map <leader>' ysiw'
map <leader>" ysiw"

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
    " put PHP search in by default
    " let g:rg_command = 'rg --vimgrep -thtml -tjs -tphp --type-add "ctp:*.ctp" -tctp --glob !node_modules --glob !build --glob !*.log --glob !output'
    let g:rg_command = 'rg --vimgrep --glob !node_modules --glob !build --glob !*.log --glob !output --glob !tags --glob !Session.vim --glob !_volumes*'
    " I can't figure out using variables in map commands - I'm guessing you can't
    " let rg_opts = '--glob !node_modules --glob !build --glob !*.log --glob !tests'
    " let rg_php = ' -tphp --type-add "ctp:*.ctp" -tctp ' . rg_opts
    " let rg_web = '-tjs -tcss -thtml'
    " let rg_xml = '-Txml -Ttags'
catch
endtry
map <leader>rg :Rg<cr>
" current word in the current buffer
map <leader>rb :Rg <cword> %<cr>
" add a ( on the end to search for functions
map <leader>rf :Rg <cword>\(<cr>
" wholeword
map <leader>rw :Rg -w <cword><cr>

" FZF
map <leader>f :Files<cr>
map <leader>ft :BTags<cr>
map <leader>fb :Buffers<cr>
let g:fzf_layout = { 'left': '~70%' }

" Async Tags
map <leader>at :AsyncRun ctags -R .<cr>

try
    let g:SuperTabDefaultCompletionType = "context"
catch
endtry

" SQL Formatter
try
    let g:sqlutil_align_comma = 1
catch
endtry


" }}}
" Colors and Fonts"{{{
" ================

" Enable syntax highlighting
syntax enable

" @link https://askubuntu.com/questions/67/how-do-i-enable-full-color-support-in-vim
if (has("termguicolors"))
    set termguicolors
endif

if &diff
    " setup for diff/cmd mode
    set background=light
else
    " setup for non-diff/gui mode
    set background=light
endif

try
    " In a Gnome terminal,
    " Edit | Preferences | [Profile] | Colors | Palette = Solarized
    " colorscheme solarized8
    " colorscheme solarized
    colorscheme onehalflight
    " Attempts at debugging lack of bold fonts in Konsole
    " highlight htmlBold gui=bold guifg=#af0000 ctermfg=124
    " highlight htmlItalic gui=italic guifg=#ff8700 ctermfg=214
catch
endtry

" Get us some nice fonts for GVim
if has("gui_running")
    set guifont=Noto\ Mono\ for\ Powerline\ Regular:h13.5
    " set guifont=NovaMono\ for\ Powerline\ 8
    " set guifont=Source\ Code\ Pro\ for\ Powerline\ 8
    if has("gui_macvim")
        set guifont=Menlo\ Regular:h15
    elseif has("gui_win32")
        if &diff
            set guifont=Source\ Code\ Pro\ for\ Powerline:h11:cANSI
        else
            set guifont=Source\ Code\ Pro\ for\ Powerline:h15:cANSI
        endif
    endif
endif
" Match the terminal font for gnvim which doesn't have 'gui_running' set
set guifont=Noto\ Mono\ for\ Powerline\ Regular:h13.5

" Autocomplete menu for ed commands
set wildmenu
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

set encoding=utf8 " Set utf8 as standard encoding and en_US as the standard language
set fileformats=unix,dos,mac " Use Unix as the standard file type
set showmatch " Show matching brackets when text indicator is over them
set matchtime=2 " How many tenths of a second to blink when matching brackets
set backspace=indent,eol,start " allow backspace to delete characters
set hidden " A buffer becomes hidden when it is abandoned
set hlsearch " Highlight search results
set incsearch " Makes search act like search in modern browsers
set lazyredraw " Don't redraw while executing macros (good performance config)
set magic " For regular expressions turn magic on
set history=1000

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

set nonumber " line numbers
" set nowrap " used this when lots of windows are required
set colorcolumn=100 " highlight when text gets too long

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
autocmd BufWrite *.vimrc :call DeleteTrailingWS()
autocmd BufWrite *.md :call DeleteTrailingWS()
autocmd BufWrite *.sql :call DeleteTrailingWS()
autocmd BufWrite *.graphql :call DeleteTrailingWS()

" Logbook
" create a work log file for today
" if the file doesn't exist create it from a template
function! OpenLog()
    " We've switched from Dropbox to SparkleShare
    " let logdir = '~/Dropbox/log/'
    " let logdir = '~/SparkleShare/bitbucket.org/sparkle/log/'
    " Now symlinked
    let logdir = '~/log/'
    let logfile = logdir . strftime("%Y-%m-%d.md")
    " '~' doesn't work for the filereadable check, need `expand`
    " @link https://stackoverflow.com/a/53205873/327074
    if !filereadable(expand(logfile))
        execute ':!cp ' . logdir . 'template.md ' . logfile
    endif
    execute ':e ' . logfile
endfunction

" }}}
" GUI Options"{{{
" ===========

" Remove the menu bar, toolbar and right scrollbar
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
    " by default, hide GUI menus
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
autocmd BufWinEnter *.php set mps-=<:>
autocmd BufWinEnter *.ctp set mps-=<:>
autocmd BufWinEnter *.md set mps-=<:>


" }}}
" JSX specific"{{{
" ============================
au FileType javascript set softtabstop=2 | set shiftwidth=2 | set colorcolumn=100
au FileType javascript.jsx set softtabstop=2 | set shiftwidth=2 | set colorcolumn=100


" }}}
" Plugin independent shortcuts"{{{
" ============================

" better file finder
" @link http://vim.wikia.com/wiki/Easier_buffer_switching
" @link https://stackoverflow.com/a/44647932/327074
" nnoremap <leader>bb :set nomore<bar>:ls<bar>:set more<cr>:b<space>
" I prefer to allow the 'more' so you can see the previous pages of buffers
nnoremap <leader>bb :buffers<cr>:b<space>

nnoremap <leader>tt :tags<cr>

" hide/show the quickfix lists
" similar bracket syntax to vim-unimpaired
nnoremap [qq :cclose<cr>
nnoremap ]qq :copen<cr>
nnoremap [ll :lclose<cr>
nnoremap ]ll :lopen<cr>
nnoremap [pp :pclose<cr>
nnoremap ]pp :popen<cr>
" tag stack
nnoremap [ts :pop<cr>
nnoremap ]ts :tag<cr>

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
" this conflicts with registers, and it's not really used
" nnoremap @ :lvimgrep function %<cr>:lopen<cr>


" }}}
" Diff"{{{
" ====

set diffopt+=iwhite " ignore white space for diff


" }}}
" Git"{{{
" ====

map <leader>gl :Git log --graph --oneline --decorate --all<cr>
map <leader>gll :Git log --graph --abbrev-commit --decorate --date=relative --all<cr>


" }}}
" Spelling"{{{
" ====

setlocal spell
set spelllang=en_gb


" }}}
" Other"{{{
" ====

" include PHP/JavaScript syntax in omnicomplete <c-x><c-o>
" autocmd FileType php set omnifunc=phpcomplete#CompletePHP
" autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

" Variable to highlight markdown fenced code properly -- uses tpope's
" vim-markdown plugin (which is bundled with vim7.4 now)
" There are more syntaxes, but checking for them makes editing md very slow
let g:vim_markdown_fenced_languages = ['js=javascript']


" }}}
