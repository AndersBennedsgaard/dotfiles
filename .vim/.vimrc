function! NeatFoldText()
    let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
    let foldchar = matchstr(&fillchars, 'fold:\zs.')
    let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
    let foldtextend = lines_count_text . repeat(foldchar, 8)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction

function! SyntasticToggle()
    if empty(filter(tabpagebuflist(), 'getbufvar(v:val, "&buftype") is# "quickfix"'))
        lopen
    else
        lclose
    endif
endfunction

function! Replace() range
    execute a:firstline . "," . a:lastline . 's/some pattern/something else/'
endfunction

"augroup remember_folds
"    autocmd!
"    autocmd BufWinLeave ?* mkview
"    autocmd BufWinEnter ?* silent! loadview
"augroup END

"autocmd BufWinLeave * let b:winview = winsaveview()
"autocmd BufWinEnter * if exists('b:winview') | call winrestview(b:winview) | unlet b:winview
" removes indentlines

source ~/.vim/plugged/restore_view.vim

set nocompatible
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set encoding=utf-8

syntax on
filetype off
set showmatch
set ruler
set number
set mouse=a
set confirm
set autowrite
set mousemodel=popup
set scrolloff=3

set foldmethod=syntax
set foldcolumn=4
"set foldlevelstart=1
set viewoptions=cursor,folds,slash,unix

set foldtext=NeatFoldText()

set hidden 
" " Hides files in background instead of closing
"set clipboard=unnamed
" Perhaps allows the clipboard outside of Vim to be used

set history=1000
set noerrorbells

set nobackup
set nowritebackup
set noswapfile

set t_Co=256
set term=screen-256color
set updatetime=1000

nmap <F5> :w<CR>:!clear;python %<CR>
imap <F5> <Esc>:w<CR>:!clear;python %<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

nnoremap <Space> za
vnoremap <Space> za

" :help map-modes
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

call plug#begin('~/.vim/plugged')
" Auto pairing brackets
Plug 'jiangmiao/auto-pairs'
" Git information in the gutter
Plug 'airblade/vim-gitgutter'
" Better Vim autocomplete
Plug 'ajh17/VimCompletesMe'
" Highlight current word in normal mode
Plug 'dominikduda/vim_current_word', { 'branch': 'development' }
" Colorscheme gruvbox
Plug 'morhetz/gruvbox'
" Show the amount of indents with lines
Plug 'Yggdroot/indentLine'
" Python folding
Plug 'tmhedberg/SimpylFold'
" Vim's folding is extremely slow by default - this fixes it
Plug 'Konfekt/FastFold'
" Light-weight status bar at the bottom of the screen
Plug 'vim-airline/vim-airline'
" Show flake8(PEP8 rules) when editing .py-files with vim
"Plug 'nvie/vim-flake8'
" LaTeX implementations
Plug 'lervag/vimtex'
" Better tmux and vim combability
Plug 'tmux-plugins/vim-tmux-focus-events'
" For remembering stuff in Tmux restorations
"Plug 'tpope/vim-obsession'
Plug 'vim-syntastic/syntastic'
Plug 'tmux-plugins/vim-tmux-focus-events'
call plug#end()
filetype plugin indent on

" gruvbox and colorscheme settings
if has('gui_running')
    set background=dark
    colorscheme gruvbox
else
    set background=dark
    colorscheme gruvbox
endif
set fillchars+=vert:\ 
let g:gruvbox_bold=1
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_improved_strings=1

" vim_current_word settings
let g:vim_current_word#highlight_twins=1
let g:vim_current_word#highlight_current_word=1
let g:vim_current_word#highlight_only_in_focused_window = 0
let g:vim_current_word#disabled_by_insert_mode = 0
"let g:vim_current_word#highlight_delay=0
hi CurrentWord ctermbg=53
hi CurrentWordTwins ctermbg=239

" indentline settings
let g:indentLine_char = '|'

" vim-airline settings
let g:airline#extensions#tabline#enabled=1

" SimpylFold settings
let g:SimpylFold_docstring_preview=1

" FastFold settings
let g:fastfold_savehook = 1

" Syntastic setting
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_jump = 0
let g:syntastic_sh_checkers = ['bashate']

hi SpellBad term=reverse ctermbg=darkgreen

map <F8> <ESC>:call SyntasticToggle()<CR> 

" " To install new plugins, add the Plug-command.
" "   Restart Vim, and run :PlugInstall
" " To update plugins, run :PlugUpdate.
" "   To see changes, run D or :PlugDiff.
" "   To rollback an update, select the plugin and press X
" " To remove plugings, remove/comment out the Plug-command.
" "   Restart Vim, and run :PlugClean

