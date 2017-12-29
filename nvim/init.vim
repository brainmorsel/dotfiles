" Map the leader key to SPACE
let mapleader="\<SPACE>"

"-------------------------
" Plugins
"-------------------------
" https://github.com/junegunn/vim-plug
call plug#begin()
Plug 'Shougo/neomru.vim'
"Plug 'majutsushi/tagbar'
" Pandoc / Markdown
Plug 'vim-pandoc/vim-pandoc', { 'for': [ 'pandoc', 'markdown' ] }
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': [ 'pandoc', 'markdown' ] }
" General
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'benekastah/neomake'
Plug 'jaawerth/nrun.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/unite.vim'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/unite-outline'
" Автоматическая вставка скобочек, кавычем и т.п.
"Plug 'Raimondi/delimitMate'
Plug 'altercation/vim-colors-solarized'
Plug 'ervandew/supertab'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'edkolev/tmuxline.vim'
"Plug 'edkolev/promptline.vim'
Plug 'tpope/vim-obsession'
" Rust
Plug 'rust-lang/rust.vim'
" Python
"Plug 'tweekmonster/braceless.vim'
Plug 'python-mode/python-mode', {'branch': 'develop'}
" JavaScript
Plug 'othree/yajs.vim'
Plug 'posva/vim-vue'

Plug 'lepture/vim-jinja'

"Plug 'keith/tmux.vim'
" Pony lang
Plug 'dleonard0/pony-vim-syntax'
" TaskPaper
Plug 'davidoc/taskpaper.vim'
" Go Lang
Plug 'fatih/vim-go'
" VimWiki
Plug 'vimwiki/vimwiki'
call plug#end()

let g:vimwiki_list = [{'path': '~/Sync/my_wiki/', 'path_html': '~/Sync/my_wiki_html/'}]

let g:rustfmt_autosave = 0
let g:deoplete#enable_at_startup = 1
let g:netrw_liststyle=1

let g:pymode_python = 'python3'
let g:pytmode_lint = 0

" When writing a buffer, and on normal mode changes (after 750ms).
call neomake#configure#automake('nw', 750)

au BufEnter *.{js,vue} let b:neomake_javascript_eslint_exe = nrun#Which('eslint')

let g:neomake_python_flake8_maker = {
        \ 'args': ['--format=default', '--ignore=E501,E231,E203'],
        \ 'errorformat':
            \ '%E%f:%l: could not compile,%-Z%p^,' .
            \ '%A%f:%l:%c: %t%n %m,' .
            \ '%A%f:%l: %t%n %m,' .
            \ '%-G%.%#',
        \ 'postprocess': function('neomake#makers#ft#python#Flake8EntryProcess')
        \ }

" Python: workon venv && pip install neovim && pip install python-language-server
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'python': ['pyls'],
    \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 0
"nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
"nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
"nnoremap <silent> <F3> :call LanguageClient_textDocument_rename()<CR>

" Unite
call unite#filters#matcher_default#use(['matcher_fuzzy'])
"nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>
nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline outline<cr>
" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction

nmap <F8> :TagbarToggle<CR>
" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#tmuxline#snapshot_file = "~/.config/tmux.theme.conf"
let g:airline#extensions#promptline#enabled = 1
let g:airline#extensions#promptline#snapshot_file = "~/.config/bash/promptline.sh"
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'VL',
      \ '' : 'VB',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ }
let g:tmuxline_preset = {
      \'a'    : '#H',
      \'b'    : '#S',
      \'c'    : '#W',
      \'win'  : '#I #W #F',
      \'cwin' : '#I #W'}
"let g:promptline_preset = {
"        \'a'    : [ '$USER' ],
"        \'b'    : [ promptline#slices#cwd() ],
"        \'c'    : [ promptline#slices#vcs_branch(), promptline#slices#git_status() ],
"        \'y'    : [ promptline#slices#python_virtualenv() ],
"        \'warn' : [ promptline#slices#last_exit_code() ]}
let g:airline_section_b='%{ObsessionStatus("[%s]")}'

"-------------------------
" Filetypes
"-------------------------
autocmd! BufWritePost * Neomake
au BufRead,BufNewFile *.jinja set filetype=jinja
au BufRead,BufNewFile *.w3af set filetype=w3af
au BufRead,BufNewFile *.json set filetype=javascript
au BufRead,BufNewFile *.md,*.txt set filetype=pandoc
au BufRead,BufNewFile *.{html,htm,vue*} set filetype=html 
au BufRead,BufNewFile *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl

