" vim: set fdm=marker fmr={{{,}}}:

source ~/.vim_bundles

" Basic Options {{{
set nocompatible
set modeline
set modelines=10
syntax enable
filetype plugin indent on
set ruler
set showcmd
set number
set incsearch
set smartcase
set ignorecase
set scrolloff=10
set tabstop=4
set shiftwidth=4
set softtabstop=4
set nosmartindent
set expandtab
set noerrorbells visualbell t_vb=
set laststatus=2
set hidden
let mapleader = ','
let maplocalleader = '\'
set wildignore=*.pyc,*.o,.git
set clipboard=unnamedplus
set backupdir=./.backup,.,/tmp
set directory=./.backup,.,/tmp
set foldmarker={{{,}}}
set colorcolumn=+1
" }}}

let g:indentLine_char              = '│'

" Ctrl+V to paste in insert mode {{{
inoremap <C-v> <Esc>pa
" }}}

" Command-T options {{{
let g:CommandTMaxDepth             = 30
let g:CommandTMaxCachedDirectories = 3
let g:CommandTMaxHeight            = 40
let g:CommandTMatchWindowReverse   = 1
" let g:CommandTMatchWindowAtTop=1
" }}}

" Tagbar options {{{
let g:tagbar_autoclose=1
let g:tagbar_autofocus=1
let g:tagbar_compact=1
let g:tagbar_ctags_bin='/usr/bin/ctags'
" }}}

" Tag Highlight Options {{{

" }}}

" MiniBufExplorer options {{{
let g:miniBufEplorerAutoStart = 0
let g:miniBufExplAutoStart = 0
" }}}

" delimitMate options {{{
let g:delimitMate_expand_cr = 1
" }}}

" Enable omni completion. {{{
augroup omni
  au!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  "autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType php setlocal omnifunc=
augroup END
" }}}

" UltiSnips options {{{
let g:UltiSnipsExpandTrigger = '<c-j>'
   "g:UltiSnipsJumpForwardTrigger          <c-j>
   "g:UltiSnipsJumpBackwardTrigger         <c-k>
" }}}

" Fugitive options {{{
autocmd BufNewFile,BufRead fugitive://* set bufhidden=delete
" }}}

" VDebug Options {{{
let g:vdebug_options = {'server': '192.168.56.1'}
" }}}

" VimPipe Options {{{
augroup sql
  autocmd FileType sql        let b:vimpipe_command="ssh vladmin@cos.dev 'psql cos cosadmin'"
  autocmd FileType sql        let b:vimpipe_filetype="postgresql"
  autocmd FileType sql        set syntax=postgresql
  autocmd FileType postgresql set nowrap
augroup END

augroup markdown
  autocmd FileType markdown let b:vimpipe_command='markdown'
  autocmd FileType markdown let b:vimpipe_filetype='html'
augroup END

command! SqlVbox     let b:vimpipe_command='ssh vladmin@cos.dev "psql cos cosadmin"'
command! SqlVbox2    let b:vimpipe_command='ssh vladmin@cos.dev "psql os000 os000"'
command! SqlCoral    let b:vimpipe_command='ssh vladmin@coral.vladmin.net "psql cos cosadmin"'
command! SqlPacific  let b:vimpipe_command='ssh vladmin@pacific.vladmin.net "psql cos cosadmin"'
command! SqlCalculon let b:vimpipe_command='ssh vladmin@calculon.vladmin.net "psql cos cosadmin"'
command! SqlFlexo    let b:vimpipe_command='ssh vladmin@flexo.vladmin.net "psql cos cosadmin"'
command! SqlMario    let b:vimpipe_command='ssh vladmin@mario.vladmin.net "psql cos cosadmin"'
command! SqlLuigi    let b:vimpipe_command='ssh vladmin@luigi.vladmin.net "psql cos cosadmin"'
" }}}

" Statusline {{{
if has("gui_running")
  let g:airline_powerline_fonts=1
else
  let g:airline_powerline_fonts=0
endif

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

