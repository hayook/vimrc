
set number 		
set relativenumber
set cursorline
set tabstop=4
set shiftwidth=4
set nowrap

" setting horizontal scrolling
map <C-l> 2zl
map <C-h> 2zh

" maping escape key to kj in both insert and visual modes
inoremap kj <ESC>

" controlling cursorline
autocmd!
autocmd InsertEnter * set nocursorline
autocmd InsertLeave * set cursorline

" moving current line up and down
noremap J :m .+1<CR>==
noremap K :m .-2<CR>==
"noremap K :m '<-2<CR>gv=gv
"noremap J :m '>+1<CR>gv=gv

" move by one paragraph vertically and center the cursor
noremap { {zz
noremap } }zz

" Move the end of the file and center the cursor 
noremap G Gzz

" move between search results and center them
noremap n nzz
noremap b bzz

" remove highlights
noremap <C-m> :noh<CR>

" change the leader key to ','
let leader = ','

" map the opening of the clipboard register
noremap <leader>c "+
