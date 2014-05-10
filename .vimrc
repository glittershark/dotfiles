" vim:set fdm=marker fmr={{{,}}} ts=2 sts=2 sw=2 expandtab:

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
"set backupdir=./.backup,.,/tmp
" set directory=./.backup,.,/tmp
set foldmarker={{{,}}}
set colorcolumn=+0
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

" IndentLine {{{
let g:indentLine_char = '│'
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
let g:UltiSnipsExpandTrigger = '<c-enter>'
   "g:UltiSnipsJumpForwardTrigger          <c-j>
   "g:UltiSnipsJumpBackwardTrigger         <c-k>
" }}}

" VDebug Options {{{
let g:vdebug_options = {'server': '192.168.56.1'}
" }}}

" VimPipe Commands {{{
" let g:sql_type_default = 'pgsql'
command! SqlVbox     let b:vimpipe_command='ssh vladmin@cos.dev "psql cos cosadmin"'
command! SqlVbox2    let b:vimpipe_command='ssh vladmin@cos.dev "psql os000 os000"'
command! SqlCoral2   let b:vimpipe_command='ssh vladmin@coral.vladmin.net "psql -p 25432 os000 os000"'
command! SqlTest     let b:vimpipe_command='ssh vladmin@coral.vladmin.net "psql -p 5434 cos cosadmin"'
command! SqlStage    let b:vimpipe_command='ssh vladmin@coral.vladmin.net "psql -p 5432 cos cosadmin"'
command! SqlCalculon let b:vimpipe_command='ssh vladmin@calculon.vladmin.net "psql cos cosadmin"'
command! SqlFlexo    let b:vimpipe_command='ssh vladmin@flexo.vladmin.net "psql cos cosadmin"'
command! SqlMario    let b:vimpipe_command='ssh vladmin@mario.vladmin.net "psql cos cosadmin"'
command! SqlLuigi    let b:vimpipe_command='ssh vladmin@luigi.vladmin.net "psql cos cosadmin"'
command! SqlGingr    let b:vimpipe_command='ssh root@dev-prod.gingrapp.com "mysql -h 420cb6798696916123a55c93b903198fbfe4f498.rackspaceclouddb.com -u gingr-dev-prod -pXZyMsNDv gingr-dev-prod"'
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

fun! <SID>EndCodeReview()
  let &guifont = GetFontName() . ' 9'
endfun
com! EndCodeReview call <SID>EndCodeReview()
" }}}

" DetectIndent {{{
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
let g:user_emmet_leader_key = ',z'
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
let g:abolish_save_file = '~/.vim/after/plugin/abolish.vim'
" }}}

" Mustache/Handlebars {{{
let g:mustache_abbreviations = 1
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
  "au FileType php setlocal fdm=marker fmr={{{,}}}
aug END

aug Java
  au FileType java setlocal fdm=marker fmr={,}
aug END
" }}}

" Navigate buffers {{{
nnoremap gb :bn<CR>
nnoremap gB :bp<CR>
" }}}

" Window Navigation {{{
nnoremap ;w <C-w>
nnoremap ;h <C-w>h
nnoremap ;j <C-w>j
nnoremap ;k <C-w>k
nnoremap ;l <C-w>l
nnoremap ;z <C-w>z
nnoremap ;; ;
" }}}

" Remove trailing whitespace {{{
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

augroup striptrailingwhitespaces " {{{
autocmd FileType c,cpp,java,php,ruby,python,sql,javascript,sh,jst,less,haskell
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

