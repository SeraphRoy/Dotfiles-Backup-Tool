" Include the system settings
if filereadable( "/etc/vimrc" )
  source /etc/vimrc
endif
" Include Arista-specific settings
if filereadable( "/usr/share/vim/vimfiles/arista.vim" )
source /usr/share/vim/vimfiles/arista.vim
endif

" download vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug begin
call plug#begin('~/.vim/bundle')

Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'nelstrom/vim-visual-star-search'
Plug 'vim-latex/vim-latex'
Plug 'rust-lang/rust.vim'
" Plug 'w0rp/ale'
Plug 'yggdroot/indentline'
Plug 'altercation/vim-colors-solarized'
Plug 'godlygeek/tabular'
Plug 'terryma/vim-multiple-cursors'
Plug 'sickill/vim-pasta'
Plug 'luochen1990/rainbow'
Plug 'mbbill/undotree'
Plug 'bling/vim-airline'
Plug 'flazz/vim-colorschemes'
Plug 'raimondi/delimitmate'
Plug 'xuhdev/vim-latex-live-preview'
Plug 'vim-airline/vim-airline-themes'
Plug 'oplatek/conque-shell'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'skywind3000/asyncrun.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'easymotion/vim-easymotion'
Plug 'bkad/camelcasemotion'
Plug 'terryma/vim-expand-region'
" Plug 'neomake/neomake'
if has('patch1578')
   Plug 'Yggdroot/LeaderF'
   Plug 'w0rp/ale'
   Plug 'ludovicchabant/vim-gutentags'
   Plug 'fatih/vim-go'
   Plug 'Valloric/YouCompleteMe'
endif
Plug 'greymd/oscyank.vim'
Plug 'mhinz/vim-signify'
" Plugin 'airblade/vim-gitgutter'
" Plugin 'roxma/vim-paste-easy'
" " All of your Plugins must be added before the following line
call plug#end()
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
let mapleader=" "

" Syntax Highlight
syntax on

" 256 color
let &t_Co=256

" color scheme/theme
syntax enable
set background=dark
colorscheme solarized


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
nmap oo :normal o<CR>k
nmap OO :normal O<CR>

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
set tags=./.tags;,.tags

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

