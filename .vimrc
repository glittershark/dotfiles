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
set clipboard=unnamed
set backupdir=$HOME/.vim/backup   
set directory=$HOME/.vim/tmp     
set foldmarker={{{,}}}
set colorcolumn=+1
set concealcursor=
set formatoptions+=j
set wildmenu
set wildmode=longest,list:full
set noincsearch
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

set background=light
colorscheme solarized
" }}}

" ---------------------------------------------------------------------------

let g:ctrlp_custom_ignore = {
      \ 'dir': '(node_modules|target)'
      \ }

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
      \   'lua' : ['.', ':'],
      \   'erlang' : [':'],
      \   'clojure' : [],
      \   'haskell' : ['re!.*', '.', ' ', '(']
      \ }
      " \   'haskell' : ['.', '(', ' ']
      " \   'ruby' : ['.', '::'],
      " \   'clojure' : ['(', '.', '/', '[']
" }}}

" Neocomplete {{{
if !has('nvim')
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

  " Define dictionary.
  " let g:neocomplete#sources#dictionary#dictionaries = {
  "     \ 'default' : '',
  "     \ 'vimshell' : $HOME.'/.vimshell_hist',
  "     \ 'scheme' : $HOME.'/.gosh_completions'
  "     \ }

  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
      let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplete#undo_completion()
  inoremap <expr><C-l>     neocomplete#complete_common_string()

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? "\<C-y>" : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  " Close popup by <Space>.
  "inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

  " AutoComplPop like behavior.
  "let g:neocomplete#enable_auto_select = 1

  " Shell like behavior(not recommended).
  "set completeopt+=longest
  "let g:neocomplete#enable_auto_select = 1
  "let g:neocomplete#disable_auto_complete = 1
  "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

  " Enable omni completion.
  " autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  " autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  " autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  " autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  " autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
endif
" }}}

" Deoplete {{{
if has('nvim')
  let g:deoplete#enable_at_startup = 1

  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? "\<C-y>" : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
endif
" }}}

" Neovim Terminal mode {{{
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  nnoremap \\ :tabedit term://zsh<CR>
  nnoremap q\ :call <SID>OpenRepl()<CR>

  if !exists('g:repl_size')
    let g:repl_size=9
  endif

  function! s:OpenRepl() " {{{
    " Check if buffer exists and is open
    if exists('s:repl_bufname') && bufexists(s:repl_bufname) && bufwinnr(s:repl_bufname) >=? 0
      " If so, just switch to it
      execute bufwinnr(s:repl_bufname) . 'wincmd' 'w'
      norm i
      return
    endif

    if !exists('b:console')
      let b:console=$SHELL
    endif

    let l:console_cmd = b:console

    execute 'bot' g:repl_size . 'new'
    set winfixheight nobuflisted
    call termopen(l:console_cmd)
    let s:repl_bufname = bufname('%')
    norm i
  endfunction " }}}
endif
" }}}

" Tagbar options {{{
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
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

" Statusline {{{
let g:airline_powerline_fonts=1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

let g:airline#extensions#tagbar#flags = 'f'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#tab_min_count = 2
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
let g:syntastic_javascript_checkers = ['eslint']
let g:flow#autoclose = 1
let g:flow#enable = 1

" augroup syntastic_javascript_jsx
"   autocmd!
"   autocmd BufReadPre,BufNewFile *.js 
"   autocmd BufReadPre,BufNewFile *.jsx
"         \ let g:syntastic_javascript_checkers = ['jsxhint']
" augroup END

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
" Haskell {{{
" let g:syntastic_haskell_checkers = ['ghc-mod']
" }}}
" Elixir {{{
let g:syntastic_elixir_checkers = ['elixir']
let g:syntastic_enable_elixir_checker = 1
" }}}
" }}}

" Bufferline {{{
let g:bufferline_echo=0
" }}}

" Eclim {{{
let g:EclimCompletionMethod = 'omnifunc'
augroup eclim
  au!
  au FileType java call <SID>JavaSetup()
  au FileType java set textwidth=120
augroup END

function! s:JavaSetup() abort
  noremap <C-I> :JavaImport<CR>
  nnoremap K :JavaDocPreview<CR>
  nnoremap ]d :JavaSearchContext<CR>
  nnoremap [d :JavaSearchContext<CR>
  nnoremap g<CR> :JUnit<CR>
  nnoremap g\ :Mvn test<CR>
endfunction
" }}}

" Signify options {{{
let g:signify_mapping_next_hunk = ']h'
let g:signify_mapping_prev_hunk = '[h'
let g:signify_vcs_list          = ['git']
let g:signify_sign_change       = '~'
let g:signify_sign_delete       = '-'
" }}}

" Simplenote {{{
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
let g:user_emmet_leader_key = '<C-y>'
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
      \     "alternate": "spec/javascripts/components/%s_spec.jsx" },
      \   "spec/javascripts/components/*_spec.jsx": {
      \     "alternate": "app/assets/javascripts/components/{}.jsx" }},
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
      \     "template": "class %SDecorator < Draper::Decorator\nend"}},
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

