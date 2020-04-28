filetype off
call plug#begin('~/.nvim/plugged')
" Appearance
Plug 'itchyny/lightline.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'arcticicestudio/nord-vim'
" Utility
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'unblevable/quick-scope'
Plug 'benmills/vimux'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
" Language and ftp
Plug 'neovim/nvim-lsp'
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins', 'for': ['go', 'javascript', 'typescript', 'rust'] }
Plug 'Shougo/deoplete-lsp', {'for': ['go', 'javascript', 'typescript', 'rust']}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }
Plug 'neoclide/coc.nvim', {'branch': 'release', 'for': 'dart'}
" Snippet
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
call plug#end()
filetype on

let mapleader = "," " Set comma as leader key
" Quick close
nmap <leader>w :w<cr>
" Open folder tree
nmap <silent><leader>a :NERDTreeToggle<cr>
nmap <silent><leader>k :NERDTreeCWD<cr>
" Quick open config file
map <silent> <leader>ev :e ~/.config/nvim/init.vim<CR>
" lazy binding
nmap ; :
vmap ; :
nmap <leader>b :b#<cr>
nmap <leader>q :q<cr>
" toggle search highliting
nmap <silent><leader><space> :set invhlsearch<cr>

set nohlsearch " No search highliting at the start
set mouse=a " Set mouse to active
set expandtab " insert spaces rather than tab for <Tab>
set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=4 " the visible width of tabs
set softtabstop=4 " edit as if the tabs are 4 characters wide
set shiftwidth=4 " number of spaces to use for indent and unindent
set shiftround " round indent to a multiple of 'shiftwidth'
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set clipboard+=unnamedplus " Set clipboard to global
set list " set list characters
set listchars=tab:▸\ ,eol:¬ " Display tab and eol char
set hidden " Set hidden
set nobackup " No backup
set noswapfile " No swap file
set nowritebackup " No write backup
set nowrap " Set no word wrapping
set diffopt+=vertical " Set vertical diff window
set completeopt-=preview
set ignorecase " Ignore case sensitivity
set smartcase 
set t_ut=
set foldmethod=manual
set foldlevelstart=2
set norelativenumber
set ttyfast
set lazyredraw
set encoding=UTF-8
set background=dark " Set dark background
colorscheme nord
" Setup statusbar
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" Source local configuration if exist
if filereadable('.local.vim')
    so .local.vim
endif

" scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

"Fast spliting
map <silent> <C-h> :call WinMove('h')<cr>
map <silent> <C-j> :call WinMove('j')<cr>
map <silent> <C-k> :call WinMove('k')<cr>
map <silent> <C-l> :call WinMove('l')<cr>
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

" quick jump
nmap <S-J> 5j
nmap <S-K> 5k
vnoremap <S-J> 5j
vnoremap <S-K> 5k

" Git utility
function! s:changebranch(branch) 
    execute 'Git checkout' . a:branch
endfunction
command! -bang Gbranch call fzf#run({
            \ 'source': 'git branch -a --no-color | grep -v "^\* " ', 
            \ 'sink': function('s:changebranch')
            \ })
nmap <silent> <leader>gs :Gstatus<CR><C-w>100+
nmap <silent> <leader>gc :Gcommit<CR><C-w>6+
nmap <silent> <leader>gw :Gwrite<CR>
nmap <leader>gn :Git checkout -b 
nmap <leader>gp :execute ":Git push origin " . fugitive#head(0)<CR>
nmap <leader>gb :Gbranch<cr>

" Quick indent
vnoremap > >gv
vnoremap < <LT>gv

" VIMUXX
function! RunFile()
    let fname = @%
    if (&filetype == 'rust')
        let command =  " clear && cargo run"
    elseif (&filetype == 'scala')
        let command =  "scala "
    elseif (&filetype == 'javascript')
        let command =  " node "
    elseif (&filetype == 'javascript.jsx')
        let command =  " node "
    elseif (&filetype == 'go')
        let command =  " clear && go build -o engine && ./engine"
    elseif (&filetype == 'html')
        let command =  "open "
    endif
    call VimuxRunCommand(command)
endfunction
map <leader><cr> :call RunFile()<cr>

" FZF 
let $FZF_DEFAULT_COMMAND= 'rg --files --hidden --smart-case'
let $FZF_DEFAULT_OPTS='--color fg:188,bg:0,hl:103,fg+:222,bg+:0,hl+:104 --color info:183,prompt:110,spinner:107,pointer:167,marker:215'
nmap <C-P> :FZF<CR>
nnoremap <silent> \ :Buffers<CR>

" Fix terminal in tmux
let &t_8f = "[38;2;%lu;%lu;%lum"
let &t_8b = "[48;2;%lu;%lu;%lum"

" Set to true colors
if has('termguicolors')
  set termguicolors " True colors
else
  set t_Co=256
endif

" I don't know
hi VertSplit ctermbg=none ctermfg=243 guibg=none
hi Search ctermbg=NONE ctermfg=NONE guifg=NONE guibg=NONE gui=reverse cterm=reverse
hi IncSearch ctermbg=NONE ctermfg=NONE guifg=NONE guibg=NONE gui=reverse cterm=reverse

" Ultisnips setup
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir = $HOME."/.config/nvim/UltiSnips"
let g:UltiSnipsSnippetDirectories = ['UltiSnips', $HOME.'/.config/nvim/UltiSnips']

" NERD Commenter setup
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 1 " Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign = 'left' " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } } " Add your own custom formats or override the defaults
let g:NERDCommentEmptyLines = 1 " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting

" Autoload configuration when save
autocmd! BufWritePost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim

" Fix strange quotes
function! FixQuotes()
  :%s/“/"/g
  :%s/”/"/g
  :g/\. \. \./d
endfunction

" Convert/Invert key value to bash export
function! ConvertKV()
  :silent! g/^\s*$/d
  :silent! g/^#/d
  :silent! v/=/d
  :silent! %s/^\s*//
  :silent! %s/^\(.*\)=\(.*\)$/- name: "\1"\r  value: \2/g 
endfunction
function! InvertKV()
  :silent! g/^\s*$/d
  :silent! g/^#/d
  :silent! %s/^\s*//
  :silent! %s/^value: "\(.*\)"/\1/g
  :silent! %s/^- name: "\(.*\)"\n/\1=/g
endfunction

" LSP Configuration
let g:deoplete#enable_at_startup = 1
" Rust
let g:rustfmt_autosave = 1
" Go
let g:go_def_mapping_enabled = 0
let g:go_fmt_command = "goimports"
" NVIM LSP
lua require'nvim_lsp'.rls.setup{}
lua require'nvim_lsp'.dockerls.setup{}
lua require'nvim_lsp'.tsserver.setup{}
lua require'nvim_lsp'.gopls.setup{}
lua require'nvim_lsp'.bashls.setup{}
" Use vim-go instead of vim-polyglot/go
let g:polyglot_disabled = ['go']
" LSP key bindings
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>

" Refactor tools
function! QuickFixOpenAll()
    if empty(getqflist())
        return
    endif
    let s:prev_val = ""
    for d in getqflist()
        let s:curr_val = bufname(d.bufnr)
        if (s:curr_val != s:prev_val)
            exec "edit " . s:curr_val
        endif
        let s:prev_val = s:curr_val
    endfor
endfunction
command! QuickFixOpenAll call QuickFixOpenAll()
nnoremap <leader>oa :QuickFixOpenAll<cr>

" Quickscope config
let g:qs_enable=1
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
