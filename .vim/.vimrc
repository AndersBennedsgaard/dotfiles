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

function! ShowFlake8Quickfix()
    let g:flake8_show_quickfix=1
    call flake8#Flake8()
    let g:flake8_show_quickfix=0
endfunction

augroup remember_folds
    autocmd!
    autocmd BufWinLeave ?* mkview
    autocmd BufWinEnter ?* silent! loadview
augroup END

autocmd BufWinLeave * let b:winview = winsaveview()
autocmd BufWinEnter * if exists('b:winview') | call winrestview(b:winview) | unlet b:winview

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

set foldmethod=syntax
set foldcolumn=4
set foldlevelstart=1
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
Plug 'nvie/vim-flake8'
" LaTeX implementations
Plug 'lervag/vimtex'
" Live preview of latex .pdf's
"Plug 'xuhdev/vim-latex-live-live-preview', { 'for': 'tex' }
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

" vim-flake8 settings
let g:flake8_show_in_gutter=1
let g:flake8_quickfix_location="topleft"
let g:flake8_show_quickfix=0
autocmd FileType python map <buffer> <F6> :call flake8#Flake8()<CR>
autocmd BufWritePost *.py :call flake8#Flake8()
command Quickfix :call ShowFlake8Quickfix()

" FastFold settings
let g:fastfold_savehook = 1

" vim-latex-live-preview settings
"autocmd Filetype tex setl updatetime=1 " suggested updatetime=1000
"let g:livepreview_previewer = 'open -a Preview' " set the .pdf preview-software. Here 'Preview' is used
" " command LatexPreview :call LLPStartPreview
" If you do not want recompilation on cursor hold but only when written on disk:
" "let g:livepreview_cursorhold_recompile=0

" Call LLPStartPreview <root-file> if editing other file that root (main?)

" " To install new plugins, add the Plug-command.
" "   Restart Vim, and run :PlugInstall
" " To update plugins, run :PlugUpdate.
" "   To see changes, run D or :PlugDiff.
" "   To rollback an update, select the plugin and press X
" " To remove plugings, remove/comment out the Plug-command.
" "   Restart Vim, and run :PlugClean