" Configure ALT key for vim
function! Terminal_MetaMode(mode)
    set ttimeout
    if $TMUX != ''
        set ttimeoutlen=30
    elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
        set ttimeoutlen=50
    endif
    if has('nvim') || has('gui_running')
        return
    endif
    function! s:metacode(mode, key)
        if a:mode == 0
            exec "set <M-".a:key.">=\e".a:key
        else
            exec "set <M-".a:key.">=\e]{0}".a:key."~"
        endif
    endfunc
    for i in range(10)
        call s:metacode(a:mode, nr2char(char2nr('0') + i))
    endfor
    for i in range(26)
        call s:metacode(a:mode, nr2char(char2nr('a') + i))
        call s:metacode(a:mode, nr2char(char2nr('A') + i))
    endfor
    if a:mode != 0
        for c in [',', '.', '/', ';', '[', ']', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    else
        for c in [',', '.', '/', ';', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    endif
endfunc

call Terminal_MetaMode(0) 

" hightlight current line only in normal mode
set cursorline
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

" map CTRL_HJKL to move cursor in all mode
noremap <C-h> <left>
noremap <C-j> <down>
noremap <C-k> <up>
noremap <C-l> <right>
inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>

" insert mode as emacs
inoremap <c-a> <home>
inoremap <c-e> <end>
inoremap <c-d> <del>


" faster command mode
cnoremap <c-h> <left>
cnoremap <c-j> <down>
cnoremap <c-n> <down>
cnoremap <c-k> <up>
cnoremap <c-p> <up>
cnoremap <c-l> <right>
cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <c-d> <del>

" terminal
nmap :term<CR> :term<CR><C-w>J

"       ------------end of general vim settings-------------

"       -------------plugin vim settings--------------------

" LeaderF settings
let g:Lf_ShortcutF = '<C-P>'
let g:Lf_WindowHeight = 0.13
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
nmap <M-p> :LeaderfFunction!<CR>

" auto pair
let g:AutoPairsShortcutToggle = ''

" vim-airline theme
let g:airline_theme="wombat"

" youcompleteme settings
let g:ycm_complete_in_comments=1
set completeopt-=preview
let g:enable_numbers = 0
let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }

" deoplete
let g:deoplete#enable_at_startup = 1

" ConqueTerm settings
let g:ConqueTerm_CWInsert = 1
let g:ConqueTerm_InsertOnEnter = 1
nmap :cv :ConqueTermVSplit bash

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

" indent-guides
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=237
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup =1
let g:indent_guides_soft_pattern = ' '

"delimitMate
let delimitMate_balance_matchpairs = 1

" copy to clipboard no matter where you are
noremap <leader>y :Oscyank<cr>
nmap yy yy:OscyankRegister<cr>
nmap dd dd:OscyankRegister<cr>
vmap y y:OscyankRegister<cr>
vmap d d:OscyankRegister<cr>

" copy to clipboard no matter where you are
" nnoremap <leader>y :call system('nc localhost 9999', @0)<CR>
" nmap yy yy<leader>y
" nmap dd dd<leader>y
" vmap y y<leader>y
" vmap d d<leader>y

" camelcasemotion
call camelcasemotion#CreateMotionMappings('<leader>')

" vim-signify
nmap - <plug>(signify-prev-hunk)
nmap = <plug>(signify-next-hunk)
let g:signify_vcs_cmds = {
  \ 'git':      'git diff --no-color --no-ext-diff -U0 -- %f',
  \ 'perforce': 'a4 info '. sy#util#shell_redirect('%n') .' && env P4DIFF=%d a4 diff -du 0 %f'
  \ }
nmap :diff :SignifyDiff
let g:signify_vcs_cmds_diffmode = {
  \ 'git':      'git show HEAD:./%f',
  \ 'hg':       'hg cat %f',
  \ 'svn':      'svn cat %f',
  \ 'bzr':      'bzr cat %f',
  \ 'darcs':    'darcs show contents -- %f',
  \ 'cvs':      'cvs up -p -- %f 2>%n',
  \ 'perforce': 'a4 print %f',
  \ }
<

" vim-gutentags
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'
" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
" if executable('gtags-cscope') && executable('gtags')
" 	let g:gutentags_modules += ['gtags_cscope']
" endif
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" 如果使用 universal ctags 需要增加下面一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif
"  禁用 gutentags 自动加载 gtags 数据库的行为
"let g:gutentags_auto_add_gtags_cscope = 0
"let $GTAGSLABEL = 'native-pygments'
"let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'

" asyncrun.vim
let g:asyncrun_status = ''
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])
let g:asyncrun_open = 8
let g:asyncrun_bell = 1
function! s:RunMe()
   if &filetype == "vim"
      exec 'source %'
   elseif &filetype == "python"
      exec 'AsyncRun python %'
   elseif &filetype == "go"
      exec 'AsyncRun go run %'
   endif
endfunc
function! s:TestMe()
   if &filetype == "vim"
      exec 'source %'
   elseif &filetype == "python"
      exec 'AsyncRun python %'
   elseif &filetype == "go"
      exec 'AsyncRun go test %'
   endif
endfunc
command! VimRun call s:RunMe()
command! VimTest call s:TestMe()
nmap <M-r> :VimRun<cr>
nmap <M-t> :VimTest<cr>
nmap :Run :AsyncRun
nmap :Stop :AsyncStop

" Neomake
" call neomake#configure#automake('nrwi')
" let g:neomake_open_list = 2

" ALE
let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {
         \ 'python': ['pylint'],
\ }

"       -------------end of plugin vim settings--------------

"        ------------end of my customized settings---------------------
