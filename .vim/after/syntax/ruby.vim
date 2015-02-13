"
" let s:bcs = b:current_syntax
" unlet b:current_syntax
" syntax include @SQL syntax/sql.vim
" syntax include @HTML syntax/html.vim
" let b:current_syntax = s:bcs
"
" syntax region rubyHereDocSQL matchgroup=Statement start=+<<\z(SQL\)+ end=+^\z1$+ contains=@SQL
" syntax region rubyHereDocDashSQL matchgroup=Statement start=+<<-\z(SQL\)+ end=+\s\+\z1$+ contains=@SQL
" syntax region rubyHereDocHTML matchgroup=Statement start=+<<\z(HTML\)+ end=+^\z1$+ contains=@HTML
" syntax region rubyHereDocDashHTML matchgroup=Statement start=+<<-\z(HTML\)+ end=+\s\+\z1$+ contains=@HTML
