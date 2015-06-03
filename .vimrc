" vim:set fdm=marker fmr={{{,}}} ts=2 sts=2 sw=2 expandtab:

source ~/.vim_bundles
set rtp+=~/.fzf

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
set undofile
set undodir=~/.vim/undo
set wildignore=*.pyc,*.o,.git
set clipboard=unnamedplus
"set backupdir=./.backup,.,/tmp
" set directory=./.backup,.,/tmp
set foldmarker={{{,}}}
set colorcolumn=+1
set concealcursor=
set formatoptions+=j
" }}}

" GUI options {{{
set go-=m
set go-=T
set go-=r
set go-=L
set go-=e
set guifont=Meslo\ LG\ S\ DZ\ 9
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

" ---------------------------------------------------------------------------

" YouCompleteMe {{{
let g:ycm_semantic_triggers =  {
      \   'c' : ['->', '.'],
      \   'objc' : ['->', '.'],
      \   'ocaml' : ['.', '#'],
      \   'cpp,objcpp' : ['->', '.', '::'],
      \   'perl' : ['->'],
      \   'php' : ['->', '::'],
      \   'cs,java,javascript,d,python,perl6,scala,vb,elixir,go' : ['.'],
      \   'vim' : ['re![_a-zA-Z]+[_\w]*\.'],
      \   'ruby' : ['.', '::'],
      \   'lua' : ['.', ':'],
      \   'erlang' : [':'],
      \   'clojure' : []
      \ }
      " \   'clojure' : ['(', '.', '/', '[']
" }}}

" Tagbar options {{{
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_ctags_bin = '/usr/bin/ctags'
" }}}

" delimitMate options {{{
let g:delimitMate_expand_cr = 1
" }}}

" UltiSnips options {{{
let g:UltiSnipsExpandTrigger = '<c-j>'
   "g:UltiSnipsJumpForwardTrigger          <c-j>
   "g:UltiSnipsJumpBackwardTrigger         <c-k>
" }}}

" VDebug Options {{{
let g:vdebug_options = {'server': '192.168.56.1'}
" }}}

" VimPipe Commands {{{
" let g:sql_type_default = 'pgsql'
command! SqlLive let b:vimpipe_command="vagrant ssh -c '~/mysql'"
command! SqlRails let b:vimpipe_command="bin/rails dbconsole"
command! SqlHeroku let b:vimpipe_command="heroku pg:psql"
" }}}

" Statusline {{{
let g:airline_powerline_fonts=1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

let g:airline#extensions#tagbar#flags = 'f'
let g:ariline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tmuxline#enabled = 0

let g:tmuxline_theme = 'airline'
let g:tmuxline_preset = 'full'

"set statusline=
"set statusline+=%2*[%n%H%M%R%W]%*\              " flags and buf no
"set statusline+=%-40f%<\                        " path
"set statusline+=%=%40{fugitive#statusline()}\   " Vim status
"set statusline+=%1*%y%*%*\                      " file type
"set statusline+=%10((%l,%c)%)\                  " line and column
"set statusline+=%P                              " percentage of file
" }}}

" Code review mode {{{
fun! GetFontName()
  return substitute(&guifont, '^\(.\{-}\)[0-9]*$', '\1', '')
endfun

fun! <SID>CodeReviewMode()
  let &guifont = GetFontName() . ' 15'
endfun
com! CodeReviewMode call <SID>CodeReviewMode()
" }}}

" Syntastic {{{
let g:syntastic_enable_signs = 0

" Python {{{
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_post_args = "--ignore=E101,E223,E224,E301,E302,E303,E501,E701,W,F401,E111,E261"

" }}} 
" Javascript {{{
augroup syntastic_javascript_jsx
  autocmd!
  autocmd BufReadPre,BufNewFile *.js 
        \ let g:syntastic_javascript_checkers = ['jshint']
  autocmd BufReadPre,BufNewFile *.jsx
        \ let g:syntastic_javascript_checkers = ['jsxhint']
augroup END

" }}}
" Haml {{{
let g:syntastic_haml_checkers = ['haml_lint']