command! TODOGenerateTable r !curl -sk 'https://cos2-test.cos.dev/formbuilder/admin/fieldsettablegenerator' -H 'Accept: */*' -H 'Referer: https://cos2-test.cos.dev/formbuilder/admin/fieldsettablegenerator' -H 'Origin: https://cos2-test.cos.dev' -H 'X-Requested-With: XMLHttpRequest' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.70 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' --data 'parent_fieldset=settings&dependent_fieldset=&field_1_name=&field_1_constraints=&field_1_class=&field_1_default_label=&field_1_default_note=&field_1_default_form_ctrl=&field_1_default_search_ctrl=&field_2_name=&field_2_constraints=&field_2_class=&field_2_default_label=&field_2_default_note=&field_2_default_form_ctrl=&field_2_default_search_ctrl=&field_3_name=&field_3_constraints=&field_3_class=&field_3_default_label=&field_3_default_note=&field_3_default_form_ctrl=&field_3_default_search_ctrl=&field_4_name=&field_4_constraints=&field_4_class=&field_4_default_label=&field_4_default_note=&field_4_default_form_ctrl=&field_4_default_search_ctrl=&field_5_name=&field_5_constraints=&field_5_class=&field_5_default_label=&field_5_default_note=&field_5_default_form_ctrl=&field_5_default_search_ctrl=&field_6_name=&field_6_constraints=&field_6_class=&field_6_default_label=&field_6_default_note=&field_6_default_form_ctrl=&field_6_default_search_ctrl=&field_7_name=&field_7_constraints=&field_7_class=&field_7_default_label=&field_7_default_note=&field_7_default_form_ctrl=&field_7_default_search_ctrl=&field_8_name=&field_8_constraints=&field_8_class=&field_8_default_label=&field_8_default_note=&field_8_default_form_ctrl=&field_8_default_search_ctrl=&field_9_name=&field_9_constraints=&field_9_class=&field_9_default_label=&field_9_default_note=&field_9_default_form_ctrl=&field_9_default_search_ctrl=&field_10_name=&field_10_constraints=&field_10_class=&field_10_default_label=&field_10_default_note=&field_10_default_form_ctrl=&field_10_default_search_ctrl=&field_11_name=&field_11_constraints=&field_11_class=&field_11_default_label=&field_11_default_note=&field_11_default_form_ctrl=&field_11_default_search_ctrl=&field_12_name=&field_12_constraints=&field_12_class=&field_12_default_label=&field_12_default_note=&field_12_default_form_ctrl=&field_12_default_search_ctrl=&field_13_name=&field_13_constraints=&field_13_class=&field_13_default_label=&field_13_default_note=&field_13_default_form_ctrl=&field_13_default_search_ctrl=&field_14_name=&field_14_constraints=&field_14_class=&field_14_default_label=&field_14_default_note=&field_14_default_form_ctrl=&field_14_default_search_ctrl=&field_15_name=&field_15_constraints=&field_15_class=&field_15_default_label=&field_15_default_note=&field_15_default_form_ctrl=&field_15_default_search_ctrl=&field_16_name=&field_16_constraints=&field_16_class=&field_16_default_label=&field_16_default_note=&field_16_default_form_ctrl=&field_16_default_search_ctrl=&field_17_name=&field_17_constraints=&field_17_class=&field_17_default_label=&field_17_default_note=&field_17_default_form_ctrl=&field_17_default_search_ctrl=&field_18_name=&field_18_constraints=&field_18_class=&field_18_default_label=&field_18_default_note=&field_18_default_form_ctrl=&field_18_default_search_ctrl=&field_19_name=&field_19_constraints=&field_19_class=&field_19_default_label=&field_19_default_note=&field_19_default_form_ctrl=&field_19_default_search_ctrl=&field_20_name=&field_20_constraints=&field_20_class=&field_20_default_label=&field_20_default_note=&field_20_default_form_ctrl=&field_20_default_search_ctrl=&field_21_name=&field_21_constraints=&field_21_class=&field_21_default_label=&field_21_default_note=&field_21_default_form_ctrl=&field_21_default_search_ctrl=&field_22_name=&field_22_constraints=&field_22_class=&field_22_default_label=&field_22_default_note=&field_22_default_form_ctrl=&field_22_default_search_ctrl=&field_23_name=&field_23_constraints=&field_23_class=&field_23_default_label=&field_23_default_note=&field_23_default_form_ctrl=&field_23_default_search_ctrl=&field_24_name=&field_24_constraints=&field_24_class=&field_24_default_label=&field_24_default_note=&field_24_default_form_ctrl=&field_24_default_search_ctrl=&field_25_name=&field_25_constraints=&field_25_class=&field_25_default_label=&field_25_default_note=&field_25_default_form_ctrl=&field_25_default_search_ctrl=&field_26_name=&field_26_constraints=&field_26_class=&field_26_default_label=&field_26_default_note=&field_26_default_form_ctrl=&field_26_default_search_ctrl=&field_27_name=&field_27_constraints=&field_27_class=&field_27_default_label=&field_27_default_note=&field_27_default_form_ctrl=&field_27_default_search_ctrl=&field_28_name=&field_28_constraints=&field_28_class=&field_28_default_label=&field_28_default_note=&field_28_default_form_ctrl=&field_28_default_search_ctrl=&field_29_name=&field_29_constraints=&field_29_class=&field_29_default_label=&field_29_default_note=&field_29_default_form_ctrl=&field_29_default_search_ctrl=&field_30_name=&field_30_constraints=&field_30_class=&field_30_default_label=&field_30_default_note=&field_30_default_form_ctrl=&field_30_default_search_ctrl=&field_31_name=&field_31_constraints=&field_31_class=&field_31_default_label=&field_31_default_note=&field_31_default_form_ctrl=&field_31_default_search_ctrl=&field_32_name=&field_32_constraints=&field_32_class=&field_32_default_label=&field_32_default_note=&field_32_default_form_ctrl=&field_32_default_search_ctrl=&field_33_name=&field_33_constraints=&field_33_class=&field_33_default_label=&field_33_default_note=&field_33_default_form_ctrl=&field_33_default_search_ctrl=&field_34_name=&field_34_constraints=&field_34_class=&field_34_default_label=&field_34_default_note=&field_34_default_form_ctrl=&field_34_default_search_ctrl=&field_35_name=&field_35_constraints=&field_35_class=&field_35_default_label=&field_35_default_note=&field_35_default_form_ctrl=&field_35_default_search_ctrl=&field_36_name=&field_36_constraints=&field_36_class=&field_36_default_label=&field_36_default_note=&field_36_default_form_ctrl=&field_36_default_search_ctrl=&field_37_name=&field_37_constraints=&field_37_class=&field_37_default_label=&field_37_default_note=&field_37_default_form_ctrl=&field_37_default_search_ctrl=&field_38_name=&field_38_constraints=&field_38_class=&field_38_default_label=&field_38_default_note=&field_38_default_form_ctrl=&field_38_default_search_ctrl=&field_39_name=&field_39_constraints=&field_39_class=&field_39_default_label=&field_39_default_note=&field_39_default_form_ctrl=&field_39_default_search_ctrl=&field_40_name=&field_40_constraints=&field_40_class=&field_40_default_label=&field_40_default_note=&field_40_default_form_ctrl=&field_40_default_search_ctrl=&field_41_name=&field_41_constraints=&field_41_class=&field_41_default_label=&field_41_default_note=&field_41_default_form_ctrl=&field_41_default_search_ctrl=&field_42_name=&field_42_constraints=&field_42_class=&field_42_default_label=&field_42_default_note=&field_42_default_form_ctrl=&field_42_default_search_ctrl=&field_43_name=&field_43_constraints=&field_43_class=&field_43_default_label=&field_43_default_note=&field_43_default_form_ctrl=&field_43_default_search_ctrl=&field_44_name=&field_44_constraints=&field_44_class=&field_44_default_label=&field_44_default_note=&field_44_default_form_ctrl=&field_44_default_search_ctrl=&field_45_name=&field_45_constraints=&field_45_class=&field_45_default_label=&field_45_default_note=&field_45_default_form_ctrl=&field_45_default_search_ctrl=&field_46_name=&field_46_constraints=&field_46_class=&field_46_default_label=&field_46_default_note=&field_46_default_form_ctrl=&field_46_default_search_ctrl=&field_47_name=&field_47_constraints=&field_47_class=&field_47_default_label=&field_47_default_note=&field_47_default_form_ctrl=&field_47_default_search_ctrl=&field_48_name=&field_48_constraints=&field_48_class=&field_48_default_label=&field_48_default_note=&field_48_default_form_ctrl=&field_48_default_search_ctrl=&field_49_name=&field_49_constraints=&field_49_class=&field_49_default_label=&field_49_default_note=&field_49_default_form_ctrl=&field_49_default_search_ctrl=&field_50_name=&field_50_constraints=&field_50_class=&field_50_default_label=&field_50_default_note=&field_50_default_form_ctrl=&field_50_default_search_ctrl=&field_51_name=&field_51_constraints=&field_51_class=&field_51_default_label=&field_51_default_note=&field_51_default_form_ctrl=&field_51_default_search_ctrl=&field_52_name=&field_52_constraints=&field_52_class=&field_52_default_label=&field_52_default_note=&field_52_default_form_ctrl=&field_52_default_search_ctrl=&field_53_name=&field_53_constraints=&field_53_class=&field_53_default_label=&field_53_default_note=&field_53_default_form_ctrl=&field_53_default_search_ctrl=&field_54_name=&field_54_constraints=&field_54_class=&field_54_default_label=&field_54_default_note=&field_54_default_form_ctrl=&field_54_default_search_ctrl=&field_55_name=&field_55_constraints=&field_55_class=&field_55_default_label=&field_55_default_note=&field_55_default_form_ctrl=&field_55_default_search_ctrl=&field_56_name=&field_56_constraints=&field_56_class=&field_56_default_label=&field_56_default_note=&field_56_default_form_ctrl=&field_56_default_search_ctrl=&field_57_name=&field_57_constraints=&field_57_class=&field_57_default_label=&field_57_default_note=&field_57_default_form_ctrl=&field_57_default_search_ctrl=&field_58_name=&field_58_constraints=&field_58_class=&field_58_default_label=&field_58_default_note=&field_58_default_form_ctrl=&field_58_default_search_ctrl=&field_59_name=&field_59_constraints=&field_59_class=&field_59_default_label=&field_59_default_note=&field_59_default_form_ctrl=&field_59_default_search_ctrl=&field_60_name=&field_60_constraints=&field_60_class=&field_60_default_label=&field_60_default_note=&field_60_default_form_ctrl=&field_60_default_search_ctrl=&field_61_name=&field_61_constraints=&field_61_class=&field_61_default_label=&field_61_default_note=&field_61_default_form_ctrl=&field_61_default_search_ctrl=&field_62_name=&field_62_constraints=&field_62_class=&field_62_default_label=&field_62_default_note=&field_62_default_form_ctrl=&field_62_default_search_ctrl=&field_63_name=&field_63_constraints=&field_63_class=&field_63_default_label=&field_63_default_note=&field_63_default_form_ctrl=&field_63_default_search_ctrl=&field_64_name=&field_64_constraints=&field_64_class=&field_64_default_label=&field_64_default_note=&field_64_default_form_ctrl=&field_64_default_search_ctrl=&field_65_name=&field_65_constraints=&field_65_class=&field_65_default_label=&field_65_default_note=&field_65_default_form_ctrl=&field_65_default_search_ctrl=&field_66_name=&field_66_constraints=&field_66_class=&field_66_default_label=&field_66_default_note=&field_66_default_form_ctrl=&field_66_default_search_ctrl=&field_67_name=&field_67_constraints=&field_67_class=&field_67_default_label=&field_67_default_note=&field_67_default_form_ctrl=&field_67_default_search_ctrl=&field_68_name=&field_68_constraints=&field_68_class=&field_68_default_label=&field_68_default_note=&field_68_default_form_ctrl=&field_68_default_search_ctrl=&field_69_name=&field_69_constraints=&field_69_class=&field_69_default_label=&field_69_default_note=&field_69_default_form_ctrl=&field_69_default_search_ctrl=&field_70_name=&field_70_constraints=&field_70_class=&field_70_default_label=&field_70_default_note=&field_70_default_form_ctrl=&field_70_default_search_ctrl=&field_71_name=&field_71_constraints=&field_71_class=&field_71_default_label=&field_71_default_note=&field_71_default_form_ctrl=&field_71_default_search_ctrl=&field_72_name=&field_72_constraints=&field_72_class=&field_72_default_label=&field_72_default_note=&field_72_default_form_ctrl=&field_72_default_search_ctrl=&field_73_name=&field_73_constraints=&field_73_class=&field_73_default_label=&field_73_default_note=&field_73_default_form_ctrl=&field_73_default_search_ctrl=&field_74_name=&field_74_constraints=&field_74_class=&field_74_default_label=&field_74_default_note=&field_74_default_form_ctrl=&field_74_default_search_ctrl=&field_75_name=&field_75_constraints=&field_75_class=&field_75_default_label=&field_75_default_note=&field_75_default_form_ctrl=&field_75_default_search_ctrl=&field_76_name=&field_76_constraints=&field_76_class=&field_76_default_label=&field_76_default_note=&field_76_default_form_ctrl=&field_76_default_search_ctrl=&field_77_name=&field_77_constraints=&field_77_class=&field_77_default_label=&field_77_default_note=&field_77_default_form_ctrl=&field_77_default_search_ctrl=&field_78_name=&field_78_constraints=&field_78_class=&field_78_default_label=&field_78_default_note=&field_78_default_form_ctrl=&field_78_default_search_ctrl=&field_79_name=&field_79_constraints=&field_79_class=&field_79_default_label=&field_79_default_note=&field_79_default_form_ctrl=&field_79_default_search_ctrl=&field_80_name=&field_80_constraints=&field_80_class=&field_80_default_label=&field_80_default_note=&field_80_default_form_ctrl=&field_80_default_search_ctrl=&field_81_name=&field_81_constraints=&field_81_class=&field_81_default_label=&field_81_default_note=&field_81_default_form_ctrl=&field_81_default_search_ctrl=&field_82_name=&field_82_constraints=&field_82_class=&field_82_default_label=&field_82_default_note=&field_82_default_form_ctrl=&field_82_default_search_ctrl=&field_83_name=&field_83_constraints=&field_83_class=&field_83_default_label=&field_83_default_note=&field_83_default_form_ctrl=&field_83_default_search_ctrl=&field_84_name=&field_84_constraints=&field_84_class=&field_84_default_label=&field_84_default_note=&field_84_default_form_ctrl=&field_84_default_search_ctrl=&field_85_name=&field_85_constraints=&field_85_class=&field_85_default_label=&field_85_default_note=&field_85_default_form_ctrl=&field_85_default_search_ctrl=&field_86_name=&field_86_constraints=&field_86_class=&field_86_default_label=&field_86_default_note=&field_86_default_form_ctrl=&field_86_default_search_ctrl=&field_87_name=&field_87_constraints=&field_87_class=&field_87_default_label=&field_87_default_note=&field_87_default_form_ctrl=&field_87_default_search_ctrl=&field_88_name=&field_88_constraints=&field_88_class=&field_88_default_label=&field_88_default_note=&field_88_default_form_ctrl=&field_88_default_search_ctrl=&field_89_name=&field_89_constraints=&field_89_class=&field_89_default_label=&field_89_default_note=&field_89_default_form_ctrl=&field_89_default_search_ctrl=&field_90_name=&field_90_constraints=&field_90_class=&field_90_default_label=&field_90_default_note=&field_90_default_form_ctrl=&field_90_default_search_ctrl=&field_91_name=&field_91_constraints=&field_91_class=&field_91_default_label=&field_91_default_note=&field_91_default_form_ctrl=&field_91_default_search_ctrl=&field_92_name=&field_92_constraints=&field_92_class=&field_92_default_label=&field_92_default_note=&field_92_default_form_ctrl=&field_92_default_search_ctrl=&field_93_name=&field_93_constraints=&field_93_class=&field_93_default_label=&field_93_default_note=&field_93_default_form_ctrl=&field_93_default_search_ctrl=&field_94_name=&field_94_constraints=&field_94_class=&field_94_default_label=&field_94_default_note=&field_94_default_form_ctrl=&field_94_default_search_ctrl=&field_95_name=&field_95_constraints=&field_95_class=&field_95_default_label=&field_95_default_note=&field_95_default_form_ctrl=&field_95_default_search_ctrl=&field_96_name=&field_96_constraints=&field_96_class=&field_96_default_label=&field_96_default_note=&field_96_default_form_ctrl=&field_96_default_search_ctrl=&field_97_name=&field_97_constraints=&field_97_class=&field_97_default_label=&field_97_default_note=&field_97_default_form_ctrl=&field_97_default_search_ctrl=&field_98_name=&field_98_constraints=&field_98_class=&field_98_default_label=&field_98_default_note=&field_98_default_form_ctrl=&field_98_default_search_ctrl=&field_99_name=&field_99_constraints=&field_99_class=&field_99_default_label=&field_99_default_note=&field_99_default_form_ctrl=&field_99_default_search_ctrl=&field_100_name=&field_100_constraints=&field_100_class=&field_100_default_label=&field_100_default_note=&field_100_default_form_ctrl=&field_100_default_search_ctrl=&tab_fields=&use_audit_schema=on' --compressed

