#!/usr/bin/env ruby
# encoding: utf-8
# Distributed under the terms of the MIT License
# Copyright (C) 2011 Greg Fitzgerald
# vim: set sw=2 sts=2 et tw=80 :

require 'fileutils'
require 'open-uri'

git_bundles = [
  "https://github.com/chrisbra/CheckAttach.git",
  "https://github.com/ciaranm/detectindent.git",
  "https://github.com/kien/ctrlp.vim.git",
  "https://github.com/tpope/vim-endwise.git",
  "https://github.com/bogado/file-line.git",
  "https://github.com/miripiruni/CSScomb-for-Vim.git",
  "https://github.com/mattn/gist-vim.git",
  "https://github.com/gregsexton/gitv.git",
  "https://github.com/vim-scripts/gnupg.vim",
  "https://github.com/sjl/gundo.vim.git",
  "https://github.com/gregsexton/MatchTag.git",
  "https://github.com/tomtom/tcomment_vim.git",
  "https://github.com/scrooloose/nerdtree.git",
  "https://github.com/chrisbra/NrrwRgn.git",
  "https://github.com/ciaranm/securemodelines.git",
  "https://github.com/AndrewRadev/splitjoin.vim.git",
  "https://github.com/Lokaltog/vim-powerline.git",
  "https://github.com/scrooloose/syntastic.git",
  "https://github.com/godlygeek/tabular.git",
  "https://github.com/ervandew/supertab.git",
  "https://github.com/tomtom/tlib_vim.git",
  "https://github.com/vim-scripts/Toggle.git",
  "https://github.com/tomtom/tskeleton_vim.git",
  "https://github.com/tpope/vim-unimpaired.git",
  "https://github.com/vim-scripts/utl.vim",
  "https://github.com/altercation/vim-colors-solarized.git",
  "https://github.com/int3/vim-extradite.git",
  "https://github.com/tpope/vim-fugitive.git",
  "https://github.com/nathanaelkane/vim-indent-guides.git",
  "https://github.com/michaeljsmith/vim-indent-object.git",
  "https://github.com/xolox/vim-notes.git",
  "https://github.com/tpope/vim-pathogen.git",
  "https://github.com/tpope/vim-rake.git",
  "https://github.com/tpope/vim-surround.git",
  "https://github.com/tpope/vim-unimpaired.git",
  "https://github.com/vim-scripts/Rename2.git",
  "https://github.com/lukaszkorecki/workflowish.git",
  "https://github.com/noahfrederick/Hemisu.git",
  "https://github.com/t9md/vim-chef.git",
  "https://github.com/chrisbra/color_highlight.git",
  "https://github.com/ap/vim-css-color.git",
  "https://github.com/tpope/vim-cucumber.git",
  "https://github.com/tpope/vim-git.git",
  "https://github.com/tpope/vim-markdown.git",
  "https://github.com/tpope/vim-eunuch.git",
  "https://github.com/tpope/vim-bundler.git",
  "https://github.com/skwp/vim-rspec.git",
  "https://github.com/vim-ruby/vim-ruby.git",
  "https://github.com/MarcWeber/vim-addon-mw-utils.git",
  "https://github.com/rogerz/vim-json.git",
  "https://github.com/benmills/vimux.git",
  "https://github.com/pgr0ss/vimux-ruby-test.git",
  "https://github.com/vim-scripts/vimwiki.git",
]

bundles_dir = File.join(File.dirname(__FILE__), "bundle")

FileUtils.cd(bundles_dir)

puts "trashing everything (lookout!)"
Dir["*"].each {|d| FileUtils.rm_rf d }

git_bundles.each do |url|
  dir = url.split('/').last.sub(/\.git$/, '')
  puts "unpacking #{url} into #{dir}"
  system("git clone #{url} #{dir}")
  FileUtils.rm_rf(File.join(dir, ".git"))
end