" }}}
" Html {{{
let g:syntastic_html_checkers = []

" }}}
" Ruby {{{
let g:syntastic_ruby_checkers = ['rubocop']
" }}}
" SASS/SCSS {{{
let g:syntastic_scss_checkers = ['scss_lint']
" }}}
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

" Evernote {{{
source ~/.evernoterc
" }}}

" Emmet {{{
" Expand abbreviation
let g:user_emmet_leader_key = '<C-y>'
" }}}

" Vimshell {{{
nnoremap <leader>h :VimShell<CR>
let g:vimshell_prompt_expr =
    \ 'escape(fnamemodify(getcwd(), ":~")."%", "\\[]()?! ")." "'
let g:vimshell_prompt_pattern = '^\%(\f\|\\.\)\+% '
" }}}

" Startify {{{
let g:startify_bookmarks=[ '~/.vimrc',  '~/.zshrc' ]
" }}}

" Abolish {{{
let g:abolish_save_file = expand('~/.vim/after/plugin/abolish.vim')
" }}}

" Rails projections {{{

if !exists('g:rails_projections')
  let g:rails_projections = {}
endif

call extend(g:rails_projections, {
      \ "config/routes.rb": { "command": "routes" },
      \ "config/structure.sql": { "command": "structure" }
      \ }, 'keep')

if !exists('g:rails_gem_projections')
  let g:rails_gem_projections = {}
endif

call extend(g:rails_gem_projections, {
      \ "active_model_serializers": {
      \   "app/serializers/*_serializer.rb": {
      \     "command": "serializer",
      \     "template": "class %SSerializer < ActiveModel::Serializer\nend",
      \     "affinity": "model"}},
      \ "react-rails": {
      \   "app/assets/javascripts/components/*.jsx": {
      \     "command": "component",
      \     "template": "var %S = window.%S = React.createClass({\n  render: function() {\n  }\n});",
      \     "alternate": "spec/javascripts/components/%s_spec.jsx" }},
      \ "rspec": {
      \    "spec/**/support/*.rb": {
      \      "command": "support"}},
      \ "cucumber": {
      \   "features/*.feature": {
      \     "command": "feature",
      \     "template": "Feature: %h"},
      \   "features/support/*.rb": {
      \     "command": "support"},
      \   "features/support/env.rb": {
      \     "command": "support"},
      \   "features/step_definitions/*_steps.rb": {
      \     "command": "steps"}},
      \ "carrierwave": {
      \   "app/uploaders/*_uploader.rb": {
      \     "command": "uploader",
      \     "template": "class %SUploader < CarrierWave::Uploader::Base\nend"}},
      \ "draper": {
      \   "app/decorators/*_decorator.rb": {
      \     "command": "decorator",
      \     "affinity": "model",
      \     "template": "class %SDecorator < ApplicationDecorator\nend"}},
      \ "fabrication": {
      \   "spec/fabricators/*_fabricator.rb": {
      \     "command": ["fabricator", "factory"],
      \     "alternate": "app/models/%s.rb",
      \     "related": "db/schema.rb#%p",
      \     "test": "spec/models/%s_spec.rb",
      \     "template": "Fabricator :%s do\nend",
      \     "affinity": "model"}},
      \ "factory_girl": {
      \   "spec/factories/*.rb": {
      \     "command": "factory",
      \     "alternate": "app/models/%i.rb",
      \     "related": "db/structure.sql#%s",
      \     "test": "spec/models/%s_spec.rb",
      \     "template": "FactoryGirl.define do\n  factory :%i do\n  end\nend",
      \     "affinity": "model"},
      \   "spec/factories.rb": {
      \      "command": "factory"},
      \   "test/factories.rb": {
      \      "command": "factory"}}
      \ }, 'keep')
" }}}

" Mustache/Handlebars {{{
let g:mustache_abbreviations = 1
" }}}

" AutoPairs {{{
let g:AutoPairsCenterLine = 0
" }}}

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
  au!
  "au FileType php setlocal fdm=marker fmr={{{,}}}
aug END

