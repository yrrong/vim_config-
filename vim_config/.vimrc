set nocompatible

let g:C_SourceCodeExtensions = 'c h cc cp cxx cpp CPP c++ C i ii cu l y'
set backspace=indent,eol,start
set history=50
set showcmd 		"in status line
set scrolloff=7 	"keep in middle
set showmatch 	 	"highlight brackets match
set expandtab		"change tab to space, CTRL-V<Tab> to be real tab
set shiftround		"Round indent to multiple of 'shiftwidth'
set nu
set ci
set ai
set ts=4
set sw=4

set cino=g0         "c++ public: won't indent

set autowrite "自动保存 
set confirm    "在处理未保存或只读文件的时候，弹出确认
set nobackup   "禁止生成临时文件
set noswapfile
set mouse=a

" 为C程序提供自动缩进
"自动补全
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
function! ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<Right>"
  else
    return a:char
  endif
endfunction

"搜索忽略大小写
set incsearch		"Hightlight even if you are not finish your typing.	
set ignorecase		"A and a are equal
set smartcase 		"Ab and ab are not equal, AB and ab are equal
set hlsearch        "Hightlight all search results

set cul
set cuc
set ruler 			"show status line
set laststatus=2	

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.o,*.so,*~, "filetye ignore

set wildmode=list:longest:full "cmd prompt
set completeopt=longest,menu


set colorcolumn=80  "Global color Normal 2nd

set pastetoggle=<F11>

autocmd! bufwritepost .vimrc source % " source .vimrc 

syntax on

set bg=dark
set t_Co=256        "Number of colors, this make the molokai effective
colorscheme molokai

"To make solarized effective see https://gist.github.com/schmrlng/737c4a1672442bd15b60
"colorscheme solarized 
"let g:solarized_termcolors=256

let mapleader = ","
let g:mapleader = ","

"Keep search pattern at the center of the screen."
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

"move line
nnoremap <S-k> ddkP  
nnoremap <S-j> ddp

"tab change
nnoremap <silent> <Leader>1 gT
nnoremap <silent> <Leader>2 gt

set showtabline=1

if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
           " let s .= '%'. i. 'T'            "tab number
            let s .= (i == t ? '%1*' : '%2*') "number in black background 
            let s .= i
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#' ) " highlight
            let file = bufname(buflist[winnr - 1])
            let file = fnamemodify(file, ':p:t') "filename without path
            if file == ''
                let file = '[NEW]'
            endif
            "let s .= file
            let s .= ' '. file. ' '
            let i += 1 
        endwhile
        return s
    endfunction
    set tabline=%!MyTabLine()
endif

" select all
nnoremap <Leader>sa ggVG

"command line control
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

"add author info
function! AddTitle()
    call append(0,"/*")
    call append(1," * =================================================================")
    call append(2," *")
    call append(3," *            Filename:    ".expand("%:t"))
    call append(4," *")
    call append(5," *         Description:    ")
    call append(6," *")
    call append(7," *             Version:    ")
    call append(8," *             Created:    ".strftime("%Y-%m-%d %H:%M"))
    call append(9," *           Reversion:    none")
    call append(10," *            Compiler:    g++")
    call append(11," *")
    call append(12," *               Author:    yaorurong, 1961272506@qq.com")
    call append(13," * ")
    call append(14," * ==================================================================")
    call append(15," */")
endf
 "There was 's after it.
map <F4> : call AddTitle() <cr> 

"add annotation
function! Annotation()
    call append(line("."),"/*****************************************")
    call append(line(".")+1," * ")
    call append(line(".")+2," *    Description:    ")
    call append(line(".")+3," *")
    call append(line(".")+4," *         Return:    ")
    call append(line(".")+5," *")
    call append(line(".")+6," *****************************************/")
endf
map <F5> : call Annotation() <cr>

"add .h title
function! AddTitleH()
    call append(0, "#ifndef ".toupper(expand("%:t:r"))."_H_") "h filename-modifiers 
    call append(1, "#define ".toupper(expand("%:t:r"))."_H_")
    call append(2, " ")
    call append(3, "#endif")
endf
map <F6> : call AddTitleH() <cr>

"au BufNewFile *.h exec "call AddTitleH()"

function! AddCPPHeader()
    call append(0, "#include <iostream>")
    call append(1, "#include <string.h>")
    call append(2, "#include <cstdio>")
    call append(3, "#include <algorithm>")
    call append(4, "#include <vector>")
    call append(5, "#include <queue>")
    call append(6, "#include <stack>")
    call append(7, "#include <map>")
    call append(8, "#include <set>")
    call append(9, "#include <cmath>")
    call append(10, "#include <functional>")
    call append(11, "#include <string>")
    call append(12, "#include <cstdlib>")
    call append(13, " ")
    call append(14, "using namespace std;")
    call append(15, " ")
    call append(16, "int main()")
    call append(17, "{")
    call append(18, "    ")
    call append(19, "    return 0;")
    call append(20, "}")
