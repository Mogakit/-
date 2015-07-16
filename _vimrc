source $VIMRUNTIME/vimrc_example.vim
" mswin.vim�����Ƕ�ʧ��̫��Ŀ������,���ò�����
" source $VIMRUNTIME/mswin.vim
" behave mswin

set nocompatible
syntax on
colo desert
"syntax enable
"set background=light

set showcmd
set autoread
"����argdo �� bufdo ��ʹ��
set hidden

" ������ʾ��ǰ��/��
set cursorline
set cursorcolumn
" ��ֹ�����˸
set gcr=a:block-blinkon0
" ��ֹ��ʾ������
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
" ��ֹ��ʾ�˵��͹�����
set guioptions-=m
set guioptions-=T
" ��ʾ��굱ǰλ��
set ruler
" �����к���ʾ
set number
" ������ʾ��ǰ��/��
set cursorline
set cursorcolumn
" ������ʾ�������
set hlsearch
" �����������ļ�
set nobackup
" ���Ų�ȫ
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
"��insert mode����˿��˳��
inoremap <c-l> <c-o>a
"�����ͷ
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
"����չ����ǰ�ļ�����Ŀ¼, ��������ô��
cnoremap <expr> && getcmdtype( ) == ':' ? expand('%:h').'/' : '&&'
"��vim �Զ�ʶ��utf8 �� gb2312
set fencs=utf-8,gbk
"ctrl-s�����ı�㻻ΪӢ�ı��
function! CheckChineseMark()  
	if search('��')
	execute "1,$s/��/\./g"
	endif
 
	if search('��')
	execute "1,$s/��/,/g" 
	endif
 
	if search('��')
     	execute "1,$s/��/,/g" 
	endif
      
	if search('��')
	execute "1,$s/��/?/g" 
	endif
 
	if search('��')
	execute "1,$s/��/\:/g" 
	endif
 
	if search('��')
	execute "1,$s/��/\'/g" 
	endif
 
	if search('��')
	execute "1,$s/��/\'/g" 
	endif
 
	if search('��')
	execute "1,$s/��/\"/g" 
	endif
 
	if search('��')
	execute "1,$s/��/\"/g" 
	endif
 
	if search('��')
        execute "1,$s/��/\</g" 
	endif
 
	if search('��')
        execute "1,$s/��/\>/g" 
	endif
 
	if search('��')
        execute "1,$s/��/-/g" 
	endif
 
	if search('��')
        execute "1,$s/��/\)/g" 
	endif
 
	if search('��')
        execute "1,$s/��/\(/g" 
	endif
 
	if search('��')
        execute "1,$s/����/^/g" 
	endif
 
	if search('��')
        execute "1,$s/��/$/g" 
	endif
 
	if search('��')
        execute "1,$s/��/!/g" 
	endif
 
	if search('��')
        execute "1,$s/��/`/g" 
	endif
 
	if search('��')
        execute "1,$s/��/,/g" 
	endif

	if search('��')
        execute "1,$s/��/[/g" 
	endif

	if search('��')
	execute "1,$s/��/]/g" 
	endif

	if search('��')
	execute "1,$s/��/./g" 
	endif
endfunction  
noremap <C-S> :call CheckChineseMark()<CR>
"java����
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
	"����home����,��Ӱ�쵽~������
	let $home = "d:\\Program Files (x86)\\Vim"
	" Set helplang
	set helplang=cn
	"Fast reloading of the _vimrc
	map <silent> <leader>ss :source ~/_vimrc<cr>
	"Fast editing of _vimrc
	map <silent> <leader>ee :call SwitchToBuf("~/_vimrc")<cr>
	"������һ���Զ�����, ÿ��д��.vimrc��, sourceһ��"~/.vimrc�ļ�
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