aug Java
  au!
  au FileType java setlocal fdm=marker fmr={,}
aug END

aug Mail
  au FileType mail setlocal spell
aug END

" Haskell {{{
let g:haskell_conceal_wide = 1
" }}}

" Ruby {{{
augroup Ruby 
  au!
  " au FileType ruby let b:surround_114 = "\\(module|class,def,if,unless,case,while,until,begin,do) \r end"
  " au FileType ruby set fdm=syntax
  au FileType ruby set tw=80
  au FileType haml set tw=80
augroup END

let ruby_operators = 1
let ruby_space_errors = 1

let g:rubycomplete_rails = 1
command! -range ConvertHashSyntax <line1>,<line2>s/:(\S{-})(\s{-})=> /\1:\2/
" }}}

" Clojure {{{

aug Clojure
  au!
  autocmd FileType clojure nnoremap <C-S> :Slamhound<CR>
  let g:clojure_align_multiline_strings = 1
  let g:clojure_fuzzy_indent_patterns = 
        \ ['^with', '^def', '^let', '^fact']
  let g:clojure_special_indent_words =
        \ 'deftype,defrecord,reify,proxy,extend-type,extend-protocol,letfn,html'

  autocmd FileType clojure setlocal lispwords+=GET,POST,PATCH,PUT,DELETE |
        \ setlocal lispwords+=context
  autocmd BufNewFile,BufReadPost *.cljx setfiletype clojure
  autocmd BufNewFile,BufReadPost *.cljx setlocal omnifunc=
  autocmd BufNewFile,BufReadPost *.cljs setlocal omnifunc=
aug END

command! TangentConnect Connect nrepl://localhost:7888 
      \ ~/code/clojure/tangent/tangent

" }}}
" }}}

" Navigate buffers {{{
nnoremap gb :bn<CR>
nnoremap gB :bp<CR>
" }}}

" Window Navigation {{{
nnoremap <space>w <C-w>
nnoremap <space>h <C-w>h
nnoremap <space>j <C-w>j
nnoremap <space>k <C-w>k
nnoremap <space>l <C-w>l
nnoremap <space>z <C-w>z
" }}}

" Remove trailing whitespace {{{
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

augroup striptrailingwhitespaces " {{{
autocmd FileType c,cpp,java,php,ruby,python,sql,javascript,sh,jst,less,haskell,haml,coffee,scss,clojure
  \ autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
augroup END " }}}

" }}}

"-----------------------------------------------------------------------------

" Commands {{{

" Edit temporary SQL files {{{
let s:curr_sql = 0
fun! <SID>EditSqlTempFile()
  let l:fname = '/tmp/q' . s:curr_sql . '.sql'
  execute 'edit' l:fname
  let s:curr_sql = s:curr_sql + 1
endfun
com! EditSqlTempFile call <SID>EditSqlTempFile()
" }}}

" Double Indentation
command! -range DoubleIndentation <line1>,<line2>s/^\(\s.\{-}\)\(\S\)/\1\1\2/

" Quick-and-dirty fix capitalization of sql files
command! -range FixSqlCapitalization <line1>,<line2>v/\v(^\s*--.*$)|(TG_)/norm guu

" }}}

" Autocommands {{{

augroup fugitive " {{{
  au!
  autocmd BufNewFile,BufRead fugitive://* set bufhidden=delete
augroup END " }}}

augroup omni " {{{
  au!
  autocmd FileType javascript setlocal omnifunc=tern#Complete
  "autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType php setlocal omnifunc=
augroup END " }}}

augroup sql " {{{
  au!
  autocmd FileType sql                 let b:vimpipe_command="psql -h 127.0.0.1 landlordsny_development landlordsny"
  autocmd FileType sql                 let b:vimpipe_filetype="postgresql"
  autocmd FileType sql                 set syntax=postgresql
  autocmd FileType postgresql          set nowrap
  autocmd BufNewFile,BufReadPost *.sql set syntax=pgsql
augroup END " }}}

augroup markdown " {{{
  au!
  autocmd FileType markdown let b:vimpipe_command='markdown'
  autocmd FileType markdown let b:vimpipe_filetype='html'
  autocmd FileType markdown set tw=80
