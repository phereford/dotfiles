set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/opt/fzf
call vundle#begin()

Plugin 'gmarik/vundle'

" Bundle plugins
Plugin 'morhetz/gruvbox'
Plugin 'tomlion/vim-solidity'
Plugin 'vim-airline/vim-airline'
Plugin 'edkolev/tmuxline.vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-dispatch'
Plugin 'pangloss/vim-javascript'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'w0rp/ale'
Plugin 'ervandew/supertab'
Plugin 'jcfaria/Vim-R-plugin'
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'airblade/vim-gitgutter'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'JuliaEditorSupport/julia-vim'

Plugin 'kana/vim-textobj-user'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'

Plugin 'elixir-lang/vim-elixir'
Plugin 'craigemery/vim-autotag'

Plugin 'rust-lang/rust.vim'
Plugin 'majutsushi/tagbar'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'hashivim/vim-terraform'
Plugin 'github/copilot.vim'

call vundle#end()
filetype plugin indent on
