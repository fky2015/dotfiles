"""
" For a minimal vimrc.
"""

" Enable folding
" set foldmethod=indent
" set foldlevel=99

" You want Vim, not vi. When Vim finds a vimrc, 'nocompatible' is set anyway.
" We set it explicitely to make our position clear!
set nocompatible

filetype plugin indent on  " Load plugins according to detected filetype.
syntax on                  " Enable syntax highlighting.

set nu
colorscheme default
set background=dark

set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =2         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

set backspace   =2 " Make backspace work as you would expect.

set hidden                 " Switch between buffers without having to save first.

"set laststatus  =2         " Always show statusline.

"set display     =lastline  " Show as much as possible of the last line.

set showmode               " Show current mode in command-line.

"set showcmd                " Show already typed keys when more are expected.
" conflict with snippet

set incsearch              " Highlight while searching with / or ?.
set hlsearch               " Keep matches highlighted.

set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

set cursorline             " Find the current line quickly.
set wrapscan               " Searches wrap around end-of-file.
set report      =0         " Always report changed lines.
set synmaxcol   =200       " Only highlight the first 200 columns.
set mouse+=a
set clipboard+=unnamed
"set list                   " Show non-printable characters.


if empty($XDG_CACHE_HOME)
    let $XDG_CACHE_HOME=$HOME."/.cache"
endif

" Put all temporary files under the same directory.
" https://github.com/mhinz/vim-galore#handling-backup-swap-undo-and-viminfo-files
if !isdirectory($XDG_CACHE_HOME . "/vim/files/backup") && exists('*mkdir')
  call mkdir($XDG_CACHE_HOME . "/vim/files/backup", "p")
endif

if !isdirectory($XDG_CACHE_HOME . "/vim/files/swap") && exists('*mkdir')
  call mkdir($XDG_CACHE_HOME . "/vim/files/swap", "p")
endif

if !isdirectory($XDG_CACHE_HOME . "/vim/files/undo") && exists('*mkdir')
  call mkdir($XDG_CACHE_HOME . "/vim/files/undo", "p")
endif

set backup
set backupdir   =$XDG_CACHE_HOME/vim/files/backup
set backupext   =-vimbackup
set backupskip  =
set directory   =$XDG_CACHE_HOME/vim/files/swap
set updatecount =100
set undofile
set undodir     =$XDG_CACHE_HOME/vim/files/undo
set viminfo+=n$XDG_CACHE_HOME/vim/viminfo

nnoremap ; :
xnoremap ; :

" For motion: `f`
nnoremap : ;
xnoremap : ;

" Quicker way to open command window
nnoremap q; q:

" Quicker <Esc> in insert mode
inoremap <silent> jk <Esc>

if v:version > 803
  tnoremap jk <c-\><c-n>
endif


" Quick Copy
vnoremap <C-C> "+y


" zoom
function! Zoom ()
    " check if is the zoomed state (tabnumber > 1 && window == 1)
    if tabpagenr('$') > 1 && tabpagewinnr(tabpagenr(), '$') == 1
        let l:cur_winview = winsaveview()
        let l:cur_bufname = bufname('')
        tabclose

        " restore the view
        if l:cur_bufname == bufname('')
            call winrestview(cur_winview)
        endif
    else
        tab split
    endif
endfunction

nnoremap <leader>z :call Zoom()<CR>

" File Explore
noremap <F2> :Sexplore<CR>
