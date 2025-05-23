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
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-commentary'
" Forgive me tim for I have sinned and installed extra plugins
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'olimorris/onedarkpro.nvim'
" Note: this is a good example for github README instructions
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'idanarye/vim-merginal'
" GitHub CLI integration
Plug 'ldelossa/litee.nvim'
Plug 'ldelossa/gh.nvim'
Plug 'joshuavial/aider.nvim'
call plug#end()

" {@link https://github.com/olimorris/onedarkpro.nvim/issues/236#issuecomment-2121202478}
lua<<EOF
  require("onedarkpro").setup({
    styles = {
      types = "NONE",
      methods = "NONE",
      numbers = "NONE",
      strings = "NONE",
      comments = "italic",
      keywords = "bold,italic",
      constants = "NONE",
      functions = "italic",
      operators = "NONE",
      variables = "NONE",
      parameters = "NONE",
      conditionals = "italic",
      virtual_text = "NONE",
    }
  })
EOF

lua<<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}
EOF

lua<<EOF
vim.diagnostic.config({
  virtual_text = true,  -- Show inline errors
  signs = true,         -- Show sign column errors
})
require('litee.lib').setup()
require('litee.gh').setup()
EOF

" }}}
" General"{{{
" =======

" Sets how many lines of history VIM has to remember (default=50)
set history=5000

" With a map leader it's possible to do extra key combinations
let mapleader=','
let g:mapleader=','


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
    " I use onelight over onehalflight because that has better diff
    " highlighting
    colorscheme onelight
    " colorscheme onehalflight
    " gets set automatically if sonph/onehalf is installed
    let g:airline_theme='onehalflight'
catch
endtry


" }}}
" Files, backups and undo"{{{
" =======================


" }}}
" Text, tab and indent related"{{{
" ============================

" @link https://vim.fandom.com/wiki/Converting_tabs_to_spaces
:set tabstop=2 shiftwidth=2 expandtab
" this is in vim-sensible
" filetype plugin indent on


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

" Use <cr> to confirm completion
" @link
" https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#use-cr-to-confirm-completion
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

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
map <leader>ff :Files<cr>
map <leader>fg :GFiles<cr>
map <leader>fl :BLines<cr>
let g:fzf_layout={ 'up': '~50%' }


" }}}
" Functions"{{{
" =========

" Function to save markdown file using first line as kebab-case filename
function! SaveMarkdownWithSlugName()
  " Get the first line of the buffer
  let first_line = getline(1)
  
  " Clean up the line - remove markdown formatting and special characters
  let title = first_line
  let title = substitute(title, '\*\+', '', 'g')       " Remove asterisks
  let title = substitute(title, '#\+', '', 'g')        " Remove hashtags
  let title = substitute(title, '[^0-9A-Za-z ]', '', 'g') " Remove special chars
  let title = substitute(title, '\s\+', ' ', 'g')      " Normalize whitespace
  let title = tolower(title)                           " Convert to lowercase
  let title = substitute(title, '\s', '-', 'g')        " Replace spaces with hyphens
  let title = substitute(title, '^-\+', '', '')        " Remove leading hyphens
  let title = substitute(title, '-\+$', '', '')        " Remove trailing hyphens
  
  " Default to a generic name if title is empty
  if title == ""
    let title = "untitled"
  endif
  
  " Get current directory
  let dir = expand('%:p:h')
  
  " Create base filename
  let base_filename = title . ".md"
  let full_path = dir . "/" . base_filename
  
  " Check if file exists and increment if needed
  let counter = 1
  while filereadable(full_path)
    let counter = counter + 1
    let base_filename = title . "-" . counter . ".md"
    let full_path = dir . "/" . base_filename
  endwhile
  
  " Save the file with new name
  execute 'silent! write ' . fnameescape(full_path)
  
  " Rename the buffer to match the file
  execute 'file ' . fnameescape(full_path)
  
  echo "Saved as: " . base_filename
endfunction

" Map the function to a key combination
nnoremap <leader>sm :call SaveMarkdownWithSlugName()<CR>

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

nnoremap <leader>tt :tags<cr>

" hide/show the quickfix lists
" similar bracket syntax to vim-unimpaired
nnoremap [qq :cclose<cr>
nnoremap ]qq :copen<cr>
nnoremap [ll :lclose<cr>
nnoremap ]ll :lopen<cr>
nnoremap [pp :pclose<cr>
nnoremap ]pp :popen<cr>

" terminal easy escape
" It's actually useful to have this complex escape sequence for when you need
" Esc in your terminal session - e.g. opening Vim in your terminal session
tnoremap <leader><Esc> <C-\><C-n>

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
