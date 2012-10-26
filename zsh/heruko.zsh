# http://blog.railsonfire.com/2012/05/29/Effective-Heroku.html

function h { heroku ${@:1:($#-1)} --app ${@: -1} ; }
function hp { h $@ production_app_name ; }
function hs { h $@ staging_app_name ; }

alias hpc="hp run console"
alias hsc="hs run console"

alias hpl="hp logs -t"
alias hsl="hs logs -t"
