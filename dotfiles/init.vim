call plug#begin('~/.vim/plugged')
Plug 'ycm-core/YouCompleteMe'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UtilsnipsExpandTrigger="<tab>"
call plug#end()



"Ddoink
syntax on

"Display line number and offset for the sake of d-number-arrow
set number
set relativenumber
set nowrap

"Smack me when I'm too talkative
set colorcolumn=120

"Smack me when I crumble whitespace all over the place
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

set laststatus=2
set splitbelow
set splitright
set incsearch