let g:airline#extensions#tagbar#flags = 'f'
let g:ariline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2

"set statusline=
"set statusline+=%2*[%n%H%M%R%W]%*\              " flags and buf no
"set statusline+=%-40f%<\                        " path
"set statusline+=%=%40{fugitive#statusline()}\   " Vim status
"set statusline+=%1*%y%*%*\                      " file type
"set statusline+=%10((%l,%c)%)\                  " line and column
"set statusline+=%P                              " percentage of file
" }}}

" GUI options {{{
set go-=m
set go-=T
set go-=r
set go-=L
set go-=e
" Can't make up my mind on this one... I like Meslo so far though
"set guifont=Droid\ Sans\ Mono\ 8
"set guifont=Inconsolata\ 10
set guifont=Meslo\ LG\ S\ DZ\ 9
"set guifont=Meslo\ LG\ S\ DZ\ 15
" }}}

" Code review mode {{{
fun! GetFontName()
  return substitute(&guifont, '^\(.\{-}\)[0-9]*$', '\1', '')
endfun

fun! <SID>CodeReviewMode()
  let &guifont = GetFontName() . ' 15'
endfun
com! CodeReviewMode call <SID>CodeReviewMode()

fun! <SID>EndCodeReview()
  let &guifont = GetFontName() . ' 9'
endfun
com! EndCodeReview call <SID>EndCodeReview()
" }}}

" DetectIndent {{{
autocmd BufReadPost * DetectIndent
let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 4
" }}}

" Syntastic {{{
let g:syntastic_enable_signs = 0

" Python {{{
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_post_args = "--ignore=E101,E223,E224,E301,E302,E303,E501,E701,W,F401,E111,E261"
" }}} Python

" Javascript {{{
let g:syntastic_javascript_checkers = ['jshint']
" }}}
" }}}

" Javascript stuff {{{
autocmd FileType jsx set syntax=javascript
" }}}

" Bufferline {{{
let g:bufferline_echo=0
" }}}

" Eclim {{{
let g:EclimCompletionMethod = 'omnifunc'
au FileType java noremap <C-I> :JavaImportOrganize<CR>
" }}}

" Signify options {{{
let g:signify_mapping_next_hunk = ']h'
let g:signify_mapping_prev_hunk = '[h'
let g:signify_vcs_list          = ['git']
let g:signify_sign_change       = '~'
let g:signify_sign_delete       = '-'
" }}}

" Simplenote {{{
source ~/.simplenoterc
let g:SimplenoteFiletype = 'markdown'
let g:SimplenoteSortOrder = 'pinned,modifydate,tagged,createdate'
let g:SimplenoteVertical = 1

nnoremap <Leader>nn :Simplenote -n<CR>
nnoremap <Leader>nl :Simplenote -l<CR>
nnoremap <Leader>nw :Simplenote -l work<CR>
nnoremap <Leader>nt :Simplenote -t<CR>
" }}}

" Emmet {{{
" Expand abbreviation
let g:user_emmet_leader_key = ',y'
" }}}

" Startify {{{
let g:startify_bookmarks=[ '~/.vimrc',  '~/.zshrc', '~/.config/awesome/rc.lua' ]
" }}}

" Colors {{{
set t_Co=256

fu! ReverseBackground()
  if &bg=="light"
    se bg=dark
  else
    se bg=light
  endif
endf
com! BgToggle call ReverseBackground()
nm <F12> :BgToggle<CR>


let g:solarized_termcolors=16
if has("gui_running")
  set bg=light
else
  set bg=dark
endif
colorscheme solarized
" }}}

syntax on
filetype plugin indent on

" Filetypes {{{
au BufRead,BufNewFile *.tml set filetype=witango syntax=html
au BufRead,BufNewFile *.phtml set filetype=php
au BufRead,BufNewFile *.php.*tmp set filetype=php syntax=php
au BufRead,BufNewFile *.phtml.*tmp set filetype=php syntax=php
au BufRead *.tml,*.taf silent! %s//\r/g | setlocal foldmethod=manual |
  \ setlocal noexpandtab | map <Leader>h :set syntax=html<CR>

