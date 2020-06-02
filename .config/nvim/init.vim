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
Plug 'antoinemadec/coc-fzf'
" Snippet
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
" Utility
Plug 'preservim/nerdtree', { 'on':  ['NERDTreeToggle', 'NERDTreeCWD'] }
Plug 'unblevable/quick-scope'
Plug 'benmills/vimux'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'alvan/vim-closetag'
Plug 'ryanoasis/vim-devicons'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'skywind3000/asyncrun.vim'
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
set rnu
set nu
set ttyfast
" set lazyredraw
set encoding=UTF-8
set complete-=i   " disable scanning included files
set complete-=t   " disable searching tags
set background=dark " Set dark background
colorscheme nord
set fillchars+=vert:\|
highlight CursorLineNr cterm=bold,italic gui=bold,italic
" Italic comment
highlight Comment cterm=italic gui=italic

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
map <silent> <leader>ev :tabnew<cr>:lcd ~/.config/nvim<cr>:e init.vim<CR>

" Lazy binding
nmap ; :
vmap ; :

" Quick buffer back
nmap <leader>b :b#<cr>
" Quick open tab
nmap <leader>t :tabnew<cr>
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
" Easy wrap nav
nnoremap j gj
nnoremap k gk
" make Y consistent with C and D.
nnoremap Y y$
" enable . command in visual mode
vnoremap . :normal .<cr>
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
" quick move
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" AsyncRun
nmap '<Space> :copen<cr>:AsyncRun 
" FZF
so $HOME/.config/nvim/fzf.vim
" Coc
so $HOME/.config/nvim/coc.vim
" CloseTag
so $HOME/.config/nvim/close-tag.vim

" Git utility
function! s:changebranch(branch)
    execute 'Git checkout' . a:branch
endfunction
command! -bang Gbranch call fzf#run(fzf#wrap({
            \ 'source': 'git branch -a --no-color | grep -v "^\* " ', 
            \ 'sink': function('s:changebranch'),
            \ 'options': '--prompt="Switch Branch: "'
            \ }))

nmap <silent> <leader>gs :Gstatus<CR><C-w>8+
nmap <silent> <leader>ga :Git add --all<cr>
nmap <silent> <leader>gc :Gcommit<CR><C-w>8+
nmap <silent> <leader>gw :Gwrite<CR>
nmap <leader>gn :Git checkout -b 
nmap <silent> <leader>gl :copen<cr>:execute "AsyncRun git-push-open-pr " . fugitive#head(0)<CR>
nmap <silent> <leader>gp :copen<cr>:execute "AsyncRun git push origin " . fugitive#head(0)<CR>
nmap <leader>gb :Gbranch<cr>
nmap <leader>gg :execute ":Git pull origin " . fugitive#head(0)<CR>

" Quick indent
xnoremap > >gv
xnoremap < <gv

" Vim Commentary
nmap <leader>c gcc
xmap <leader>c gcc<esc>

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
    elseif (&filetype == 'python')
        let command =  " clear && python ".fname
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
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
else
  set t_Co=256
endif

" Ultisnips setup
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
" let g:UltiSnipsSnippetsDir = $HOME."/.config/nvim/UltiSnips"
" let g:UltiSnipsSnippetDirectories = ['UltiSnips', $HOME.'/.config/nvim/UltiSnips']

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

" Dart snippet
autocmd BufRead,BufNewFile,BufEnter *.dart UltiSnipsAddFiletypes dart-flutter

" NERDTree config
let NERDTreeShowHidden=1
highlight! link NERDTreeFlags NERDTreeDirSlash

" Autoload configuration when save
autocmd! BufWritePost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("Substitute", 200)
augroup END

" Terminal config
augroup neovim_terminal
    tnoremap <Esc> <C-\><C-n>
    autocmd!

    " Enter Terminal-mode (insert) automatically
    autocmd TermOpen * startinsert

    " Disables number lines on terminal buffers
    autocmd TermOpen * :set nonumber norelativenumber
augroup END

" FZF Override
autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>

