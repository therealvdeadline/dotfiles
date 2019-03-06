set encoding=utf-8
scriptencoding utf-8

if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config//nvim/autoload/plug.vim --create-dirs
           \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    augroup PLUG
        au!
        autocmd VimEnter * PlugInstall
    augroup END
endif

call plug#begin('~/.config/nvim/plugged')

Plug '~/projects/wal.vim'
Plug '~/projects/fff.vim'
Plug 'junegunn/goyo.vim'
    augroup Goyo
        autocmd!
        autocmd BufReadPost * Goyo 82x80%
        autocmd BufReadPost *.md Goyo 76x80%
        autocmd BufReadPost neofetch Goyo 102x80%
        autocmd VimResized * execute "normal \<C-W>="
    augroup END

Plug 'terryma/vim-multiple-cursors'
    let g:multi_cursor_use_default_mapping=0
    let g:multi_cursor_next_key='<C-j>'
    let g:multi_cursor_prev_key='<C-k>'
    let g:multi_cursor_skip_key='<C-s>'
    let g:multi_cursor_quit_key='<Esc>'

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'terryma/vim-expand-region'
	vmap v <Plug>(expand_region_expand)
	vmap <C-v> <Plug>(expand_region_shrink)

Plug 'mzlogin/vim-markdown-toc'
Plug 'rstacruz/vim-closer'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
	nmap ss ysiw
	nmap sl yss
	vmap s S

Plug 'machakann/vim-highlightedyank'
    let g:highlightedyank_highlight_duration = 200

call plug#end()
filetype plugin on

colorscheme wal

noremap ; :
cnoreabbrev q qa
xnoremap p pgvy
cmap w!! w !sudo tee % >/dev/null
vmap <TAB> >gv
vmap <BS> <gv
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap H 0
vnoremap H 0
vnoremap L $
nnoremap L A
nmap az za
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>

set signcolumn=yes
set noshowmode
set laststatus=0
set shortmess=atI
set cmdheight=1
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_
set breakindent
set tabstop=4
set shiftwidth=4
set expandtab
set re=1
set foldmethod=marker
set foldlevel=99
set foldlevelstart=0
set hlsearch
set incsearch
set ignorecase
set smartcase
set undofile
set undolevels=1000
set undoreload=1000
set autochdir
set clipboard=unnamedplus
set nostartofline
set notimeout
set nottimeout
set nrformats-=octal
set modeline
set backspace=indent,eol,start
set noswapfile
set backupdir=~/.config/nvim/tmp/backups/
set undodir=~/.config/nvim/tmp/undo/

if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), 'p')
endif

if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), 'p')
endif

augroup General
    au!
    autocmd FileType markdown,text setlocal spell
    autocmd FileType * setlocal formatoptions-=cro
    autocmd BufWritePre [:;]* throw 'Forbidden file name: ' . expand('<afile>')
	autocmd BufWritePre * :%s/\s\+$//e
    autocmd FileType xdefaults setlocal commentstring=!\ %s
    autocmd FileType scss,css setlocal commentstring=/*%s*/ shiftwidth=2 softtabstop=2
augroup END

