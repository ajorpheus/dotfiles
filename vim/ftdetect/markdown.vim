" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} set ai formatoptions=tcroqn2 comments=n:> filetype=markdown

