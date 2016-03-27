" Map the leader key to SPACE
let mapleader="\<SPACE>"

"-------------------------
" Plugins
"-------------------------
" https://github.com/junegunn/vim-plug
call plug#begin()
" Pandoc / Markdown
Plug 'vim-pandoc/vim-pandoc', { 'for': [ 'pandoc', 'markdown' ] }
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': [ 'pandoc', 'markdown' ] }
" General
Plug 'benekastah/neomake'
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/unite.vim'
Plug 'Raimondi/delimitMate'
Plug 'altercation/vim-colors-solarized'
Plug 'ervandew/supertab'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'edkolev/promptline.vim'
Plug 'tpope/vim-obsession'
" Rust
Plug 'rust-lang/rust.vim'
call plug#end()

let g:rustfmt_autosave = 0

let g:deoplete#enable_at_startup = 1
" Unite
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
"nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
"nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>
nnoremap <F5> :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>
inoremap <F5> <C-o>:<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>
" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction
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
let g:airline#extensions#tmuxline#enabled = 1
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
let g:promptline_preset = {
        \'a'    : [ '$USER' ],
        \'b'    : [ promptline#slices#cwd() ],
        \'c'    : [ promptline#slices#vcs_branch(), promptline#slices#git_status() ],
        \'y'    : [ promptline#slices#python_virtualenv() ],
        \'warn' : [ promptline#slices#last_exit_code() ]}
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
au BufNewFile,BufReadPost *.js,*.jsx,*.html setl shiftwidth=2 expandtab nofoldenable softtabstop=2 tabstop=2

" Python
au BufNewFile,BufReadPost *.py setl foldmethod=indent nofoldenable tabstop=4 expandtab shiftwidth=4 softtabstop=4
au BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
" Trim trailing whitespace:
au BufWritePre *.py normal m`:%s/\s\+$//e ``

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