" Other projections {{{
let g:projectionist_heuristics = {
      \ "config.ru&docker-compose.yml&app/&config/&OWNERS": {
      \   "app/jobs/*.rb": {
      \     "type": "job",
      \     "alternate": "spec/jobs/{}_spec.rb"
      \   },
      \   "app/models/*.rb": {
      \     "type": "model",
      \     "alternate": "spec/models/{}_spec.rb"
      \   },
      \   "app/resources/*_resource.rb": {
      \     "type": "resource",
      \     "alternate": "spec/resources/{}_resource_spec.rb"
      \   },
      \   "config/*.yml": {
      \     "type": "config"
      \   },
      \   "spec/*_spec.rb": {
      \     "type": "spec",
      \     "alternate": "app/{}.rb"
      \   },
      \   "spec/factories/*.rb": {
      \     "type": "factory",
      \   }
      \ },
      \ "svc-gateway.cabal": {
      \   "src/*.hs": {
      \     "type": "src",
      \     "alternate": "test/{}Spec.hs"
      \  },
      \   "test/*Spec.hs": {
      \     "type": "spec",
      \     "alternate": "src/{}.hs",
      \     "template": [
      \       "module Gateway.Resource.HierarchySpec (main, spec) where",
      \       "",
      \       "import Prelude",
      \       "import Test.Hspec",
      \       "import Data.Aeson",
      \       "",
      \       "import Gateway.Resource.Hierarchy",
      \       "",
      \       "main :: IO ()",
      \       "main = hspec spec",
      \       "",
      \       "spec :: Spec",
      \       "spec = do",
      \       "    describe \"something\" $ undefined"
      \    ]
      \  },
      \  "svc-gateway.cabal": {
      \    "type": "cabal"
      \  }
      \ },
      \ "package.json&.flowconfig": {
      \   "src/*.*": {
      \     "type": "src",
      \     "alternate": "test/{}_spec.js"
      \   }
      \ }}
" }}}

" AutoPairs {{{
let g:AutoPairsCenterLine = 0
" }}}

" Filetypes {{{

" Python {{{
aug Python 
  au!
  au FileType python set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
aug END
let g:python_highlight_all=1
" }}}

" PHP {{{
aug PHP
  au!
  "au FileType php setlocal fdm=marker fmr={{{,}}}
aug END " }}}

" Mail {{{
aug Mail 
  au FileType mail setlocal spell
aug END " }}}

" Haskell {{{
let g:haskell_conceal_wide = 1
let g:haskellmode_completion_ghc = 0
let g:necoghc_enable_detailed_browse = 1

augroup Haskell
  autocmd!
  autocmd FileType haskell setlocal textwidth=110 shiftwidth=2
  autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
  autocmd FileType haskell call <SID>HaskellSetup()
  autocmd FileType haskell setlocal keywordprg=hoogle\ -cie
augroup END

function! s:HaskellSetup()
  set sw=4
  " compiler cabal
  " let b:start='cabal run'
  " let b:console='cabal repl'
  " let b:dispatch='cabal test'
  compiler stack
  let b:start='stack run'
  let b:console='stack ghci'
  let b:dispatch='stack test'
  nnoremap <buffer> gy :HdevtoolsType<CR>
  nnoremap <buffer> yu :HdevtoolsClear<CR>
endfunction
" }}}

" Ruby {{{

function! s:RSpecSyntax()
  syn keyword rspecMethod describe context it its specify shared_context 
        \ shared_examples shared_examples_for shared_context include_examples 
        \ include_context it_should_behave_like it_behaves_like before after 
        \ around fixtures controller_name helper_name scenario feature 
        \ background given described_class
  syn match rspecMethod '\<let\>!\='
  syn match rspecMethod '\<subject\>!\='
  syn keyword rspecMethod violated pending expect expect_any_instance_of allow 
        \ allow_any_instance_of double instance_double mock mock_model 
        \ stub_model xit
  syn match rspecMethod '\.\@<!\<stub\>!\@!'

  call s:RSpecHiDefaults()
endfunction

function! s:RSpecHiDefaults()
  hi def link rspecMethod rubyFunction
endfunction

