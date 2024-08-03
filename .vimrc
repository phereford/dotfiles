set nocompatible
set regexpengine=0
filetype off
source ~/.dotfiles/bundles.vim
runtime macros/matchit.vim

syntax enable
set background=dark
colorscheme gruvbox

set term=screen-256color
set guifont=Source\ Code\ Pro:h14
set number relativenumber
set ignorecase smartcase
set cursorline
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999
set history=10000
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set backspace=2
set laststatus=2
set showmatch
set incsearch
set hlsearch
set shell=/bin/bash
set tags+=gems.tags

au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
au BufRead,BufNewFile *.eex,*.heex,*.leex,*.sface,*.lexs set filetype=eelixir
au BufRead,BufNewFile mix.lock set filetype=elixir
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear


if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Copy & Paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>x :edit %%
map <leader>v :view %%
nmap <leader>es :sp <C-R>=expand('%:h').'/'<cr>
nmap <leader>ev :vsp <C-R>=expand('%:h').'/'<cr>
nmap <leader>et :tabe <C-R>=expand('%:h').'/'<cr>
nmap <leader>sj :SplitjoinSplit<cr>
nmap <leader>sk :SplitjoinJoin<cr>

" fzf
nmap ; :Buffers<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>r :Tags<CR>

" Vim Tab Mappings
map <C-t> <esc>:tabnew<CR>

" Elixir Test mappings
map <Leader>t :Dispatch MIX_ENV=test mix test %<CR>
map <Leader>a :Dispatch MIX_ENV=test mix test<CR>

" Git Mappings
vmap <Leader>gb :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
map <Leader>gw :!git add . && git commit -m 'WIP' && git push<cr>
map <Leader>gd :Gdiff<cr>
map <Leader>gs :Gstatus<cr>
map <Leader>gc :Gcommit<cr>

" Github Copilot Mappings
map <Leader>cp :Copilot panel<cr>

" Misc Mappings
map <Leader>i mmgg=G`m<CR> " Fix Indentations
map <Leader><Left> <esc>:tabprevious<CR>
map <Leader><Right> <esc>:tabnext<CR>

let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**"

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" vim.gist configuration
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_post_private = 1
let g:gist_open_browser_after_post = 1

" airline configuration
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

set laststatus=2               " enable airline even if no splits
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.linenr = '␊ '
let g:airline_symbols.linenr = '␤ '
let g:airline_symbols.linenr = '¶ '
let g:airline_symbols.branch = '⎇ '
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#syntastic#enable = 1
let g:airline#extensions#branch#enabled = 1

" This is a local, per-project `.vimrc`.
" It maps `H` to read in line coverage from the "coverage/raw" file and
" mark uncovered lines as errors using Vim :signs functionality.

highlight SignColumn NONE
sign define covpos text=• texthl=String linehl=Success
sign define covneg linehl=Error text=𐄂 texthl=HelpDebug

function! s:SignCoverage(file)
  let output = system('grep "'.a:file.'" coverage/raw')
  let lines = split(output, '\n')
  exec 'sign unplace * buffer='.bufnr('%')
  for line in lines
    let [ type, lnum, fname ] = split(line, ' ')
    let name = type == '+' ? 'covpos' : 'covneg'
    exec 'sign place '.lnum.' line='.lnum.' name='.name.' buffer='.bufnr('%')
  endfor
endfunction

map H :call <SID>SignCoverage(expand('%:p'))<cr>

let g:snipMate = { 'snippet_version' : 1 }
let g:tagbar_type_elixir = {
    \ 'ctagstype' : 'elixir',
    \ 'kinds' : [
        \ 'p:protocols',
        \ 'm:modules',
        \ 'e:exceptions',
        \ 'y:types',
        \ 'd:delegates',
        \ 'f:functions',
        \ 'c:callbacks',
        \ 'a:macros',
        \ 't:tests',
        \ 'i:implementations',
        \ 'o:operators',
        \ 'r:records'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 'p' : 'protocol',
        \ 'm' : 'module'
    \ },
    \ 'scope2kind' : {
        \ 'protocol' : 'p',
        \ 'module' : 'm'
    \ },
    \ 'sort' : 0
\ }
if executable('nextls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'next_ls',
        \ 'cmd': ["nextls", "--stdio"],
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(
        \	lsp#utils#find_nearest_parent_file_directory(
        \		lsp#utils#get_buffer_path(),
        \		['mix.exs']
        \	))},
        \ 'allowlist': ['elixir'],
        \ })
endif