augroup END " }}}

augroup typescript " {{{
  au!
  autocmd FileType typescript let b:vimpipe_command='tsc'
  autocmd FileType typescript let b:vimpipe_filetype='javascript'
  autocmd FileType typescript TSSstarthere
  autocmd FileType typescript nnoremap <buffer> gd :TSSdef<CR>
augroup END " }}}

augroup jsx " {{{
  au!
  " autocmd FileType jsx set syntax=javascript
augroup END " }}}

augroup nicefoldmethod " {{{
  au!
  " Don't screw up folds when inserting text that might affect them, until
  " leaving insert mode. Foldmethod is local to the window. Protect against
  " screwing up folding when switching between windows.
  autocmd InsertEnter *
    \ if !exists('w:last_fdm') |
    \   let w:last_fdm=&foldmethod |
    \   setlocal foldmethod=manual |
    \ endif
  autocmd InsertLeave,WinLeave *
    \ if exists('w:last_fdm') |
    \    let &l:foldmethod=w:last_fdm |
    \    unlet w:last_fdm |
    \ endif
augroup END " }}}

augroup visualbell " {{{
  au!
  autocmd GUIEnter * set visualbell t_vb=
augroup END
" }}}

augroup quickfix " {{{
  au!
  autocmd QuickFixCmdPost grep cwindow
augroup END " }}}

augroup php " {{{
  au!
augroup END  "}}}

augroup rubylang " {{{
  au!
  autocmd FileType ruby compiler rake
augroup END " }}}

augroup javascript "{{{
  au!
  autocmd FileType javascript let &errorformat = 
        \ '%E%.%#%n) %s:,' .
        \ '%C%.%#Error: %m,' .
        \ '%C%.%#at %s (%f:%l:%c),' .
        \ '%Z%.%#at %s (%f:%l:%c),' .
        \ '%-G%.%#,'
augroup END " }}}
  
" }}}

" Leader commands {{{

" Edit specific files {{{
nnoremap <silent> <leader>ev :split $MYVIMRC<CR>
nnoremap <silent> <leader>eb :split ~/.vim_bundles<CR>
nnoremap <silent> <leader>es :UltiSnipsEdit<CR>
nnoremap <silent> <leader>ea :split ~/.vim/after/plugin/abolish.vim<CR>

nnoremap <silent> <leader>sv :so $MYVIMRC<CR>
nnoremap <silent> <leader>sb :so ~/.vim_bundles<CR>
nnoremap <silent> <leader>sa :so ~/.vim/after/plugin/abolish.vim<CR>

nnoremap <Leader>et :Simplenote -o todo<CR>
nnoremap <Leader>en :Simplenote -o notes<CR>

nnoremap <Leader>el :EditSqlTempFile<CR>
" }}}

" Toggle navigation panels {{{
nnoremap <leader>f :NERDTreeToggle<CR>
nnoremap <Leader>l :TagbarToggle<CR>
nnoremap <Leader>mb :MBEToggle<CR>
nnoremap <Leader>u :GundoToggle<CR>

nnoremap <Leader>t :CtrlP<CR>
nnoremap <Leader>z :FZF<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>a :CtrlPTag<CR>
nnoremap <Leader>r :CtrlPGitBranch<CR>
" }}}

" Leader commands to cd {{{
nnoremap <Leader>.. :cd ..
nnoremap <leader>fcr :cd ~/code/fredchat/src<CR>
nnoremap <leader>fcc :cd ~/code/fredchat/src/client<CR>
" }}}

" Git leader commands {{{
noremap <Leader>g :Git<SPACE>
noremap <Leader>gu :Gpull<CR>
noremap <Leader>gp :Gpush<CR>
noremap <Leader>s :Gstatus<CR>
noremap <Leader>cv :Gcommit --verbose<CR>
noremap <Leader>ca :Gcommit --verbose --amend<CR>