" }}}

" Autocommands {{{

augroup fugitive " {{{
  au!
  autocmd BufNewFile,BufRead fugitive://* set bufhidden=delete
augroup END " }}}

augroup omni " {{{
  au!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=tern#Complete
  "autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType php setlocal omnifunc=
augroup END " }}}

augroup sql " {{{
  au!
  autocmd FileType sql                 let b:vimpipe_command="ssh vladmin@cos.dev 'psql cos cosadmin'"
  autocmd FileType sql                 let b:vimpipe_filetype="postgresql"
  autocmd FileType sql                 set syntax=postgresql
  autocmd FileType postgresql          set nowrap
  autocmd BufNewFile,BufReadPost *.sql set syntax=pgsql
augroup END " }}}

augroup markdown " {{{
  au!
  autocmd FileType markdown let b:vimpipe_command='markdown'
  autocmd FileType markdown let b:vimpipe_filetype='html'
augroup END " }}}

augroup typescript " {{{
  au!
  autocmd FileType typescript let b:vimpipe_command='tsc'
  autocmd FileType typescript let b:vimpipe_filetype='javascript'
  autocmd FileType typescript TSSstarthere
  autocmd FileType typescript nnoremap <buffer> gd TSSdef
augroup END " }}}

augroup detectindent " {{{
  au!
  autocmd BufReadPost * DetectIndent