aug Python
  au!
  au FileType python set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
aug END
let g:python_highlight_all=1

aug PHP
  "au FileType php setlocal fdm=marker fmr={{{,}}}
aug END

aug Java
  au FileType java setlocal fdm=marker fmr={,}
aug END
" }}}

" Commands {{{

" Edit temporary SQL files {{{
let s:curr_sql = 0
fun! <SID>EditSqlTempFile()
  let l:fname = '/tmp/q' . s:curr_sql . '.sql'
  execute 'edit' l:fname
  let s:curr_sql = s:curr_sql + 1
endfun
com! EditSqlTempFile call <SID>EditSqlTempFile()
nnoremap <Leader>el :EditSqlTempFile<CR>
" }}}

" Double Indentation
com! -range DoubleIndentation <line1>,<line2>s/^\(\s.\{-}\)\(\S\)/\1\1\2/

" }}}

" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows. {{{
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
" }}}

" Sudo write {{{
command! Ws w !sudo tee >/dev/null %
" }}}

" Leader commands {{{

" Edit specific files {{{
nnoremap <silent> <leader>ev :split $MYVIMRC<CR>
nnoremap <silent> <leader>eb :split ~/.vim_bundles<CR>
nnoremap <silent> <leader>es :UltiSnipsEdit<CR>

nnoremap <silent> <leader>sv :so $MYVIMRC<CR>
nnoremap <silent> <leader>sb :so ~/.vim_bundles<CR>

nnoremap <Leader>et :Simplenote -o todo
nnoremap <Leader>en :split ~/notes.txt<CR>:set filetype=todo<CR>
" }}}

" Edit on servers {{{
" The following commands will only work if the cwd is
" /Library/WebServer/communityos, which it usually is
nnoremap <Leader>ec :e scp://vladmin@coral.vladmin.net//Library/WebServer/communityos/%<CR>
nnoremap <Leader>ep :e scp://vladmin@pacific.vladmin.net//Library/WebServer/communityos/%<CR>
" }}}

" Leader commands to run projects {{{
nnoremap <leader>py :!cd `dirname %` && python `basename %`<CR>
nnoremap <leader>fc :!urxvtc --hide-menubar
      \ --working-directory=/home/smith/code/fredchat/src/client
      \ -e "python fredchat.py"<CR>
" }}}

" Toggle navigation panels {{{
nnoremap <leader>f :NERDTreeToggle<CR>
nnoremap <Leader>l :TagbarToggle<CR>
nnoremap <Leader>mb :MBEToggle<CR>
nnoremap <Leader>u :GundoToggle<CR>

nnoremap <Leader>t :CtrlP<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>a :CtrlPTag<CR>
nnoremap <Leader>r :CtrlPGitBranch<CR>
" }}}

" Leader commands to save sessions {{{
nnoremap <leader>sc :SSave cos<CR>y
nnoremap <leader>sf :SSave fredchat<CR>y
" }}}

" Leader commands to cd {{{
nnoremap <Leader>.. :cd ..
nnoremap <leader>cos :cd ~/code/cos<CR>
nnoremap <leader>fcr :cd ~/code/fredchat/src<CR>
nnoremap <leader>fcc :cd ~/code/fredchat/src/client<CR>
" }}}

" Git leader commands {{{
noremap <Leader>g :Git 
noremap <Leader>s :Gstatus<CR>
noremap <Leader>cv :Gcommit --verbose<CR>

nnoremap <Leader>dl :diffg LOCAL<CR>
nnoremap <Leader>dr :diffg REMOTE<CR>
nnoremap <Leader>db :diffg BASE<CR>
nnoremap <Leader>du :diffu<CR>

nnoremap <Leader>d2 :diffg //2<CR>:diffu<CR>
nnoremap <Leader>d3 :diffg //3<CR>:diffu<CR>

nnoremap <Leader>yt :SignifyToggle<CR>
" }}}

