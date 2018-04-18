" Include the system settings
if filereadable( "/etc/vimrc" )
  source /etc/vimrc
endif
" Include Arista-specific settings
if filereadable( $VIM . "/vimfiles/arista.vim" )
  source $VIM/vimfiles/arista.vim
endif

" Put your own customizations below"
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'fatih/vim-go'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'majutsushi/tagbar'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-latex/vim-latex'
Plugin 'rust-lang/rust.vim'
Plugin 'scrooloose/syntastic'
Plugin 'yggdroot/indentline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'godlygeek/tabular'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'sickill/vim-pasta'
Plugin 'luochen1990/rainbow'
Plugin 'mbbill/undotree'
Plugin 'bling/vim-airline'
Plugin 'flazz/vim-colorschemes'
Plugin 'raimondi/delimitmate'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'oplatek/conque-shell'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'a.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'easymotion/vim-easymotion'
Plugin 'bkad/camelcasemotion'
Plugin 'terryma/vim-expand-region'
if has('patch1578')
   Plugin 'Valloric/YouCompleteMe'
endif
Plugin 'greymd/oscyank.vim'
Plugin 'roxma/vim-paste-easy'
" " All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" " To ignore plugin indent changes, instead use:
" "filetype plugin on
" "
" " Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line
" Include the system settings

" ------------below are my customized configs----------------------

"       ------------general vim settings-------------

" <Leader> = ','
let mapleader=","

" Syntax Highlight
syntax on

" 256 color
let &t_Co=256

" color scheme/theme
colorscheme molokai

" line number on
set number relativenumber

" scrolling minimun lines
set scrolloff=5

" bottom status bar
set laststatus=2

" forget
set hidden

" show matching braces
set showmatch

" smart case sensitive search
set ignorecase
set smartcase

" max length of code is 85
set cc=86
"match Error /\%86v.\+/

" only highlight the overlength but not auto-wrapped
set tw=0

" maps : to ;
map ; :

set encoding=utf-8

" make .vimrc has effect immediately
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" shortcut for inserting a new line without entering insert mode
nmap oo o<Esc>k
nmap OO O<Esc>

"map esc to jj
imap jj <Esc>

" set to auto read when a file is changed from the outside
set autoread

" Better command-line completion
set wildmenu
set wildmode=list:longest,full

" Search related
set hlsearch
set incsearch

" indentation
set expandtab
set tabstop=3
set shiftwidth=3
autocmd FileType python :set expandtab tabstop=3 shiftwidth=3

" backspace
set backspace=indent,eol,start

" " page up/down for side window
" noremap <Leader>e <C-w>p<C-u><C-w>p
" noremap <Leader>d <C-w>p<C-d><C-w>p

" ctags file
set tags=tags,~/.tags/tags,~/cvp/tags

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" set clipboard=unnamed

" persistent undo history
silent !mkdir /tmp/.vim_backup > /dev/null 2>&1
set undofile
set undodir=/tmp/.vim_backup

" " make // to search visual hightlighted content
" vnoremap <expr> // 'y/\V'.escape(@",'\').'<CR>'

" restore cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" " toggle paste mode automatically when paste
" let &t_SI .= "\<Esc>[?2004h"
" let &t_EI .= "\<Esc>[?2004l"
" inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
" function! XTermPasteBegin()
"   set pastetoggle=<Esc>[201~
"   set paste
"   return ""
" endfunction

"       ------------end of general vim settings-------------

"       -------------plugin vim settings--------------------

" ctrlp settings
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|pyc)$'

" vim-airline theme
let g:airline_theme="wombat"

" youcompleteme settings
let g:ycm_complete_in_comments=1
set completeopt-=preview
let g:enable_numbers = 0

" ConqueTerm settings
let g:ConqueTerm_CWInsert = 1
let g:ConqueTerm_InsertOnEnter = 1
nmap :cv :ConqueTermVSplit bash

" shortcut for NERDTree
nmap :nt :NERDTree

" shortcut for TagbarToggle
nmap :tt :TagbarToggle

" shortcut for Undotree
nmap :undo :UndotreeToggle<CR>:UndotreeFocus<CR>

" turn off trailing whitespace detection
autocmd VimEnter * AirlineToggleWhitespace

" easymotion settings
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" vim-latex-live-preview settings
let g:livepreview_previewer = 'open -a Preview'
autocmd Filetype tex setl updatetime=5000
let g:which_bibliography = 'biber'
"let g:which_bibliography = 'bibtex'

" vim-latex settings
let g:Tex_CompileRule_pdf = 'pdflatex $*'
let g:Imap_UsePlaceHolders = 0

" Rainbow Paranthesis
let g:rainbow_active = 1
" au VimEnter * RainbowParenthesesToggle
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces

" Syntastic
let g:syntastic_mode_map = {
            \ "mode": "passive",
	\ "active_filetypes": [],
	\ "passive_filetypes": [] }
	"
" indent-guides
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=237
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup =1
let g:indent_guides_soft_pattern = ' '

"delimitMate
let delimitMate_balance_matchpairs = 1

" tagbar
let g:tagbar_width = 17
let g:tagbar_indent = 0

" vim-go
let g:go_version_warning = 0

" copy to clipboard no matter where you are
noremap <leader>y :Oscyank<cr>
nmap yy yy:OscyankRegister<cr>
nmap dd dd:OscyankRegister<cr>
vmap y y:OscyankRegister<cr>
vmap d d:OscyankRegister<cr>

" camelcasemotion
call camelcasemotion#CreateMotionMappings('<leader>')

"       -------------end of plugin vim settings--------------

"        ------------end of my customized settings---------------------
