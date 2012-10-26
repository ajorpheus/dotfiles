" Ruby Hash
au BufNewFile,BufRead * if getline(1) =~ "^#!" | if getline(1) =~ "ruby" | setf ruby | endif | endif

" Ruby
au BufNewFile,BufRead *.rb,*.rbw,*.gem,*.gemspec set filetype=ruby

" Ruby on Rails
au BufNewFile,BufRead *.builder,*.rxml,*.rjs set filetype=ruby

" Rakefile
au BufNewFile,BufRead [rR]akefile,*.rake set filetype=ruby

" Rantfile
au BufNewFile,BufRead [rR]antfile,*.rant set filetype=ruby

" IRB config
au BufNewFile,BufRead .irbrc set filetype=ruby

" IRB config
au BufNewFile,BufRead .riplrc set filetype=ruby

" Capistrano
au BufNewFile,BufRead Capfile set filetype=ruby

" Bundler
au BufNewFile,BufRead Gemfile set filetype=ruby

" Berkshelf
au BufNewFile,BufRead Berksfile set filetype=ruby

" Autotest
au BufNewFile,BufRead *.autotest set filetype=ruby

" eRuby
au BufNewFile,BufRead *.erb,*.rhtml set filetype=eruby

" God
au BufNewFile,BufRead *.god set filetype=ruby

" BluePill
au BufNewFile,BufRead *.pill set filetype=ruby

" For the MakeGreen plugin and Ruby RSpec. Uncomment to use.
autocmd BufNewFile,BufRead *_spec.rb compiler rspec

" Vagrant
au BufNewFile,BufRead [vV]agrantfile c set filetype=ruby

"Thor
au BufNewFile,BufRead [tT]horfile c set filetype=ruby

"Rackup
au BufNewFile,BufRead config.ru c set filetype=ruby