" Breakpoint Leader Commands {{{
nnoremap <Leader>x :Breakpoint<CR>
nnoremap <Leader>dx :BreakpointRemove *<CR>
" }}}

" Toggle options {{{
map <Leader><TAB> :set expandtab!<CR>:set expandtab?<CR>
map <Leader>n :set relativenumber!<CR>:set relativenumber?<CR>
" }}}

" Tabularize {{{
"if exists(":Tabularize")
if 0 == 1 " These are all broken
  " Leader Commands {{{
  nnoremap <Leader>t= :Tabularize /=<CR>
  vmap <Leader>t= :Tabularize /=<CR>

  nnoremap <Leader>t=> :Tabularize /=><CR>
  vmap <Leader>t=> :Tabularize /=><CR>
  " }}}

  " => Aligning {{{
  inoremap <buffer><silent> => =><Esc>:call <SID>arrayalign()<CR>a
  function! s:arrayalign()
    let p = '^.*=>\s.*$'
    if exists(':Tabularize') && getline('.') =~# '^.*=>' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
      let column = strlen(substitute(getline('.')[0:col('.')],'[^=>]','','g'))
      let position = strlen(matchstr(getline('.')[0:col('.')],'.*=>\s*\zs.*'))
      Tabularize/=>/l1
      normal! 0
      call search(repeat('[^=>]*=>',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
  endfunction
  " }}}

  " = Aligning {{{
  inoremap <buffer><silent> = =<Esc>:call <SID>arrayalign()<CR>a
  function! s:arrayalign()
    let p = '^.*=\s.*$'
    if exists(':Tabularize') && getline('.') =~# '^.*=' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
      let column = strlen(substitute(getline('.')[0:col('.')],'[^=]','','g'))
      let position = strlen(matchstr(getline('.')[0:col('.')],'.*=\s*\zs.*'))
      Tabularize/=/l1
      normal! 0
      call search(repeat('[^=]*=',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
  endfunction
  " }}}

  " : Aligning {{{
  inoremap <buffer><silent> : :<Esc>:call <SID>arrayalign()<CR>a
  function! s:arrayalign()
    let p : '^.*:\s.*$'
    if exists(':Tabularize') && getline('.') :~# '^.*:' && (getline(line('.')-1) :~# p || getline(line('.')+1) :~# p)
      let column : strlen(substitute(getline('.')[0:col('.')],'[^:]','','g'))
      let position : strlen(matchstr(getline('.')[0:col('.')],'.*:\s*\zs.*'))
      Tabularize/:/l1
      normal! 0
      call search(repeat('[^:]*:',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
  endfunction
  " }}}

endif
" }}}

" }}}

" Navigate buffers {{{
nnoremap gb :bn<CR>
nnoremap gB :bp<CR>
" }}}

" Window Navigation {{{
noremap ;w <C-w>
noremap ;h <C-w>h
noremap ;j <C-w>j
noremap ;k <C-w>k
noremap ;l <C-w>l
noremap ;z <C-w>z
" }}}

" Change cursor on various terminals {{{
if &term =~ "^rxvt"
  " use an orange cursor in insert mode
  "let &t_SI = "\<Esc>]12;orange\x7"
  " use a red cursor otherwise
  "let &t_EI = "\<Esc>]12;red\x7"
  "silent !echo -ne "\033]12;red\007"
  " reset cursor when vim exits
  "autocmd VimLeave * silent !echo -ne "\033]112\007"
elseif &term =~ '^xterm'
  " solid vertical bar
  let &t_SI .= "\<Esc>[6 q"
  " solid block
  let &t_EI .= "\<Esc>[2 q"
  " 1 or 0 -> blinking block
  " 3 -> blinking underscore
  " Recent versions of xterm (282 or above) also support
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar
endif
" }}} Change cursor on various terminals

" Remove trailing whitespace {{{
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun
autocmd FileType c,cpp,java,php,ruby,python,sql,javascript,sh,jst
  \ autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
" }}}

" No bell {{{
autocmd GUIEnter * set visualbell t_vb=
" }}}

