augroup filetypedetect
    " Mail
    au BufRead,BufNewFile *mutt-*
        \ :set ft=mail |
        \ :set spell |
        \ :set tw=72 |
        \ :set wrap |
        \ :set nonumber |
        \ :set nocursorline |
augroup END
