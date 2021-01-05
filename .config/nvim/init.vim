
" vim-plug ---------------------------- {{{
call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'

Plug 'markonm/traces.vim'

Plug 'ThePrimeagen/vim-apm'

Plug 'rafcamlet/nvim-luapad'

Plug 'camspiers/animate.vim'

" highlighting word under cursor and all of its occurrences.
Plug 'dominikduda/vim_current_word'

" color scheme
Plug 'sainnhe/edge'
Plug 'morhetz/gruvbox'
Plug 'Iron-E/nvim-highlite'
Plug 'kyazdani42/blue-moon'
Plug 'christianchiarulli/nvcode-color-schemes.vim'
" ----- end -----

Plug 'jdhao/better-escape.vim'

Plug 'psliwka/vim-smoothie'

Plug 'itchyny/calendar.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" <leader><leader>w
Plug 'easymotion/vim-easymotion'

" adds various text objects to give you more targets to operate on
Plug 'wellle/targets.vim'

Plug 'scrooloose/nerdcommenter'
" Plug 'sbdchd/neoformat'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'

Plug 'terryma/vim-multiple-cursors'

Plug 'vim-scripts/fcitx.vim'

" `gS` and `gJ` to switching between a single-line statement and a multi-line one.
Plug 'AndrewRadev/splitjoin.vim'

Plug 'junegunn/vim-easy-align'

" Plug 'yianwillis/vimcdoc'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'marshallward/vim-restructuredtext'

Plug 'tpope/vim-surround'

Plug 'solarnz/thrift.vim'
Plug 'liuchengxu/vista.vim' 

Plug 'tomlion/vim-solidity'
Plug 'tpope/vim-repeat'

Plug 'liuchengxu/graphviz.vim'

Plug 'liuchengxu/vim-which-key'

" the fancy start screen for vim
Plug 'mhinz/vim-startify'

" Emmet Support
Plug 'mattn/emmet-vim'

Plug 'easymotion/vim-easymotion'

" Git support
Plug 'tpope/vim-fugitive'
Plug 'ttys3/nvim-blamer.lua'

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

" Goyo + limelight + vim-colors-pencil = iawriter
"Plug 'junegunn/goyo.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'reedes/vim-colors-pencil'
Plug 'subnut/vim-iawriter'

" vimtex
Plug 'lervag/vimtex'

Plug 'ap/vim-css-color'

" grammar check
Plug 'rhysd/vim-grammarous'

" helpful.vim
Plug 'tweekmonster/helpful.vim'

" my test plug

" Plug '~/playground/potion'
"Plug '~/code/git/mine/cloud-ladder.vim'

call plug#end()
" }}}

" Tree Sitter ------------------------------------- {{{
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = { enable = true },
  incremental_selection = { enable = true,
      keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },    
  },
  textobjects = { enable = true },
}
EOF
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
" ------------------------------------------------- }}}


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


autocmd FileType go setlocal nosmarttab shiftwidth=0 softtabstop=0 noexpandtab tabstop=8

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

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

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

" For motion: `f`
nnoremap ' ;

" Quicker way to open command window
nnoremap q; q:

" Quicker <Esc> in insert mode
inoremap <silent> jk <Esc>

tnoremap jk <c-\><c-n>

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

set background=dark
colorscheme edge

" }}} ------------------------------

" vim-plug ---- {{{
nnoremap <leader><S-P><s-i> :PlugInstall<CR>
nnoremap <leader><S-P><s-u> :PlugUpdate<CR>
" }}}


" fzf.vim ----------------------------------- {{{
set rtp+=/usr/bin/fzf
nmap <leader>f :Files<CR>
let spec = {'options': '--delimiter : --nth 4..'}
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview(spec) , <bang>0)
nnoremap <leader>t :Rg<CR>

" Mapping selecting mappings
nnoremap <leader><tab> <plug>(fzf-maps-n)

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
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction


" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
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
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

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

" animate.vim -------------------------------------------- {{{
nnoremap <silent> <Up>    :call animate#window_delta_height(10)<CR>
nnoremap <silent> <Down>  :call animate#window_delta_height(-10)<CR>
nnoremap <silent> <Left>  :call animate#window_delta_width(10)<CR>
nnoremap <silent> <Right> :call animate#window_delta_width(-10)<CR>
" }}}


" ===============================================================
" playground for 'learn vim script the hard way'
" ===============================================================

" echo 'welcome back! >^.^<'


" force to learn new key binding
inoremap <esc> <nop>

augroup filetype_dot
    autocmd!
    autocmd FileType dot nnoremap <buffer> <localleader>r :GraphvizCompile \| Graphviz<cr>
augroup END

augroup filetype_markdown
    autocmd!
    autocmd FileType markdown onoremap ih :<c-u>execute "normal! ?^[=-]\\{2,}$\r:nohlsearch\rkvg_"<cr>
    autocmd FileType markdown onoremap ah :<c-u>execute "normal! ?^\\(==\\+\\\\|--\\+\\)$\r:nohlsearch\rg_vk0"<cr>
augroup END

augroup RstFold
  autocmd TextChanged,InsertLeave <buffer> unlet! b:RstFoldCache
augroup END

nnoremap <leader>ca ggvG"+Y<c-o>

noremap <leader>tw :setlocal wrap!<cr>



" Vimscript file settings ------------------------{{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" inoremap <c-u> <esc>viwUi
" nnoremap <c-u> viwU