endf
map <F7> : call AddCPPHeader() <cr>

function! AddCPPHeadercpp()
    call append(0, "#include <bits/stdc++.h>")
    call append(1, " ")
    call append(2, "using namespace std;")
    call append(3, " ")
    call append(4, "int main()")
    call append(5, "{")
    call append(6, "    ")
    call append(7, "    return 0;")
    call append(8, "}")
endf
map <F8> : call AddCPPHeadercpp() <cr>


"In normal mode,   ; and : are equal
nnoremap ; :

"Set the charactor encoding
set fileencodings=utf-8,gbk,gb2312,gb18030,cs-bom,cp936,latin1
set encoding=utf-8
set termencoding=utf-8


"Window switch                                                                     
"nmap <silent><C-j> <C-w>j 
""jump to the below window
"nmap <silent><C-k> <C-w>k
""jump to the above window  :sp
"nmap <silent><C-h> <C-w>h
""jump to the left window   :vsp
"nmap <silent><C-l> <C-w>l 
""jump to the right window 
"nmap <silent><C-p> <C-w>P
"jump to the previous window
"<C-w>c will close a window
"More info see :h sp

set runtimepath+=~/.vim/bundle/a.vim/

nmap <Leader>5 :AT<CR>

"set runtimepath+=~/.vim/bundle/auto-pairs/
set runtimepath+=~/.vim/bundle/nerdcommenter/

set runtimepath+=~/.vim/bundle/nerdtree/
let g:NERDTreeWinSize = 25
let g:NERDTreeIgnore=['\~$', '.o$[[file]]']
let NERDTreeShowBookmarks = 1
nmap <C-e> :NERDTreeToggle<cr>
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%:d/%m/%y\ -\ %H:%M\")}
"set runtimepath+=~/.vim/bundle/vim-powerline/
"let g:Powerline_symbols = 'unicode'

set runtimepath+=~/.vim/bundle/vim-airline/
set ambiwidth=double
let g:airline_theme="molokai"
"let g:airline_powerline_fonts = 1

set runtimepath+=~/.vim/bundle/rainbow_parentheses.vim/
let g:rbpt_max = 16
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"au Syntax * RainbowParenthesesLoadChevrons

"set runtimepath+=~/.vim/bundle/scratch.vim/
"set runtimepath+=~/.vim/bundle/Reindent/
set runtimepath+=~/.vim/bundle/supertab/
"let g:SuperTabDefaultCompletionType="context"

set runtimepath+=~/.vim/bundle/syntastic/
let g:syntastic_error_symbol='>>'
let g:syntastic_warning_symbol='>'
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_highlighting = 1
let g:syntastic_python_checkers = ['pyflakes']

" to see error location list
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_loc_list_height = 5
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction
nnoremap <Leader>s :call ToggleErrors()<cr>

set runtimepath+=~/.vim/bundle/tagbar/
nnoremap <silent> <F9> :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_width = 25
let g:tagbar_autofocus=1
let g:tagbar_sort = 0 

set runtimepath+=~/.vim/bundle/ultisnips/
set runtimepath+=~/.vim/bundle/vim-snippets/
let g:UltiSnipsExpandTrigger="<c-x>"
let g:UltiSnipsJumpForwardTrigger="<c-m>"
let g:UltiSnipsJumpBackwardTrigger="<c-n>"
"let g:UltiSnipsSnippetDirectories=["UltiSnips"]


"set runtimepath+=~/.vim/bundle/taglist.vim/
"nnoremap <silent> <F8> :TlistToggle<CR>

"vundle setting
filetype off
set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()

"set runtimepath+=~/.vim/bundle/minibufexpl.vim/

"map <Leader>mbe :MBEOpen<cr>
"map <Leader>mbc :MBEClose<cr>
"map <Leader>mbt :MBEToggle<cr>
"map <Leader>1 :MBEbp<cr>
"map <Leader>2 :MBEbn<cr>
"set runtimepath+=~/.vim/bundle/YouCompleteMe/
"let g:ycm_auto_trigger = 1

Bundle 'gmarik/vundle'
"Bundle 'mileszs/ack.vim'
"Bundle 'rking/ag.vim'
"Bundle 'Yggdroot/indentLine'  " can not rtp
"Bundle 'scrooloose/nerdcommenter'
"Bundle 'Lokaltog/powerline' , {'rtp': 'powerline/bindings/vim/'}

filetype plugin indent on

set tags=tags;/
