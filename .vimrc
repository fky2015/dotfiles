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

""""
" Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
" Use of this source code is governed by a BSD-style license that can be
" found in the LICENSE file.

if exists("g:loaded_vim_osc52") || &cp || v:version < 800
  finish
endif
let g:loaded_vim_osc52 = 1

" Max length of the OSC 52 sequence.  Sequences longer than this will not be
" sent to the terminal.
let g:max_osc52_sequence=100000

" Send a string to the terminal's clipboard using the OSC 52 sequence.
function! s:sendViaOSC52(str)
  " tmux with set-clipboard=on understands raw OSC 52 from applications and
  " forwards it to the outer terminal.  Wrapping it in DCS passthrough is blocked
  " by newer tmux when allow-passthrough is off, so prefer raw OSC 52 there.
  if !empty($TMUX) && s:tmux_handles_OSC52()
    let osc52 = s:get_OSC52(a:str)
  elseif !empty($TMUX)
    let osc52 = s:get_OSC52_tmux(a:str)
  elseif match($TERM, 'screen') > -1
    let osc52 = s:get_OSC52_DCS(a:str)
  else
    let osc52 = s:get_OSC52(a:str)
  endif
  let len = strlen(osc52)
  if len < g:max_osc52_sequence
    call s:writefile(osc52)
  else
    echo "Selection too long to send to terminal: " . len
  endif
endfunction

function! s:tmux_handles_OSC52()
  if !executable('tmux')
    return 0
  endif

  let l:set_clipboard = system('tmux show-options -gqv set-clipboard')
  return v:shell_error == 0 && l:set_clipboard =~# '^\%(on\|external\)'
endfunction

" This function base64's the entire string and wraps it in a single OSC52.
"
" It's appropriate when running in a raw terminal that supports OSC 52.
function! s:get_OSC52(str)
  let b64 = s:b64encode(a:str, 0)
  let rv = "\e]52;c;" . b64 . "\x07"
  return rv
endfunction

" This function base64's the entire string and wraps it in a single OSC52 for
" tmux.
"
" This is for `tmux` sessions which filters OSC 52 locally.
function! s:get_OSC52_tmux(str)
  let b64 = s:b64encode(a:str, 0)
  let rv = "\ePtmux;\e\e]52;c;" . b64 . "\x07\e\\"
  return rv
endfunction

" This function base64's the entire source, wraps it in a single OSC52, and then
" breaks the result in small chunks which are each wrapped in a DCS sequence.
"
" This is appropriate when running on `screen`.  Screen doesn't support OSC 52,
" but will pass the contents of a DCS sequence to the outer terminal unmolested.
" It imposes a small max length to DCS sequences, so we send in chunks.
function! s:get_OSC52_DCS(str)
  let b64 = s:b64encode(a:str, 76)
  " Remove the trailing newline.
  let b64 = substitute(b64, '\n*$', '', '')
  " Replace each newline with an <end-dcs><start-dcs> pair.
  let b64 = substitute(b64, '\n', "\e/\eP", "g")
  " (except end-of-dcs is "ESC \", begin is "ESC P", and I can't figure out
  "  how to express "ESC \ ESC P" in a single string.  So, the first substitute
  "  uses "ESC / ESC P", and the second one swaps out the "/".  It seems like
  "  there should be a better way.)
  let b64 = substitute(b64, '/', '\', 'g')
  " Now wrap the whole thing in <start-dcs><start-osc52>...<end-osc52><end-dcs>.
  let b64 = "\eP\e]52;c;" . b64 . "\x07\e\x5c"
  return b64
endfunction

" Lookup table for s:b64encode.
let s:b64_table = [
      \ "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P",
      \ "Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f",
      \ "g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v",
      \ "w","x","y","z","0","1","2","3","4","5","6","7","8","9","+","/"]

" Encode a string of bytes in base 64.
" Based on http://vim-soko.googlecode.com/svn-history/r405/trunk/vimfiles/
" autoload/base64.vim
" If size is > 0 the output will be line wrapped every `size` chars.
function! s:b64encode(str, size)
  let bytes = s:str2bytes(a:str)
  let b64 = []
  for i in range(0, len(bytes) - 1, 3)
    let n = bytes[i] * 0x10000
          \ + get(bytes, i + 1, 0) * 0x100
          \ + get(bytes, i + 2, 0)
    call add(b64, s:b64_table[n / 0x40000])
    call add(b64, s:b64_table[n / 0x1000 % 0x40])
    call add(b64, s:b64_table[n / 0x40 % 0x40])
    call add(b64, s:b64_table[n % 0x40])
  endfor
  if len(bytes) % 3 == 1
    let b64[-1] = '='
    let b64[-2] = '='
  endif
  if len(bytes) % 3 == 2
    let b64[-1] = '='
  endif
  let b64 = join(b64, '')
  if a:size <= 0
    return b64
  endif
  let chunked = ''
  while strlen(b64) > 0
    let chunked .= strpart(b64, 0, a:size) . "\n"
    let b64 = strpart(b64, a:size)
  endwhile
  return chunked
endfunction

function! s:str2bytes(str)
  return map(range(len(a:str)), 'char2nr(a:str[v:val])')
endfunction

" Send yanked text to terminal
" Fix terminal flash from old echo function, use `fd/2` for portability
function! s:writefile(str)
  call writefile([a:str], '/dev/fd/2','Sb') " no fsync & binary
  redraw!
endfunction

" Use <Plug> to call local function so we don't polute global functions
vnoremap <silent> <unique> <Plug>(YankOSC52) y:<c-u>call <SID>sendViaOSC52(getreg('"'))<cr>
""""

" Quick Copy
vmap <C-c> <Plug>(YankOSC52)
nnoremap <C-C> V<Plug>(YankOSC52)

" Quicker way to open command window
nnoremap q; q:

" Quicker <Esc> in insert mode
inoremap <silent> jk <Esc>

if v:version > 803
  tnoremap jk <c-\><c-n>
endif

" zoom
function! Zoom ()
    " check if is the zoomed state (tabnumber > 1 && window == 1)
        let l:cur_winview = winsaveview()
        if tabpagenr('$') > 1 && tabpagewinnr(tabpagenr(), '$') == 1
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
