" Vundle "{{{
" ======

set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
" Plugin 'altercation/vim-colors-solarized'
Plugin 'lifepillar/vim-solarized8'
" 24-bit colorscheme
" Plugin 'jacoborus/tender.vim'
" light colorscheme
Plugin 'nightsense/snow'
Plugin 'andreypopp/vim-colors-plain'
Plugin 'cormacrelf/vim-colors-github'
Plugin 'vim-scripts/chlordane.vim'
Plugin 'vim-scripts/mayansmoke'
Plugin 'arcticicestudio/nord-vim'
" Plugin 'sonph/onehalf', {'rtp': 'vim/'}
" color testing
" Plugin 'guns/xterm-color-table.vim'
" Tim Pope's vimrc sensible defaults
" Plugin 'tpope/vim-sensible'
" git
Plugin 'tpope/vim-fugitive'
" put quotes and brackets around expressions
Plugin 'tpope/vim-surround'
" use [ / ] for next / previous with lots of options
Plugin 'tpope/vim-unimpaired'
" store sessions that plays nicely with Airline and PDV
Plugin 'tpope/vim-obsession'
" improve the file explorer
Plugin 'tpope/vim-vinegar'
" comment stuff
Plugin 'tpope/vim-commentary'
" Repeate surround and unimpaired actions
Plugin 'tpope/vim-repeat'
" status bar
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Searching
Plugin 'jremmen/vim-ripgrep'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
" Zeal
Plugin 'KabbAmine/zeavim.vim'
" highlight tabs and spaces at the end of lines
Plugin 'vim-scripts/cream-showinvisibles' "appeared to cause slowdown on Eee
" syntax checking
Plugin 'w0rp/ale'
" Plugin 'vim-syntastic/syntastic'
" distraction free mode
Plugin 'junegunn/goyo.vim'
" autocomplete matching brackets and quotes
Plugin 'Raimondi/delimitMate' "this caused minor slowdown/refreshing issues on my Eee
" Plugin 'vim-scripts/AutoClose' " delimitMate alternative,
" has issues with YouCompleteMe
" @link https://github.com/Valloric/YouCompleteMe#nasty-bugs-happen-if-i-have-the-vim-autoclose-plugin-installed
Plugin 'ervandew/supertab'
" Plugin 'vim-scripts/taglist.vim' " Browsing source code
" Asynchronous tasks - used for ctags
Plugin 'skywind3000/asyncrun.vim'
Plugin 'majutsushi/tagbar'
" JavaScript
" Plugin 'mtscout6/syntastic-local-eslint.vim' " replaced with ALE
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
" docblocks
Plugin 'heavenshell/vim-jsdoc'
" PHP
Plugin 'shawncplus/phpcomplete.vim'
" Formatting docblocks
Plugin 'godlygeek/tabular' "appeared to cause slowdown on Eee
Plugin 'tobyS/vmustache'
Plugin 'tobyS/pdv'
" Plugin has problems with saving sessions
" This is fixed by using the vim-obsession plugin
" It is useful to use this plugin with pdv to replicate functionality from ST
Plugin 'SirVer/ultisnips'
" Python
" Plugin 'davidhalter/jedi-vim'
" Plugin 'cjrh/vim-conda'
" @link https://www.youtube.com/watch?v=YhqsjUUHj6g
" Plugin 'python-mode/python-mode'
" Plugin 'Bogdanp/pyrepl.vim'
" Align SQL
" Plugin 'Align' " maps tons of shortcuts which causes conflicts
Plugin 'SQLUtilities'
" Haskell
" Plugin 'eagletmt/ghcmod-vim'
" Plugin 'Shougo/vimproc'
" Markdown
" Causes slow down when viewing a mardown page
Plugin 'plasticboy/vim-markdown'
" Powershell
Plugin 'PProvost/vim-ps1'

call vundle#end()            " required
filetype plugin indent on    " required


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
" try
"     let g:vim_markdown_folding_disabled = 1
" catch
" endtry

" PHP doc block
" @link https://github.com/tobyS/pdv
try
    let g:pdv_template_dir = $HOME ."\\.vim\\bundle\\pdv\\templates_snip"
catch
endtry
" nnoremap <buffer> <C-d> :call pdv#DocumentWithSnip()<CR>
map <leader>d :call pdv#DocumentWithSnip()<CR>

" @link https://github.com/heavenshell/vim-jsdoc
try
    let g:jsdoc_allow_input_prompt = 1
    let g:jsdoc_input_description = 1
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
map <leader>td :Tabularize /\$\w*/l1<cr>

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
    let g:rg_command = 'rg --vimgrep -thtml -tjs -tphp --type-add "ctp:*.ctp" -tctp --glob !node_modules --glob !build --glob !*.log --glob !output'
    " I can't figure out using variables in map commands - I'm guessing you can't
    " let rg_opts = '--glob !node_modules --glob !build --glob !*.log --glob !tests'
    " let rg_php = ' -tphp --type-add "ctp:*.ctp" -tctp ' . rg_opts
    " let rg_web = '-tjs -tcss -thtml'
    " let rg_xml = '-Txml -Ttags'
catch
endtry
" map <leader>rg :Rg -tphp expand("<cword>")<cr>
map <leader>rg :Rg<cr>
" current word in the current buffer
map <leader>rb :Rg <cword> %<cr>
" php
map <leader>rp :Rg <cword><cr>
" add a ( on the end to search for functions
map <leader>rf :Rg <cword>\(<cr>
" web
map <leader>rw :Rg -tjs -tcss -thtml <cword><cr>
" xml
map <leader>rx :Rg -Txml -Ttags <cword><cr>

" FZF
if has("gui_running")
    map <leader>f :Files<cr>
    map <leader>ft :BTags<cr>
    map <leader>fb :Buffers<cr>
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
    let g:sqlutil_align_comma = 1
catch
endtry

" Syntastic + eslint
" try
"     if has('gui_running')
"         set statusline+=%#warningmsg#
"         set statusline+=%{SyntasticStatuslineFlag()}
"         set statusline+=%*
"     endif

"     let g:syntastic_always_populate_loc_list = 1
"     let g:syntastic_auto_loc_list = 1
"     let g:syntastic_check_on_open = 0
"     let g:syntastic_check_on_wq = 1
"     " eslint
"     " @todo add link to where I got these from
"     let g:syntastic_javascript_checkers = ['eslint']
"     let g:syntastic_javascript_eslint_exe = 'npm run lint --'
"     " let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
"     let g:syntastic_php_checkers = ['php']

"     " Sillyness with unicode
"     " @link https://codeyarns.com/2014/11/06/how-to-use-syntastic-plugin-for-vim/
"     let g:syntastic_error_symbol = "✗"
" catch
" endtry

" Ale
try
    " `'cleancode,codesize,controversial,design,naming,unusedcode'`
    " cleancode has warnings for else and Configure static access which is
    " used everywhere
    let g:ale_php_phpmd_ruleset = "codesize,design"
    " use only eslint
    let g:ale_linters = {'javascript': ['eslint']}
    " @link https://unicode-table.com/en/blocks/dingbats/
    " let g:ale_sign_error = '✘'
    " let g:ale_sign_warning = '✗'
    " these work for Vim as well as GVim
    let g:ale_sign_error = '»'
    let g:ale_sign_warning = '»'
    let g:ale_lint_on_enter = 0
    let g:ale_lint_on_save = 1
    let g:ale_lint_on_text_changed = 'normal'
catch
endtry

" vim-commentary
autocmd FileType php setlocal commentstring=\/\/\ %s
autocmd FileType javascript setlocal commentstring=\/\/\ %s
autocmd FileType dosbatch setlocal commentstring=rem\ %s

" Airline
" override the default and turn off whitespace warnings
try
    let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])
catch
endtry
try
    " let g:airline_section_warning = airline#section#create(['ycm_warning_count', 'syntastic-warn'])
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

    let g:airline_theme='solarized'
    " simplest looking theme for the windows terminal
    " if has("win32") && !has("gui_running")
    if !has("gui_running")
        " let g:airline_theme='base16_ashes'
        " let g:airline_theme='base16_colors'
        " let g:airline_theme='base16_monokai'
        " let g:airline_theme='base16_ocean'
        " let g:airline_theme='base16_railscasts' " I think this is the best of base16
        " let g:airline_theme='base16_spacemacs' " I want the side colours across the middle
        " let g:airline_theme='molokai' " this has the right colour across the middle
        " let g:airline_theme='qwq' " this has the right colour across the middle
        " this has the right colour across the middle and is best overall
        " its better than qwq because it has a grey for normal and white for
        " insert where as qwq is white for both
        " also the colour differences between the arrows wasn't enough
        " so where as the gradients are more correct in qwq they're too hard
        " to see
        " it is better than molokai also because it has grey for normal and
        " white for insert and molokai is white for both
        " let g:airline_theme='base16_railscasts'
        " let g:airline_theme='base16'
        " After installing neovim I spotted that the path was still including
        " the old 8.0 vim, now with the improved 8.1 Vim it seems that colors
        " are better handled
        " The .vimrc and PHP code look pretty excellent
        " But markdown is a bit screwed
        " Also the base text is red
        " Now also the airline themes work better
        " let g:airline_theme='base16_colors'
        " Actually now, with termguicolors working
        " The solarized plugin should set the airline theme
        " Which now has the correct colours
        let g:airline_theme='solarized'
    endif
catch
endtry


" }}}
" Colors and Fonts"{{{
" ================

" Enable syntax highlighting
" Oh wow!
" Now that I've got Vim 8.1 and Windows 10 build 1803
" suddenly termguicolors works!
" Now there's two major changes - the AirlineTheme colors work exactly as
" intended - so the solarized theme looks the same as the GVim one
" However the solarized colourscheme in the editor was suddenly hideous
" So I've temporarily set it back to default
" I've now found a 24-bit solarized colorscheme - so we can use solarized
syntax enable
if (has("termguicolors"))
    set termguicolors
endif
if &diff
    " setup for diff/cmd mode
    " cmd is Windows only
    set background=light
else
    " setup for non-diff mode
    set background=dark
endif

try
    " In a Gnome terminal,
    " Edit | Preferences | [Profile] | Colors | Palette = Solarized
    " For Windows terminal we just use the default scheme
    " Assuming that you've installed the solarized cmd colours it looks ok
    " Now that we've got 24-bit cmd and termguicolors use solarized8
    if has("unix") || has("gui_running")
        colorscheme solarized8
    endif
    " if has("win32") && !has("gui_running")
    if !has("gui_running")
        colorscheme solarized8
    endif
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
            " set guifont=Anonymice_Powerline:h11:cANSI:qDRAFT
            set guifont=DejaVu_Sans_Mono_For_Powerline:h11:cANSI
            " set guifont=Source\ Code\ Pro\ for\ Powerline:h11:cANSI
        else
            " set guifont=Anonymice_Powerline:h14:cANSI:qDRAFT
            set guifont=DejaVu_Sans_Mono_For_Powerline:h14:cANSI
            " set guifont=Source\ Code\ Pro\ for\ Powerline:h14:cANSI
            " set guifont=Source_Code_Pro_Light:h15:cANSI
        endif
    endif
endif


" }}}
" General"{{{
" ================

" A lot of this come from my initial use of Ultimate vimrc
" @link https://github.com/amix/vimrc

" Ignore compiled files
" Binary
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.o,*.obj,*.exe,*.dll,*.jar,*.pyc,*.rbc,*.class
set wildignore+=*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
set wildignore+=*.avi,*.m4a,*.mp3,*.oga,*.ogg,*.wav,*.webm
set wildignore+=*.eot,*.otf,*.ttf,*.woff
set wildignore+=*.doc,*.pdf
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
" Cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*.gem
set wildignore+=.sass-cache
set wildignore+=npm-debug.log
" Compiled
set wildignore+=*.marko.js
set wildignore+=*.min.*,*-min.*
" Temp/System
set wildignore+=*.*~,*~
set wildignore+=*.swp,.lock,.DS_Store,._*,tags.lock

set wildmenu " useful menu when hitting <Tab>

set encoding=utf8 " Set utf8 as standard encoding and en_US as the standard language
set fileformats=unix,dos,mac " Use Unix as the standard file type
set showmatch " Show matching brackets when text indicator is over them
set matchtime=2 " How many tenths of a second to blink when matching brackets
set hidden " A buffer becomes hidden when it is abandoned
set backspace=eol,start,indent " allows deleting using backspace
set hlsearch " Highlight search results
set incsearch " Makes search act like search in modern browsers
set lazyredraw " Don't redraw while executing macros (good performance config)
set magic " For regular expressions turn magic on
set history=1000 " increase the history from 50 to 1000


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
set nowrap
" the colorcolumn is an ugly red in cmd
if !has("win32") || has("gui_running")
    set colorcolumn=80 " highlight when text gets too long
endif

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

" Logbook
" create a work log file for today
" if the file doesn't exist create it from a template
function! OpenLog()
    " @todo change this to ~/log
    let logdir = 'C:\Users\Ian\SparkleShare\sparklebox\log\'
    let logfile = logdir . strftime("%Y-%m-%d.md")
    let logtemplate = logdir . 'template.md'
    " @link https://stackoverflow.com/a/3098685/327074
    if !filereadable(expand(logfile)) && filereadable(expand(logtemplate))
        execute ':!cp ' . logtemplate . ' ' . logfile
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
autocmd BufWinEnter *.php set mps-=<:>
autocmd BufWinEnter *.ctp set mps-=<:>


" }}}
" JSX specific"{{{
" ============================
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
" similar concept for the tag stack
nnoremap <leader>tt :tags<cr>

" hide/show the quickfix lists
" similar bracket syntax to vim-unimpaired
nnoremap [qq :cclose<cr>
nnoremap ]qq :copen<cr>
nnoremap [ll :lclose<cr>
nnoremap ]ll :lopen<cr>
nnoremap [pp :pclose<cr>
nnoremap ]pp :popen<cr>
" up and down the tag stack
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
nnoremap @ :lvimgrep function %<cr>:lopen<cr>


" }}}
" Diff"{{{
" ====

set diffopt+=iwhite " ignore whitespace for diff


" }}}
" Other"{{{
" ====

" include PHP/JavaScript syntax in omnicomplete <c-x><c-o>
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

" Variable to highlight markdown fenced code properly -- uses tpope's
" vim-markdown plugin (which is bundled with vim7.4 now)
" There are more syntaxes, but checking for them makes editing md very slow
let g:vim_markdown_fenced_languages = [
      \   'javascript', 'js=javascript', 'json=javascript', 'jsx=javascript.jsx',
      \   'sh',
\ ]


" }}}
