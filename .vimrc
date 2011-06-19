"PATHOGEN YO
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
"
" Sets how many lines of history VIM has to remember
set history=300
set ttyfast
set hidden

"set timeoutlen=100
set exrc
set secure

" Turn off Vi compatibility
set nocompatible

" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","


nmap <F5> :w<CR>
inoremap <F5> <ESC>:w!<CR> i


" Fast editing of the .vimrc
nnoremap <leader>ev <C-w><C-l>:e $MYVIMRC<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vim/vimrc
autocmd! bufwritepost .vimrc source ~/.vimrc

" Set 7 lines to the curors - when moving vertical..
set so=7

set wildmenu "Turn on WiLd menu
set wildmode=list:longest

set ruler "Always show current position

set cmdheight=1 "The commandbar height

set hid "Change buffer - without saving

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching
set smartcase
set gdefault

"clear search
nnoremap <leader><space> :noh<cr>


set hlsearch "Highlight search things

set incsearch "Make search act like search in modern browsers

set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=50 "How many tenths of a second to blink



" No sound on errors
set noerrorbells
set novisualbell
set visualbell t_vb=

syntax enable "Enable syntax hl


set shell=/bin/bash

" Highlight current line
"set cursorline

set background=dark
colorscheme molokai

set encoding=utf8
try
    lang en_US
catch
endtry

set ffs=unix,dos,mac "Default file types


" Backups {{{

set backupdir=~/tmp/vim/backup// " backups
set directory=~/tmp/vim/swap//   " swap files
set backup                        " enable backups

" }}}

set undofile
set undoreload=10000


set smarttab
set tabstop=4
set shiftwidth=4
set expandtab
set list listchars=tab:\ \ ,trail:·

set lbr

set autoindent "Auto indent
set wrap linebreak nolist
set formatoptions=qrn1
set textwidth=79
set colorcolumn=85


" useful to learn !!
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

au FocusLost * :wa


inoremap jk <ESC>


" Map space to / (search) and c-space to ? (backgwards search)
map <space> /
map <c-space> ?

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


" Switch buffers with L and H easily
map L :bn<cr>
map H :bp<cr>

" Tab configuration
map <leader>tn :tabnew %<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Split vertically when opening help pages
cabbrev h vert help

" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=%F%m%r%h\ %w\ \ %{fugitive#statusline()}%=%-14.(%l/%L:%c%)\ %P

"set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)


" Really useful!
"  In visual mode when you press * or # to search for the current selection
" vnoremap <silent> * :call VisualSearch('f')<CR>
" vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
" vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" " From an idea by Michael Naumann
" function! VisualSearch(direction) range
"     let l:saved_reg = @"
"     execute "normal! vgvy"
" 
"     let l:pattern = escape(@", '\\/.*$^~[]')
"     let l:pattern = substitute(l:pattern, "\n$", "", "")
" 
"     if a:direction == 'b'
"         execute "normal ?" . l:pattern . "^M"
"     elseif a:direction == 'gv'
"         call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
"     elseif a:direction == 'f'
"         execute "normal /" . l:pattern . "^M"
"     endif
" 
"     let @/ = l:pattern
"     let @" = l:saved_reg
" endfunction










"Remap VIM 0
map 0 ^

" Bubble single lines
nmap <up> [e
nmap <down> ]e
" Bubble multiple lines
vmap <up> [egv
vmap <down> ]egv

" Visually select the text that was last edited/pasted
nmap gV `[v`]


"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>


" sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

"don't move the cursor after pasting (by jumping to back start of previously changed text)
noremap p p`[
noremap P P`[



" Turn search highlighting off quickly
nnoremap <leader><space> :noh<cr>



" Show Yankring contents
nnoremap <silent> <leader>y :YRShow<cr>


" NERDTree configuration
let NERDTreeIgnore=['\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

" FuzzyFinder
let g:fuf_coveragefile_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp)$|build-|build($|[/\\])|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
map <leader>l   :FufCoverageFileRegister<CR>
map <leader>fp   :exe ":FufCoverageFileChange ". g:project_name<CR>
map <leader>fe   :exe ":FufCoverageFileChange ". g:project_name . "_cpp"<CR>
map <leader>fc   :FufCoverageFileChange<CR>
map <leader>fa   :FufCoverageFile<CR>
map <leader>q :FufQuickfix<CR>

noremap <silent> <leader>b   :FufBuffer<CR>

map <leader>ep :exe ":e ". g:project_root . "/.vimrc" <CR>

map <leader>ta  :FufTag<CR>

map <leader>tt :ConqueTerm bash<CR>


function! RefreshProjectTags()
    if exists("g:project_root")
        exe "!echo 'using project_root' && /usr/bin/ctags -R --c++-kinds=+cdefgmnstuv --fields=+iaS --extra=+q --exclude=build* -f ". g:project_root . "tags ". g:project_root
    else
        exe "!echo 'using current working dir' && /usr/bin/ctags -R --c++-kinds=+cdefgmnstuv --fields=+iaS --extra=+q --exclude=build*"
    endif
endfunction

map <F8> :call RefreshProjectTags()<CR>

map <leader>tz :vert stselect<CR>
map <leader>tr :tselect<CR>

map <leader>tl :TagbarToggle<CR>
map <leader>to :TagbarOpen<CR>

map <leader>z :bd<CR>
map <leader>o <C-w><C-w>
noremap <ESC>o <C-w>w
imap <M-o> <ESC><C-w>w
set <M-o>=o

noremap <leader>a <ESC> :on<CR> :AV<CR> <C-w>r

map <leader><F3> <C-w>v<C-w>l
map <leader><F2> :on<CR>

noremap <silent> <leader><F9> :on<CR> :copen<CR><ESC> <C-w>t<C-w>H <C-w>w

noremap <silent> <leader><F8> :wa<CR> :Make<CR>

imap <silent> <leader><F9> <ESC><leader><F9>
imap <silent> <leader><F8> <ESC><leader><F8>



map <silent> <leader><F10> :cn<CR>
map <silent> <leader><F11> :cp<CR>

noremap <leader><F1> :FixWhitespace<CR>

noremap <silent> <C-F7> <C-w>:A<CR>

noremap <leader>gs :Gstatus<CR>
noremap <leader>gl :Glog<CR>

" Reformat current paragraph
noremap <leader>gq gqap

set autochdir


let g:Tlist_Show_One_File=1

set tags=tags;$HOME

"set completeopt+=longest
" automatically open and close the popup menu / preview window
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menu,longest,preview


au BufRead,BufNewFile *.txx set filetype=cpp


" Set an orange cursor in insert mode, and a red cursor otherwise.
" " Works at least for xterm and rxvt terminals.
" " Does not work for gnome terminal, konsole, xfce4-terminal.
if &term =~ "xterm\\|rxvt"
    :silent !echo -ne "\033]12;red\007"
    let &t_SI = "\033]12;cyan\007"
    let &t_EI = "\033]12;red\007"
    autocmd VimLeave * :!echo -ne "\033]12;red\007"
endif

let g:clang_complete_auto=0
" " let g:clang_library_path='/usr/local/lib/'
let g:clang_use_library=1
" let g:clang_complete_copen=1
" let g:clang_periodic_quickfix=1
" let g:clang_snippets=1
" let g:clang_debug=1

"let g:SuperTabLongestEnhanced=1
let g:SuperTabDefaultCompletionType = "context"

let g:acp_completeOption = '.,w,b,k,t'


map <F7> :checktime<CR>


noremap <leader>do :set syntax=cpp.doxygen<CR>
noremap <leader>dn :set syntax=cpp<CR>

map <F10> :set paste<CR>
map <F11> :set nopaste<CR>
imap <F10> <C-O>:set paste<CR>
imap <F11> <nop>
set pastetoggle=<F11>


map <F4> :exe ":Ack --type=cpp " . expand("<cword>") . " " . g:project_root<CR>


" wimwiki
let g:vimwiki_folding=1
let g:vimwiki_fold_lists=1
let g:vimwiki_hl_headers=1