augroup Ruby 
  au!
  " au FileType ruby let b:surround_114 = "\\(module|class,def,if,unless,case,while,until,begin,do) \r end"
  " au FileType ruby set fdm=syntax
  au FileType ruby set tw=110
  au FileType ruby set omnifunc=
  au FileType ruby nnoremap <buffer> gy orequire 'pry'; binding.pry<ESC>^
  au FileType ruby nnoremap <buffer> gY Orequire 'pry'; binding.pry<ESC>^
  au FileType ruby nnoremap <buffer> yu :g/require 'pry'; binding.pry/d<CR> 
  au BufNewFile,BufRead *_spec.rb call <SID>RSpecSyntax()
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
  autocmd FileType clojure call <SID>TangentInit()

aug END

function! s:TangentInit() abort
  set textwidth=80
  command! TReset    call fireplace#session_eval('(user/reset)')
  command! TGo       call fireplace#session_eval('(user/go)')
  command! TMigrate  call fireplace#session_eval('(user/migrate)')
  command! TRollback call fireplace#session_eval('(user/rollback)')
  nnoremap g\ :TReset<CR>
endfunction

" }}}

" Go {{{

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

augroup Go
  autocmd!
  autocmd FileType go setlocal omnifunc=go#complete#Complete
  autocmd FileType go setlocal foldmethod=syntax
  autocmd FileType go setlocal foldlevel=100
  autocmd FileType go nnoremap <buffer> <F9> :GoTest<CR>
  autocmd FileType go inoremap <buffer> <F9> <ESC>:GoTest<CR>i
augroup END

" }}}

" RAML {{{

function! s:buffer_syntax() " {{{
  syn keyword ramlRAML          RAML             contained
  syn match   ramlVersionString '^#%RAML \d\.\d' contains=ramlRAML
endfunction " }}}

augroup RAML
  autocmd!
  autocmd BufRead,BufNewFile *.raml set filetype=yaml
  autocmd BufRead,BufNewFile *.raml call s:buffer_syntax()
augroup END

hi def link ramlVersionString Special
hi def link ramlRAML Error
" }}}

" Mustache/Handlebars {{{
let g:mustache_abbreviations = 1
" }}}

" Netrw {{{
augroup netrw
  autocmd!
  autocmd FileType netrw nnoremap <buffer> Q :Rexplore<CR>

  " Hee hee, oil and vinegar
  function! s:setup_oil() abort
    nnoremap <buffer> q <C-6>
    xnoremap <buffer> q <C-6>
  endfunction
augroup END
" }}}
" }}}

" Remove trailing whitespace {{{
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

augroup striptrailingwhitespaces " {{{
autocmd FileType c,cpp,java,php,ruby,python,javascript,sh,jst,less,haskell,haml,coffee,scss,clojure,objc,elixir,yaml
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

" VimPipe Commands {{{
" let g:sql_type_default = 'pgsql'
command! SqlLive let b:vimpipe_command="vagrant ssh -c '~/mysql'"
command! SqlRails let b:vimpipe_command="bin/rails dbconsole"
command! SqlHeroku let b:vimpipe_command="heroku pg:psql"
command! SqlEntities let b:vimpipe_command="psql -h 127.1 entities nomi"
command! SqlUsers let b:vimpipe_command="psql -h 127.1 users nomi"
" }}}

" Focus dispatch to only the last failures
command! -nargs=* FocusFailures FocusDispatch rspec --only-failures <args>

" }}}

" Autocommands {{{

augroup fugitive " {{{
  au!
  autocmd BufNewFile,BufRead fugitive://* set bufhidden=delete
augroup END " }}}

augroup omni " {{{
  au!
  " autocmd FileType javascript setlocal omnifunc=tern#Complete
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
  autocmd FileType javascript set filetype=javascript.jsx
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
  
augroup git " {{{
  autocmd!
  autocmd FileType gitcommit set textwidth=72
augroup END
" }}}
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

nnoremap <Leader>el :EditSqlTempFile<CR>
" }}}

" Toggle navigation panels {{{
nnoremap <Leader>l :TagbarToggle<CR>
nnoremap <Leader>mb :MBEToggle<CR>
nnoremap <Leader>u :GundoToggle<CR>

nnoremap <Leader>t :CtrlP<CR>
nnoremap <Leader>z :FZF<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>a :CtrlPTag<CR>
nnoremap <Leader>r :CtrlPGitBranch<CR>
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
nnoremap <F9>  :Make<CR>
nnoremap g<CR> :Dispatch<CR>
nnoremap g\ :Start<CR>
inoremap <F9> <ESC>:Make<CR>i

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

let g:hare_executable = 'cabal exec -- ghc-hare'
