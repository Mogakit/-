source $VIMRUNTIME/vimrc_example.vim
" mswin.vim让我们丢失了太多的快键键了,不得不抛弃
" source $VIMRUNTIME/mswin.vim
" behave mswin

set nocompatible
syntax on
colo desert
"syntax enable
"set background=light

set showcmd
set autoread
"方便argdo 和 bufdo 的使用
set hidden

" 高亮显示当前行/列
set cursorline
set cursorcolumn
" 禁止光标闪烁
set gcr=a:block-blinkon0
" 禁止显示滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
" 禁止显示菜单和工具条
set guioptions-=m
set guioptions-=T
" 显示光标当前位置
set ruler
" 开启行号显示
set number
" 高亮显示当前行/列
set cursorline
set cursorcolumn
" 高亮显示搜索结果
set hlsearch
" 不创建备份文件
set nobackup
" 括号补全
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
"在insert mode下如丝半顺滑
inoremap <c-l> <c-o>a
"戒掉箭头
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
"轻松展开当前文件所在目录, 看不懂怎么用
cnoremap <expr> && getcmdtype( ) == ':' ? expand('%:h').'/' : '&&'
"让vim 自动识别utf8 和 gb2312
set fencs=utf-8,gbk
"ctrl-s将中文标点换为英文标点
function! CheckChineseMark()  
	if search('。')
	execute "1,$s/。/\./g"
	endif
 
	if search('，')
	execute "1,$s/，/,/g" 
	endif
 
	if search('；')
     	execute "1,$s/；/,/g" 
	endif
      
	if search('？')
	execute "1,$s/？/?/g" 
	endif
 
	if search('：')
	execute "1,$s/：/\:/g" 
	endif
 
	if search('‘')
	execute "1,$s/‘/\'/g" 
	endif
 
	if search('’')
	execute "1,$s/’/\'/g" 
	endif
 
	if search('”')
	execute "1,$s/”/\"/g" 
	endif
 
	if search('“')
	execute "1,$s/“/\"/g" 
	endif
 
	if search('《')
        execute "1,$s/《/\</g" 
	endif
 
	if search('》')
        execute "1,$s/》/\>/g" 
	endif
 
	if search('—')
        execute "1,$s/—/-/g" 
	endif
 
	if search('）')
        execute "1,$s/）/\)/g" 
	endif
 
	if search('（')
        execute "1,$s/（/\(/g" 
	endif
 
	if search('…')
        execute "1,$s/……/^/g" 
	endif
 
	if search('￥')
        execute "1,$s/￥/$/g" 
	endif
 
	if search('！')
        execute "1,$s/！/!/g" 
	endif
 
	if search('·')
        execute "1,$s/·/`/g" 
	endif
 
	if search('、')
        execute "1,$s/、/,/g" 
	endif

	if search('【')
        execute "1,$s/【/[/g" 
	endif

	if search('】')
	execute "1,$s/】/]/g" 
	endif

	if search('．')
	execute "1,$s/．/./g" 
	endif
endfunction  
noremap <C-S> :call CheckChineseMark()<CR>
"java编译
nn <F5> :exec ":!javac -encoding utf-8 " .expand("%")<CR>
nn <F6> :exec ":!java " .expand("%:r")<CR>

" Platform
function! MySys()
	if has("win32")
		return "windows"
	else
		return "linux"
	endif
endfunction
function! SwitchToBuf(filename)
"let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")

" find in current tab
let bufwinnr = bufwinnr(a:filename)
if bufwinnr != -1
	exec bufwinnr . "wincmd w"
	return
else
	" find in each tab
	tabfirst
	let tab = 1
	while tab <= tabpagenr("$")
		let bufwinnr = bufwinnr(a:filename)
		if bufwinnr != -1
			exec "normal " . tab . "gt"
			exec bufwinnr . "wincmd w"
			return
		endif
		tabnext
		let tab = tab + 1
	endwhile
	" not exist, new tab
	exec "tabnew " . a:filename
endif
endfunction
"Fast edit vimrc
if MySys() == 'linux'
	"Fast reloading of the .vimrc
	map <silent> <leader>ss :source ~/.vimrc<cr>
	"Fast editing of .vimrc
	map <silent> <leader>ee :call SwitchToBuf("~/.vimrc")<cr>
	"When .vimrc is edited, reload it
	autocmd! bufwritepost .vimrc source ~/.vimrc
elseif MySys() == 'windows'
	"设置home变量,会影响到~的作用
	let $home = "d:\\Program Files (x86)\\Vim"
	" Set helplang
	set helplang=cn
	"Fast reloading of the _vimrc
	map <silent> <leader>ss :source ~/_vimrc<cr>
	"Fast editing of _vimrc
	map <silent> <leader>ee :call SwitchToBuf("~/_vimrc")<cr>
	"定义了一个自动命令, 每次写入.vimrc后, source一次"~/.vimrc文件
	autocmd! bufwritepost _vimrc source ~/_vimrc
endif
" For windows version
if MySys() == 'windows'
	behave mswin
endif

""""""""""""""""""""""""""""""
" netrw setting
""""""""""""""""""""""""""""""
let g:netrw_winsize = 30
nmap <silent> <leader>fe :Sexplore!<cr>
