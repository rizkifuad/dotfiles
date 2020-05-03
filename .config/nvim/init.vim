filetype off
call plug#begin('~/.nvim/plugged')
" Appearance
Plug 'itchyny/lightline.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'arcticicestudio/nord-vim'
" Language and ftp
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Snippet
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
" Utility
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'unblevable/quick-scope'
Plug 'benmills/vimux'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'skywind3000/asyncrun.vim'
Plug 'antoinemadec/coc-fzf'
call plug#end()
filetype on

let mapleader = "," " Set comma as leader key

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
set clipboard+=unnamedplus
set list " set list characters
" set listchars=tab:▸\ ,eol:¬ " Display tab and eol char
set listchars=eol:↲,tab:↦\ ,nbsp:␣,extends:…,trail:⋅
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
set complete-=i   " disable scanning included files
set complete-=t   " disable searching tags
set background=dark " Set dark background
colorscheme nord
" Setup statusbar
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'cocstatus' ,'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status',
      \ },
      \ }

" Open folder tree
nmap <silent><leader>a :NERDTreeToggle<cr>
nmap <silent><leader>k :NERDTreeCWD<cr>
" Quick open config file
map <silent> <leader>ev :e ~/.config/nvim/init.vim<CR>
" lazy binding
nmap ; :
vmap ; :
" Quick buffer back
nmap <leader>b :b#<cr>
" Quick close
nmap <leader>q :q<cr>
" Quick write
nmap <leader>w :w<cr>
" toggle search highliting
nmap <silent><leader><space> :set invhlsearch<cr>
" Quickly move current line
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>
" Quickly add empty lines
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>
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
" AsyncRun
nmap <leader>y :copen<cr>:AsyncRun 

" FZF
so $HOME/.config/nvim/fzf.vim
" Coc
so $HOME/.config/nvim/coc.vim

" Git utility
function! s:changebranch(branch)
    execute 'Git checkout' . a:branch
endfunction
command! -bang Gbranch call fzf#run(fzf#wrap({
            \ 'source': 'git branch -a --no-color | grep -v "^\* " ', 
            \ 'sink': function('s:changebranch'),
            \ 'options': '--prompt="Switch Branch: "'
            \ }))
" Terminal bookmark
function! s:opentermbookmark(cmd)
    execute 'AsyncRun /home/rizki/work/personal/tbmk/target/debug/tbmk' .' "'. a:cmd .'"'
endfunction
command! -bang TermBookmark call fzf#run(fzf#wrap({
            \ 'source': '/home/rizki/work/personal/tbmk/target/debug/tbmk', 
            \ 'sink': function('s:opentermbookmark'),
            \ 'options': '--ansi --prompt="Terminal Bookmark: "'
            \ }))
nmap <space><space> :TermBookmark<cr>
nmap <silent> <leader>gs :Gstatus<CR><C-w>100+
nmap <silent> <leader>gc :Gcommit<CR><C-w>6+
nmap <silent> <leader>gw :Gwrite<CR>
nmap <leader>gn :Git checkout -b 
nmap <leader>gp :execute ":Git push origin " . fugitive#head(0)<CR>
nmap <leader>gb :Gbranch<cr>
nmap <leader>gg :execute ":Git pull origin " . fugitive#head(0)<CR>

" Quick indent
xnoremap > >gv
xnoremap < <gv

" Toggle tab width
nmap <leader>2 :set tabstop=2 shiftwidth=2 softtabstop=2<CR>
nmap <leader>4 :set tabstop=4 shiftwidth=4 softtabstop=4<CR>
nmap <leader>8 :set tabstop=8 shiftwidth=8 softtabstop=8<CR>

" VIMUXX
function! RunFile()
    let fname = @%
    if (&filetype == 'rust')
        let command =  " clear && cargo run"
    elseif (&filetype == 'sh')
        let command =  " clear && ./".fname
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
" hi VertSplit ctermbg=none ctermfg=243 guibg=none
" hi Search ctermbg=NONE ctermfg=NONE guifg=NONE guibg=NONE gui=reverse cterm=reverse
" hi IncSearch ctermbg=NONE ctermfg=NONE guifg=NONE guibg=NONE gui=reverse cterm=reverse

" Ultisnips setup
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
" let g:UltiSnipsSnippetsDir = $HOME."/.config/nvim/UltiSnips"
" let g:UltiSnipsSnippetDirectories = ['UltiSnips', $HOME.'/.config/nvim/UltiSnips']

" NERD Commenter setup
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 1 " Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign = 'left' " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } } " Add your own custom formats or override the defaults
let g:NERDCommentEmptyLines = 1 " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting

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

" Use vim-go instead of vim-polyglot/go
let g:polyglot_disabled = ['go']
" Rust
let g:rustfmt_autosave = 1
" Go
let g:go_def_mapping_enabled = 0
let g:go_fmt_command = "goimports"

" Load all files in quick fix window into buffer
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
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

" Source local configuration if exist
if filereadable('.local.vim')
    so .local.vim
endif

autocmd BufRead,BufNewFile,BufEnter *.dart UltiSnipsAddFiletypes dart-flutter

" Autoload configuration when save
autocmd! BufWritePost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim
