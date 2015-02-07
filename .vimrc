set mouse-=a
syntax on
set history=700
set autoread
set wildmenu
set wildignore=*.o,*~,*.pyc
set ruler
set cmdheight=2
set cursorline
set hid
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set showmatch
set mat=2
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set encoding=utf-8
set fileencodings=utf-8
set ffs=unix,dos,mac
set nobackup
set nowb
set noswapfile
set ai
set si
set wrap
set laststatus=2
set statusline=%{fugitive#statusline()}\ \ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
set nu
set tabstop=4
set list
set listchars=tab:\|\ 
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Auto write new files
:autocmd BufNewFile * :write

" Control P

let g:ctrlp_map='<c-p>'

let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript',
                          \ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']

nnoremap <C-r> :CtrlPTag<CR>
imap <C-r> <C-o>:CtrlPTag<CR>

let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" CTags

au BufWritePost *.py,*.c,*.cpp,*.h silent! !eval 'ctags -R -o newtags; mv newtags tags' &

" Pathogen

execute pathogen#infect()

" Filetype Plugins

filetype plugin on
filetype indent on

" Real pasting in VIM

nmap <C-v> :put+<CR>
imap <C-v> <C-o><C-v>

" Nerd tree tabs

let g:nerdtree_tabs_open_on_console_startup=1
let g:NERDTreeShowHidden=1
:let g:NERDTreeWinSize=37

" Great syntax

let g:syntastic_always_populate_loc_list = 1

" Faster navigation

set so=7
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
imap <silent> <A-Up> <C-O>:wincmd k<CR>
imap <silent> <A-Down> <C-O>:wincmd j<CR>
imap <silent> <A-Left> <C-O>:wincmd h<CR>
imap <silent> <A-Right> <C-O>:wincmd l<CR>

" Remember last open position
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

set viminfo^=%

" Delete trailing whitespace on save
func! DeleteTrailingWS()
	exe "normal mz"
	%s/\s\+$//ge
	exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" Key Bindings

nmap <C-j> 10j
nmap <C-k> 10k
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
map <space> /
map <c-space> ?
nmap <silent> <C-H> :wincmd h<CR>
nmap <silent> <C-L> :wincmd l<CR>
nmap <c-s> :w<CR>
vmap <c-s> <Esc><c-s>gv
imap <c-s> <C-O><c-s>
nmap <C-t> :tab new<CR>
imap <C-t> <C-O>:tab new<CR>
imap <C-H> <C-O>:tabp<CR>
imap <C-L> <C-O>:tabn<CR>
nmap <C-H> <C-O>:tabp<CR>
nmap <C-L> <C-O>:tabn<CR>
nmap <C-w> :q!<CR>
imap <C-w> <C-O>:q!<CR>
nmap <C-a> :%y+<CR>
imap <C-a> <C-O>:%y+<CR>

" Windows pls

noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Redo things after close

try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry

" Auto-complete pls

"vnoremap $1 <esc>`>a)<esc>`<i(<esc>
"vnoremap $2 <esc>`>a]<esc>`<i[<esc>
"vnoremap $3 <esc>`>a}<esc>`<i{<esc>
"vnoremap $$ <esc>`>a"<esc>`<i"<esc>
"vnoremap $q <esc>`>a'<esc>`<i'<esc>
"vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [

"inoremap $1 ()<esc>i
"inoremap $2 []<esc>i
"inoremap $3 {}<esc>i
"inoremap $4 {<esc>o}<esc>O
"inoremap $q ''<esc>i
"inoremap $e ""<esc>i
"inoremap $t <><esc>i

" Helpers from ultimate vim config

func! CurrentFileDir(cmd)
    return a:cmd . " " . expand("%:p:h") . "/"
endfunc

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Colors

colorscheme molokai
let g:rehash256 = 1
highlight Normal ctermbg=235 ctermfg=15
highlight SyntasticErrorSign ctermfg=white ctermbg=160
highlight cBraces ctermfg=15
highlight cDelimiter ctermfg=15
highlight MatchParen ctermfg=15 ctermbg=243
highlight LineNr ctermfg=240 ctermbg=235
highlight Type ctermfg=81
highlight Identifier ctermfg=113
highlight Function ctermfg=113
highlight Keyword ctermfg=197
highlight Constant ctermfg=141
highlight String ctermfg=141
highlight SpecialChar ctermfg=141
highlight Literal ctermfg=141
highlight Comment ctermfg=242
highlight cErrInParen ctermbg=235
highlight cStatement ctermfg=197
highlight cInclude ctermfg=197
highlight cIncluded ctermfg=228
highlight NERDTreeCWD ctermfg=15
highlight CursorLine ctermbg=236
highlight CursorLineNr ctermfg=15 ctermbg=238
highlight SpecialKey ctermfg=237
highlight Statement ctermfg=197
highlight Error ctermfg=15 ctermbg=235
highlight NERDTreeExecFile ctermfg=15
highlight Visual ctermbg=236

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

au FocusLost * :silent! wall
au VimResized * :wincmd =

" Force colors
:set t_Co=256

autocmd BufNew * wincmd l

set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" Resize splits when the window is resized
au VimResized * :wincmd =

" Persistent undo                                                           
if has('persistent_undo')
  let undodir = expand("~/.vim/undos/$USER")
  if !isdirectory(undodir)
    call mkdir(undodir)
  endif
  set undodir=~/.vim/undos/$USER/
  set undofile
endif