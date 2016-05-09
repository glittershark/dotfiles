if exists("current_compiler") && current_compiler == "stack"
  finish
endif
let current_compiler = "stack"

setlocal makeprg=stack\ ghc\ --\ -Wall\ -Werror\ -e\ :q\ %
setlocal errorformat=
                    \%-G,
                    \%-Z\ %#,
                    \%W%f:%l:%c:\ Warning:\ %m,
                    \%E%f:%l:%c:\ %m,
                    \%E%>%f:%l:%c:,
                    \%+C\ \ %#%m,
                    \%W%>%f:%l:%c:,
                    \%+C\ \ %#%tarning:\ %m,

" GHC outputs (partially) to stderr
setlocal shellpipe=2>