augroup END " }}}

augroup jsx " {{{
  au!
  autocmd FileType jsx set syntax=javascript
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

" Comment current line (makes commentary.vim behave like nerdcommenter,
" because my muscle memory is stubborn)
nmap <leader>cc gcc

" Edit on servers {{{
" The following commands will only work if the cwd is
" /Library/WebServer/communityos, which it usually is
nnoremap <Leader>ec :e scp://vladmin@coral.vladmin.net//Library/WebServer/communityos/%<CR>
nnoremap <Leader>ep :e scp://vladmin@pacific.vladmin.net//Library/WebServer/communityos/%<CR>
" }}}

" Toggle navigation panels {{{
nnoremap <leader>f :NERDTreeToggle<CR>
nnoremap <Leader>l :TagbarToggle<CR>
nnoremap <Leader>mb :MBEToggle<CR>
nnoremap <Leader>u :GundoToggle<CR>

nnoremap <Leader>t :CtrlP<CR>
" let's try this one out
nnoremap - :CtrlP<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>a :CtrlPTag<CR>
nnoremap <Leader>r :CtrlPGitBranch<CR>
" }}}

" Leader commands to cd {{{
nnoremap <Leader>.. :cd ..
nnoremap <leader>cos :cd ~/code/cos<CR>
nnoremap <leader>fcr :cd ~/code/fredchat/src<CR>
nnoremap <leader>fcc :cd ~/code/fredchat/src/client<CR>
" }}}

" Git leader commands {{{
noremap <Leader>g :Git<SPACE>
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
" }}}
