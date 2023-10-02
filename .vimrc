" Initially copied from https://github.com/amix/vimrc
" Good tips from https://github.com/nelstrom/dotfiles/blob/master/vimrc
" let $NVIM_COC_LOG_LEVEL='debug'

" vim-plug"{{{
" ======

" Auto-install
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
" Note: This does not work with curl installed via snap
" https://askubuntu.com/a/1372732/8989
let data_dir=has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set nocompatible              " be iMproved, required
" Match the Vundle plugin directory
" https://github.com/junegunn/vim-plug/wiki/tips#migrating-from-other-plugin-managers
call plug#begin('~/.vim/bundle')
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'olimorris/onedarkpro.nvim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-commentary'
" Note: this is a good example for github README instructions
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" }}}
" General"{{{
" =======

" Sets how many lines of history VIM has to remember (default=50)
set history=5000

" With a map leader it's possible to do extra key combinations
let mapleader=','
let g:mapleader=','

" turn off the > beep
" @link https://stackoverflow.com/a/24242461/327074
autocmd BufWinEnter *.md set mps-=<:>

" }}}
" Colors and Fonts"{{{
" ================

" @link https://askubuntu.com/questions/67/how-do-i-enable-full-color-support-in-vim
if (has("termguicolors"))
    set termguicolors
endif

try
    " In a Gnome terminal,
    " Edit | Preferences | [Profile] | Colors | Palette = Solarized
    " colorscheme onehalflight
    " gets set automatically if sonph/onehalf is installed
    let g:airline_theme='onehalflight'
    " onedarkpro
    colorscheme onelight
catch
endtry



" }}}
" Files, backups and undo"{{{
" =======================


" }}}
" Text, tab and indent related"{{{
" ============================



" }}}
" Plugin config"{{{
" =============

" LSP - COC

" coc recommendations
" @link https://github.com/neoclide/coc.nvim#example-vim-configuration

" Having longer updatetime (default is 4000 ms) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
" GoTo code navigation.
" Match vscode
nmap <silent> <F12> <Plug>(coc-definition)
nmap <silent> <F2> <Plug>(coc-rename) " Symbol renaming.
" vim-commentary
try
    autocmd FileType php setlocal commentstring=\/\/\ %s
    autocmd FileType javascript setlocal commentstring=\/\/\ %s
    autocmd FileType reason setlocal commentstring=\/\/\ %s
    autocmd FileType dosbatch setlocal commentstring=rem\ %s
    autocmd FileType rust setlocal commentstring=//\ %s
catch
endtry

" Airline
" override the default and turn off whitespace warnings
try
    " https://ianchanning.wordpress.com/2018/06/18/vim-airline-powerline-fonts-on-fedora-ubuntu-and-windows/
    let g:airline_powerline_fonts=1
    if !exists('g:airline_symbols')
      let g:airline_symbols={}
    endif

    " unicode symbols
    let g:airline_left_sep='»'
    let g:airline_left_sep='▶'
    let g:airline_right_sep='«'
    let g:airline_right_sep='◀'
    let g:airline_symbols.crypt='🔒'
    let g:airline_symbols.linenr='☰'
    let g:airline_symbols.linenr='␊'
    let g:airline_symbols.linenr='␤'
    let g:airline_symbols.linenr='¶'
    let g:airline_symbols.maxlinenr=''
    let g:airline_symbols.maxlinenr='㏑'
    let g:airline_symbols.branch='⎇'
    let g:airline_symbols.paste='ρ'
    let g:airline_symbols.paste='Þ'
    let g:airline_symbols.paste='∥'
    let g:airline_symbols.spell='Ꞩ'
    let g:airline_symbols.notexists='Ɇ'
    let g:airline_symbols.whitespace='Ξ'

    " powerline symbols
    let g:airline_left_sep=''
    let g:airline_left_alt_sep=''
    let g:airline_right_sep=''
    let g:airline_right_alt_sep=''
    let g:airline_symbols.branch=''
    let g:airline_symbols.readonly=''
    let g:airline_symbols.linenr='☰'
    let g:airline_symbols.maxlinenr=''
catch
endtry

" vim-surround with quotes
map <leader>' ysiw'
map <leader>" ysiw"


" FZF
" GFiles is useful because it respects .gitignore
map <leader>f :GFiles<cr>
map <leader>ff :Files<cr>
map <leader>ft :BTags<cr>
map <leader>fb :BLines<cr>
map <leader>fl :Lines<cr>
map <leader>m :FZFMru<cr>
let g:fzf_layout={ 'up': '~50%' }


" }}}
" Functions"{{{
" =========



" }}}
" Indent settings"{{{
" ============


" }}}
" Plugin independent shortcuts"{{{
" ============================

" Add a ; to the end of the line
map <leader>; A;<esc>

" better file finder
" @link http://vim.wikia.com/wiki/Easier_buffer_switching
" @link https://stackoverflow.com/a/44647932/327074
" nnoremap <leader>bb :set nomore<bar>:ls<bar>:set more<cr>:b<space>
" I prefer to allow the 'more' so you can see the previous pages of buffers
nnoremap <leader>bb :buffers<cr>:b<space>
nnoremap <c-p> :buffers<cr>:b<space>

" @link https://stackoverflow.com/a/5563142/327074
" nnoremap <silent> <tab>  :if &modifiable && !&readonly && &modified <cr> :write<cr> :endif<cr>:bnext<cr>
" nnoremap <silent> <s-tab>  :if &modifiable && !&readonly && &modified <cr> :write<cr> :endif<cr>:bprevious<cr>
nnoremap <silent> <tab> :bnext<cr>
nnoremap <silent> <s-tab> :bprevious<cr>

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

" terminal easy escape
" It's actually useful to have this complex escape sequence for when you need
" Esc in your terminal session - e.g. opening Vim in your terminal session
tnoremap <leader><Esc> <C-\><C-n>

" @link https://github.com/nelstrom/dotfiles/blob/master/vimrc
cnoremap <expr> %%  getcmdtype() == ':' ? fnameescape(expand('%:h')).'/' : '%%'

map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

nnoremap <leader>dt :windo diffthis<cr>
nnoremap <leader>do :windo diffoff<cr>


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
map <leader>p "0p
map <leader>P "0P


" }}}
" Diff"{{{
" ====

set diffopt+=iwhite " ignore white space for diff


" }}}
" Git"{{{
" ====

map <leader>gg :Git<cr>
map <leader>gl :Git log --graph --oneline --decorate<cr>
map <leader>gll :Git log --graph --abbrev-commit --decorate --date=relative<cr>


" }}}
" Spelling"{{{
" ====

setlocal spell
set spelllang=en_gb


" }}}
" Other"{{{
" ====


" }}}