au BufNewFile,BufReadPost *.coffee,*.jade setl shiftwidth=2 expandtab foldmethod=indent nofoldenable softtabstop=2 tabstop=2
"au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!
au BufNewFile,BufReadPost *.{js,jsx,html,htm,vue*} setl shiftwidth=2 expandtab nofoldenable softtabstop=2 tabstop=2

" Python
au BufNewFile,BufReadPost *.py setl foldmethod=indent nofoldenable tabstop=4 expandtab shiftwidth=4 softtabstop=4
au BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
" Trim trailing whitespace:
au BufWritePre *.py normal m`:%s/\s\+$//e ``
"autocmd FileType python BracelessEnable +indent +highlight-cc2

au! BufWritePost $MYVIMRC source $MYVIMRC


set spelllang=ru_yo,en
syntax on
filetype plugin indent on
colorscheme solarized
set background=dark
set complete-=i
set colorcolumn=80
" for white space characters visualisation
set listchars=nbsp:¬,eol:¶,trail:·,tab:»·,extends:>,precedes:<
" Allow backspacing over everything in insert mode
set backspace=indent,eol,start
" Show the cursor position all the time
set ruler
" Ignore case in search patterns
set ignorecase
" Override the 'ignorecase' option
" if the search pattern contains upper case characters.
set smartcase
" Turn on number vertical line
set number
set relativenumber
" I don't like backups
set nobackup
" (additionally disable swap files)
"set noswapfile
" Switch off folds
set nofoldenable
set foldmethod=indent
" Use incremental searching
set incsearch
" Highlight search results?
set hlsearch
" Jump N lines when running out of the screen
set scrolljump=7
" Indicate jump out of the screen when N lines before end of the screen
set scrolloff=7
" Write all tmp files to /tmp
set dir=/tmp
" Do NOT unload buffer when switch to another one
" this allows to edit several files in the same time without having to save
" them each time you switch between them
set hidden
" Hide the mouse when typing text
set mousehide
set mouse=a
" Turn on autoindent (http://stackoverflow.com/a/10380793)
set autoindent
"set indentexpr=GetIndent()
function! GetIndent()
   let lnum = prevnonblank(v:lnum - 1)
   let ind = indent(lnum)
   return ind
endfunction
" Auto indent after a {
set smartindent
" Expand tab to spaces?
set expandtab
" Default tab size
"set noexpandtab
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=4
set tabstop=4
" Fix <Enter> for comment
"set fo+=cr
" Session options
set sessionoptions=curdir,buffers,tabpages
set foldcolumn=2
" Russian support
set keymap=russian-jcukenwin
" по умолчанию - латинская раскладка
set iminsert=0
" по умолчанию - латинская раскладка при поиске
set imsearch=0
set laststatus=2			"always show statusline
set statusline=
set statusline+=(%n)\ 	"buffer number
set statusline+=%F\ 		"full path
set statusline+=%m\ 		"modified flag
set statusline+=%c,			"cursor column
set statusline+=%l/%L		"cursor line/total lines
set statusline+=\ %P		"percent through file
set statusline+=%=			"left/right separator
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}]		"file format
set statusline+=%h			"help file flag
set statusline+=%r			"read only flag
set statusline+=%y  		"filetype

"-------------------------
" Bindings
"-------------------------
" Clear the highlighting after search
nnoremap <esc> :noh<return><esc>
" Make <Backspace> act as <Delete> in Visual mode?
vmap <BS> x
" CTRL-C and CTRL-Insert are Copy
vmap <C-C> "+yi
" _ and x is workaround for preserve indent on blank line
imap <C-V> _<esc>x"+gpa

" F2 to quick save
nmap <F2> :write<CR>
imap <F2> <C-o>:write<CR>

nmap <F4> :set list!<CR>
imap <F4> <C-o>:set list!<CR>
" F10 kill buffer
nmap <F10> :bd<CR>
imap <F10> <Esc>:bd<cr>
" < & > to indent blocks
vmap < <gv
vmap > >gv
" Use ; for commands.
nnoremap ; :
" Use Q to execute default register.
nnoremap Q @q
" Disable arrow keys
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>
" Moving the cursor through long soft-wrapped lines
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