nnoremap <Leader>dl :diffg LOCAL<CR>
nnoremap <Leader>dr :diffg REMOTE<CR>
nnoremap <Leader>db :diffg BASE<CR>
nnoremap <Leader>du :diffu<CR>
nnoremap <Leader>dg :diffg<CR>

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
  " Leader Commands {{{
  nnoremap <localleader>t= :Tabularize /=<CR>
  vmap <localleader>t= :Tabularize /=<CR>

  nnoremap <localleader>t> :Tabularize /=><CR>
  vmap <localleader>t> :Tabularize /=><CR>
  " }}}

  " => Aligning {{{
  function! s:rocketalign()
    let l:p = '^.*=>\s.*$'
    echo l:p
    if exists(':Tabularize') && getline('.') =~# '^.*=' &&
                \ (getline(line('.')-1) =~# l:p || getline(line('.')+1) =~# l:p)
      let column = strlen(substitute(getline('.')[0:col('.')],'[^=>]','','g'))
      let position = strlen(matchstr(getline('.')[0:col('.')],'.*=>\s*\zs.*'))
      Tabularize/=>/l1
      normal! $
      call search(repeat('[^=>]*=>',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
  endfunction
  "inoremap <buffer> <space>=><space> =><Esc>:call <SID>rocketalign()<CR>a
  " }}}

  " = Aligning {{{
  function! s:eqalign()
    let l:p = '^.*=\s.*$'
    if exists(':Tabularize') && getline('.') =~# '^.*=' &&
                \ (getline(line('.')-1) =~# l:p || getline(line('.')+1) =~# l:p)
      let column = strlen(substitute(getline('.')[0:col('.')],'[^=]','','g'))
      let position = strlen(matchstr(getline('.')[0:col('.')],'.*=\s*\zs.*'))
      Tabularize/=/l1
      normal! $
      call search(repeat('[^=]*=',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
  endfunction
  "inoremap <buffer><silent> <space>=<space> =<Esc>:call <SID>eqalign()<CR>a
  " }}}

  " : Aligning {{{
  function! s:colonalign()
    let l:p : '^.*:\s.*$'
    if exists(':Tabularize') && getline('.') :~# '^.*:' &&
                \ (getline(line('.')-1) :~# l:p || getline(line('.')+1) :~# l:p)
      let column : strlen(substitute(getline('.')[0:col('.')],'[^:]','','g'))
      let position : strlen(matchstr(getline('.')[0:col('.')],'.*:\s*\zs.*'))
      Tabularize/:/l1
      normal! $
      call search(repeat('[^:]*:',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
  endfunction
  "inoremap <buffer><silent> <space>:<space> :<Esc>:call <SID>colonalign()<CR>a
  " }}}
" }}}

" }}}

" Mappings {{{
" 'delete current'
nnoremap dc 0d$
nnoremap com :silent !tmux set status<CR>
nnoremap <F9> :Dispatch<CR>
inoremap <F9> <ESC>:Dispatch<CR>i

" Sort with motion {{{
if !exists("g:sort_motion_flags")
  let g:sort_motion_flags = ""
endif
function! s:sort_motion(mode) abort
  if a:mode == 'line'
    execute "'[,']sort " . g:sort_motion_flags
  elseif a:mode == 'char'
    execute "normal! `[v`]y"
    let sorted = join(sort(split(@@, ', ')), ', ')
    execute "normal! v`]c" . sorted
  elseif a:mode == 'V' || a:mode == ''
    execute "'<,'>sort " . g:sort_motion_flags
  endif
endfunction

function! s:sort_lines() 
  let beginning = line('.')
  let end = v:count + beginning - 1
  execute beginning . ',' . end . 'sort' 
endfunction

xnoremap <silent> <Plug>SortMotionVisual :<C-U>call <SID>sort_motion(visualmode())<CR>
nnoremap <silent> <Plug>SortMotion :<C-U>set opfunc=<SID>sort_motion<CR>g@
nnoremap <silent> <Plug>SortLines :<C-U>call <SID>sort_lines()<CR>

map go <Plug>SortMotion
vmap go <Plug>SortMotionVisual
map goo <Plug>SortLines
" }}}
" }}}

