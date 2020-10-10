
" vim-plug ---------------------------- {{{
call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'

Plug 'itchyny/calendar.vim'

" adds various text objects to give you more targets to operate on
Plug 'wellle/targets.vim'

Plug 'scrooloose/nerdcommenter'
" Plug 'sbdchd/neoformat'
Plug 'scrooloose/nerdtree'

Plug 'terryma/vim-multiple-cursors'

Plug 'vim-scripts/fcitx.vim'

Plug 'junegunn/vim-easy-align'

" Plug 'yianwillis/vimcdoc'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'marshallward/vim-restructuredtext'

Plug 'tpope/vim-surround'

Plug 'tomlion/vim-solidity'

Plug 'liuchengxu/graphviz.vim'

Plug 'liuchengxu/vim-which-key'

" the fancy start screen for vim
Plug 'mhinz/vim-startify'

" Emmet Support
Plug 'mattn/emmet-vim'

" Git support
Plug 'tpope/vim-fugitive'

" Snippets
Plug 'honza/vim-snippets'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

" antlr syntax highlight
Plug 'dylon/vim-antlr'

" .tsx syntax highlight
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

Plug 'vimwiki/vimwiki'

" https://wakatime.com
Plug 'wakatime/vim-wakatime'

" Goyo
Plug 'junegunn/goyo.vim'

" vimtex
Plug 'lervag/vimtex'

Plug 'ap/vim-css-color'

" my test plug

" Plug '~/playground/potion'
"Plug '~/code/git/mine/cloud-ladder.vim'

call plug#end()
" }}}
" Basic configuration ----------------------------- {{{

:hi CocFloating ctermfg=231 ctermbg=23 guifg=#ffffff guibg=#1f7ad8
" Load plugins based on file type
filetype plugin on
" Enable syntax highlighting
syntax on
" Load indent settings based on file type
filetype indent on 
" number of spaces to use for indenting
set shiftwidth=2
" number of spaces to use when inserting a tab
set softtabstop=2
" convert tabs to spaces
set expandtab
" copy indent from previous line
set autoindent
" Don't wrap long lines
" set nowrap
" Show cursor line and column in status
set ruler
" Show current command in status line
set showcmd

set splitright
set splitbelow

" if hidden is not set, TestEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" relative line number
set number
set relativenumber

" mouse support

set mouse=a

set timeoutlen=500

" our <leader> will be the space key
let mapleader=" "

" our <localleader> will be the '-' key
let maplocalleader="-"

" Custom key mappings
" Save key strokes (now we do not need to press shift to enter command mode).
" Vim-sneak has also mapped `;`, so using the below mapping will break the map
" used by vim-sneak
nnoremap ; :
xnoremap ; :

" Quicker way to open command window
nnoremap q; q:

" Quicker <Esc> in insert mode
inoremap <silent> jk <Esc>

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


" }}} ------------------------------

" fzf.vim ----------------------------------- {{{
set rtp+=/usr/bin/fzf

nmap <leader>f :Files<CR>
nmap <leader>t :Rg<CR>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)


" }}} ---------------------------------------

" airline.vim ------------------------------- {{{
let g:airline_theme='cobalt2'
" }}} ---------------------------------------

" Coc.nvim ------------------------------------- {{{
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif &filetype ==# 'tex'
    " need vimtex to be setup properly
    VimtexDocPackage
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" navigate through float window
nnoremap <expr><C-f> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-f>"
nnoremap <expr><C-b> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-b>"

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <C-d> <Plug>(coc-range-select)
" xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
noremap <C-S-I> :call CocAction('format')<cr>


" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
"unmap <leader>cc
nnoremap <silent> <leader>x  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
" Make <tab> used for trigger completion, completion confirm, snippet expand and jump like VSCode.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? coc#_select_confirm() :
"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" 
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
" 
" let g:coc_snippet_next = '<tab>'
" }}} -------------------------------------------


" NerdTree ------------------------------------ {{{
map <F2> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}} -----------------------------------------


" vim-which-key ----------------------------------- {{{

nnoremap <silent> <leader> :WhichKey '<Space>' <CR>
nnoremap <silent> <localleader> :WhichKey '-' <CR>

" }}} ---------------------------------------------


" vim-wiki -------------------------------------------{{{

let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" }}}



" vimtex -------------------------------------- {{{
"let g:vimtex_compiler_latexmk_engines = 'xelatex'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'zathura'
" let g:vimtex_latexmk_progname = 'nvr'
let g:tex_flavor = 'latex'
" }}} -----------------------------------------

" nerdcommenter ---------------------------------- {{{


" }}} ----------------------------------------------


" ===============================================================
" playground for 'learn vim script the hard way'
" ===============================================================

" echo 'welcome back! >^.^<'

" noremap <leader>w <esc>viw
" edit config
nnoremap <leader>ec :vs $MYVIMRC<cr>:setlocal wrap<cr>
" source config
nnoremap <leader>sc :so $MYVIMRC<cr>

iabbrev ccopy Copyright 2020 Feng Kaiyu, all rights reserved.
iabbrev @@ loveress01@outlook.com

" force to learn new key binding
inoremap <esc> <nop>

augroup filetype_html
    autocmd!
    autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup END

augroup filetype_dot
    autocmd!
    autocmd FileType dot nnoremap <buffer> <localleader>r :GraphvizCompile \| Graphviz<cr>
augroup END

augroup filetype_markdown
    autocmd!
    autocmd FileType markdown onoremap ih :<c-u>execute "normal! ?^[=-]\\{2,}$\r:nohlsearch\rkvg_"<cr>
    autocmd FileType markdown onoremap ah :<c-u>execute "normal! ?^\\(==\\+\\\\|--\\+\\)$\r:nohlsearch\rg_vk0"<cr>
augroup END

"augroup filetype_zot
    "autocmd!
    "autocmd FileType rst setlocal foldmethod=expr
    "autocmd FileType rst setlocal foldexpr=RstFold#GetRstFold()
    "autocmd FileType rst setlocal foldtext=RstFold#GetRstFoldText()
"augroup END

augroup RstFold
  autocmd TextChanged,InsertLeave <buffer> unlet! b:RstFoldCache
augroup END


onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>

onoremap an( :<c-u>normal! f(v%<cr>
onoremap al( :<c-u>normal! F)v%<cr>

onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap il{ :<c-u>normal! F}vi{<cr>

onoremap an{ :<c-u>normal! f{v%<cr>
onoremap al{ :<c-u>normal! F}v%<cr>

nnoremap <leader>ca ggvG"+Y<c-o>

noremap <leader>tw :setlocal wrap!<cr>

noremap <leader>w :match Error /\v\s+$/<cr>
noremap <leader>W :match none<cr>

" nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>


" Vimscript file settings ------------------------{{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" inoremap <c-u> <esc>viwUi
" nnoremap <c-u> viwU
