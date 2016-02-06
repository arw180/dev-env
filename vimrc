""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VUNDLE
" Vim plugin manager
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Git wrapper
Plugin 'tpope/vim-fugitive'
" Full path fuzzy file, buffer, mru, tag, ... finder
Plugin 'ctrlpvim/ctrlp.vim'
" Comply with PEP8
Plugin 'hynek/vim-python-pep8-indent'
" Color scheme
" Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
" Rainbow colors for parenthesis Plugin 'kien/rainbow_parentheses.vim'
Plugin 'kien/rainbow_parentheses.vim'
" Match xml tags (shift-%)
Plugin 'edsono/vim-matchit'
" Syntax checking
" Requires installing pylint, flake8, or pyflakes
" Install gjslint for JavaScript
" :SyntasticCheck
" :Errors to open error window
" :SyntasticInfo for help
Plugin 'scrooloose/syntastic'
" Python autocomplete
Plugin 'davidhalter/jedi-vim'
" Comment code
Plugin 'scrooloose/nerdcommenter'
" autopep8 utility
" Requires installing autopep8
" <F8> to run autopep8 on current python file
Plugin 'tell-k/vim-autopep8'
" more javascript syntax
Plugin 'pangloss/vim-javascript'
" indent guides
Plugin 'nathanaelkane/vim-indent-guides'
" Auto-add closing characters
Plugin 'Raimondi/delimitMate'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NORMAL CONFIG
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable color syntax highlighting
syntax on
" Make vim use 256 colors
set t_Co=256
" Set colorscheme
set background=dark
" colorscheme zenburn
colorscheme solarized
" Bufffers with unsaved changes are hidden, not closed, when a new file is
" opened
set hidden
" Status line shows possible completions of command line commands, file names,
" etc. Allows cycling forward and backward in the list
set wildmenu
" Show input of an incomplete command
set showcmd
" Required for smartcase
set ignorecase
" Search case-insensitive when search is all lower-case. Otherwise search is
" case-sensitive
set smartcase
set backspace=indent,eol,start
set autoindent
" Prevent cursor from changing the current column when jumping to other lines
" within the window
set nostartofline
" Shows cursor's line and column number and percentage within the buffer
set ruler
" Always display a status line at the bottom of the window
set laststatus=2
set confirm
set t_vb=
set cmdheight=2
set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F11>
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set number
set noscb
" Show column ruler
set colorcolumn=80
map Y y$
map <C-H> <C-W>h<C-W>_
map <C-L> <C-W>l<C-W>_
autocmd VimResized * :wincmd =

let mapleader = ","
nnoremap <F2> :set invnumber<CR>
" Remove trailing whitespace before saving files
autocmd BufWritePre * :%s/\s\+$//e

" Working with tabs
" todo
" Only show filename in tab
set guitablabel=%t
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :vsp %%
map <leader>s :sp %%
map <leader>h :sp %%

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctrlp
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" use ',,' to invoke CtrlP fuzzy file search
nnoremap <silent> <leader><leader> :ClearCtrlPCache<cr>\|:CtrlP<cr>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RAINBOW PARENTHESES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
":RainbowParenthesesToggle       " Toggle it on/off
":RainbowParenthesesLoadRound    " (), the default when toggling
":RainbowParenthesesLoadSquare   " []
":RainbowParenthesesLoadBraces   " {}
":RainbowParenthesesLoadChevrons " <>"
"
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 16

let g:rbpt_loadcmd_toggle = 0

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use pylint
let g:syntastic_python_checkers = ['pylint']
" Use google's gjslint
let g:syntastic_javascript_checkers = ['gjslint']
