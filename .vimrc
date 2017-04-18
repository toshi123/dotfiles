" Authors: toshi123
" Reference:
" http://vim.wikia.com/wiki/Example_vimrc
" http://lambdalisue.hatenablog.com/entry/2013/06/23/071344
" http://d.hatena.ne.jp/itchyny/?of=18
" http://d.hatena.ne.jp/vimtaku/20121117/1353138802

augroup MyAutoCmd
  autocmd!
augroup END

" Vi互換モードをオフ(Vimの拡張機能を有効)
set nocompatible
" ファイル名と内容によってファイルタイプを判別し、ファイルタイププラグインを有効にする
filetype indent plugin on
" テキスト整形オプション,マルチバイト系を追加
set formatoptions=lmoq
" Exploreの初期ディレクトリ
set browsedir=buffer
" カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,],~
" オートインデント
set autoindent
" 移動コマンドを使ったとき、行頭に移動しない
set nostartofline
" ステータスラインを常に表示する
set laststatus=2
set statusline=%<%F\ %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%4v(ASCII=%03.3b,HEX=%02.2B)\ %l/%L(%P)%m
" バッファが変更されているとき、コマンドをエラーにするのでなく、保存するかどうか確認を求める
set confirm
" 全モードでマウスを有効化
set mouse=a
" コマンドラインの高さを2行に
set cmdheight=2
" キーコードはすぐにタイムアウト。マッピングはタイムアウトしない
set notimeout ttimeout ttimeoutlen=200
" <F11>キーで'paste'と'nopaste'を切り替える
set pastetoggle=<F11>
" その他表示設定
" 印字不可能文字を16進数で表示
set display=uhex

" 全角スペースをハイライト 
if has("syntax")
"  syntax on
  function! ActivateInvisibleIndicator()
"    syntax match InvisibleJISX0208Space " " display containedin=ALL
"    highlight InvisibleJISX0208Space term=underline ctermbg=Cyan guibg=Cyan
  endf
  augroup invisible
    autocmd! invisible
    autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
  augroup END
endif

"----------------------------------------------------------------------------------
" 検索関連
set ignorecase          " 大文字小文字を区別しない
set smartcase           " 検索文字に大文字がある場合は大文字小文字を区別
set incsearch           " インクリメンタルサーチ
set hlsearch            " 検索マッチテキストをハイライト (2013-07-03 14:30 修正)
set wrapscan            " 最後まで検索したら先頭へ戻る

" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

"---------------------------------------------------------------------------------
" 編集設定
set shiftround          " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set infercase           " 補完時に大文字小文字を区別しない
"set virtualedit=all     " カーソルを文字が存在しない部分でも動けるようにする
set hidden              " バッファを閉じる代わりに隠す(Undo履歴を残すため)
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=3         " 対応括弧のハイライト表示を3秒にする

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start

" クリップボードをデフォルトのレジスタとして指定。後にYankRingを使うので
" 'unnamedplus'が存在しているかどうかで設定を分ける必要がある
" if has('unnamedplus')
"   set clipboard& clipboard+=unnamedplus,unnamed
" else
"   " autoselect 削除
"   set clipboard& clipboard+=unnamed
" endif
" let g:yankring_manual_clipboard_check = 0

" Swapファイルなど無効化
set nowritebackup
set nobackup
set noswapfile

"---------------------------------------------------------------------------------
"表示関係
set list                " 不可視文字の可視化
set number              " 行番号の表示
set wrap                " 長いテキストの折り返し
set textwidth=0         " 自動的に改行が入るのを無効化
"set colorcolumn=120      " その代わり80文字目にラインを入れる

" スクリーンベル無効化
set t_vb=
set novisualbell

" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

"---------------------------------------------------------------------------------
"ショートカット
let mapleader = ","

" ,のデフォルトの機能は、\で使えるように退避
noremap \  ,

" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>

" ノーマルモードで改行を入力
nnoremap <CR> :<C-u>call append(expand('.'), '')<Cr>j
nnoremap ; :w<CR>

" YをCやDと同じ挙動に
map Y y$

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" vを二回で行末まで選択
vnoremap v $h

" TABにて対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprevious<CR>
"nnoremap <C-j> <C-w>j
"nnoremap <C-h> <C-w>h
"nnoremap <C-k> <C-w>k
"nnoremap <C-l> <C-w>l

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" T + ? で各種設定をトグル
nnoremap [toggle] <Nop>
nmap T [toggle]
nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]l :setl list!<CR>:setl list?<CR>
nnoremap <silent> [toggle]t :setl expandtab!<CR>:setl expandtab?<CR>
nnoremap <silent> [toggle]w :setl wrap!<CR>:setl wrap?<CR>

" make, grep などのコマンド後に自動的にQuickFixを開く
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen

" QuickFixおよびHelpでは q でバッファを閉じる
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

" w!! でスーパーユーザーとして保存(sudoが使える環境限定)
"cmap w!! w !sudo tee > /dev/null %

" :e などでファイルを開く際にフォルダが存在しない場合は自動作成
function! s:mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force || input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction
autocmd MyAutoCmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)

" vim 起動時のみカレントディレクトリを開いたファイルの親ディレクトリに指定
autocmd MyAutoCmd VimEnter * call s:ChangeCurrentDir('', '')
function! s:ChangeCurrentDir(directory, bang)
  if a:directory == ''
    lcd %:p:h
  else
    execute 'lcd' . a:directory
  endif

  if a:bang == ''
    pwd
  endif
endfunction

" ~/.vimrc.localが存在する場合のみ設定を読み込む
let s:local_vimrc = expand('~/.vimrc.local')
if filereadable(s:local_vimrc)
  execute 'source ' . s:local_vimrc
endif

"------------------------------------------------------------
" Indentation options {{{1
" インデント関連のオプション {{{1
"
" タブ文字の代わりにスペース2個を使う場合の設定。
set shiftwidth=4
set softtabstop=4
set expandtab

"-------------------------------------------------------------------------------
" エンコーディング関連

" 改行文字
set ffs=unix,dos,mac

" デフォルトエンコーディング
set encoding=utf-8

if has('win32') && has('kaoriya')
  set ambiwidth=auto
else
  set ambiwidth=double
endif

if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'

  if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213,euc-jp'
    let s:enc_jis = 'iso-2022-jp-3'
  endif

  set fileencodings&
  let &fileencodings = &fileencodings.','.s:enc_jis.',cp932,'.s:enc_euc
  unlet s:enc_euc
  unlet s:enc_jis
endif

"------------------------------------------------------------------------------
" filetype off
" 
" let s:noplugin = 0
" let s:bundle_root = expand('~/.vim/bundle')
" let s:neobundle_root = s:bundle_root . '/neobundle.vim'
" if !isdirectory(s:neobundle_root) || v:version < 702
"   " NeoBundleが存在しない、もしくはVimのバージョンが古い場合はプラグインを一切読み込まない
"   let s:noplugin = 1
" else
"   " NeoBundleを'runtimepath'に追加し初期化を行う
"   if has('vim_starting')
"     execute "set runtimepath+=" . s:neobundle_root
"   endif
"   call neobundle#begin(s:bundle_root)
"   " NeoBundle自身をNeoBundleで管理させる
"   NeoBundleFetch 'Shougo/neobundle.vim'
" 
"   " 非同期通信を可能にする
"   " 'build'が指定されているのでインストール時に自動的に
"   " 指定されたコマンドが実行され vimproc がコンパイルされる
"   NeoBundle "Shougo/vimproc", {
"         \ "build": {
"         \   "windows"   : "make -f make_mingw32.mak",
"         \   "cygwin"    : "make -f make_cygwin.mak",
"         \   "mac"       : "make -f make_mac.mak",
"         \   "unix"      : "make -f make_unix.mak",
"         \ }}
" 
"   "NeoBundle 'Shougo/neocomplcache'
"   "NeoBundle 'Shougo/neobundle.vim'
"   "NeoBundle 'Shougo/unite.vim'
"   NeoBundle 'tomtom/tcomment_vim'
"   NeoBundle 'thinca/vim-template'
"   NeoBundle 'tpope/vim-surround'
"   NeoBundle 'vim-scripts/Align'
"   " NeoBundle 'vim-scripts/YankRing.vim'
"   NeoBundle 'LeafCage/yankround.vim'
"   "NeoBundle 'alpaca-tc/alpaca_powertabline'
"   "NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
"   "NeoBundle 'Shougo/vimfiler'
"   NeoBundle 'itchyny/lightline.vim'
"   NeoBundle 'thinca/vim-quickrun'
"   NeoBundle 'Shougo/neomru.vim'
"   NeoBundle 'tpope/vim-fugitive'
"   NeoBundle 'airblade/vim-gitgutter'
"   NeoBundle 'Shougo/neosnippet-snippets'
"   NeoBundle "nathanaelkane/vim-indent-guides"
" 
"   "-- colorscheme
"   NeoBundle 'itchyny/landscape.vim'
"   NeoBundle 'ujihisa/unite-colorscheme'
"   NeoBundle 'nanotech/jellybeans.vim'
"   NeoBundle 'tomasr/molokai'
" 
" 
"   " インストールされていないプラグインのチェックおよびダウンロード
"   NeoBundleCheck
"   call neobundle#end()
" 
" endif
" 
" 
" " ファイルタイププラグインおよびインデントを有効化
" " これはNeoBundleによる処理が終了したあとに呼ばなければならない
" filetype plugin indent on
" 

"------------------------------------------------------------------------
" dein.vim

" Flags
let s:use_dein = 1

" vi compatibility
if !&compatible
  set nocompatible
endif

" Prepare .vim dir
let s:vimdir = $HOME . "/.vim"
if has("vim_starting")
  if ! isdirectory(s:vimdir)
    call system("mkdir " . s:vimdir)
  endif
endif

" dein
let s:dein_enabled  = 0
if s:use_dein && v:version >= 704
  let s:dein_enabled = 1
    let s:dein_dir = expand('~/.vim/dein')
    let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

    if &compatible
    set nocompatible
    endif

    if !isdirectory(s:dein_repo_dir)
    execute '!git clone git@github.com:Shougo/dein.vim.git' s:dein_repo_dir
    endif

    execute 'set runtimepath^=' . s:dein_repo_dir

    call dein#begin(s:dein_dir)

    call dein#add('Shougo/dein.vim')

    call dein#add('Shougo/vimproc', {
            \ 'build': {
            \     'windows': 'tools\\update-dll-mingw',
            \     'cygwin': 'make -f make_cygwin.mak',
            \     'mac': 'make -f make_mac.mak',
            \     'linux': 'make',
            \     'unix': 'gmake'}})

    call dein#add('Shougo/unite.vim', {
            \ 'depends': ['vimproc'],
            \ 'on_cmd': ['Unite'],
            \ 'lazy': 1})

    if has('lua')
    call dein#add('Shougo/neocomplete.vim', {
                \ 'on_i': 1,
                \ 'lazy': 1})
    endif

    call dein#add('Shougo/vimfiler', {
    \ "depends": ["Shougo/unite.vim"],
    \ "lazy": 1}
    \ )
    nnoremap <Space>e :VimFilerExplorer<CR>


    call dein#add('Shougo/neocomplcache')
    call dein#add('tomtom/tcomment_vim')
    call dein#add('thinca/vim-template')
    call dein#add('tpope/vim-surround')
    call dein#add('vim-scripts/Align')
    call dein#add('vim-scripts/YankRing.vim')
    call dein#add('LeafCage/yankround.vim')
    call dein#add('alpaca-tc/alpaca_powertabline')
    call dein#add('itchyny/lightline.vim')
    call dein#add('thinca/vim-quickrun')
    call dein#add('Shougo/neomru.vim')
    call dein#add('tpope/vim-fugitive')
    call dein#add('airblade/vim-gitgutter')
    call dein#add('Shougo/neosnippet-snippets')
    call dein#add('nathanaelkane/vim-indent-guides')
    call dein#add('itchyny/landscape.vim')
    call dein#add('ujihisa/unite-colorscheme')
    call dein#add('nanotech/jellybeans.vim')
    call dein#add('tomasr/molokai')


    set rtp+=/Users/tsuji/Library/Python/3.4/lib/python/site-packages/powerline/bindings/vim
    call dein#add('powerline/powerline', { 'rtp' : 'powerline/bindings/vim'})

    call dein#end()

    if dein#check_install()
    call dein#install()
    endif
    if s:dein_enabled && dein#tap("unite.vim")
        nnoremap [unite] <Nop>
            nmap <Space>u [unite]
            nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
            nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
            nnoremap <silent> [unite]r :<C-u>Unite register<CR>
            nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
            nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
            nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
            nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
            nnoremap <silent> [unite]w :<C-u>Unite window<CR>
            nnoremap <silent> [unite]u :<C-u>Unite buffer file_mru file<CR>
            nnoremap <silent> [unite]y :<C-u>Unite yankround<CR>
        endif

        " start unite in insert mode
        let g:unite_enable_start_insert = 1
        " 大文字小文字を区別しない
        let g:unite_enable_ignore_case = 1
        let g:unite_enable_smart_case = 1
        
        " use vimfiler to open directory
        " call unite#custom_default_action("source/bookmark/directory", "vimfiler")
        " call unite#custom_default_action("directory", "vimfiler")
        " call unite#custom_default_action("directory_mru", "vimfiler")
        autocmd MyAutoCmd FileType unite call s:unite_settings()
        function! s:unite_settings()
            imap <buffer> <Esc><Esc> <Plug>(unite_exit)
            nmap <buffer> <Esc> <Plug>(unite_exit)
            nmap <buffer> <C-n> <Plug>(unite_select_next_line)
            nmap <buffer> <C-p> <Plug>(unite_select_previous_line)
        endfunction

        " grep検索
        nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
        " ディレクトリを指定してgrep検索
        nnoremap <silent> ,dg  :<C-u>Unite grep -buffer-name=search-buffer<CR>
        " カーソル位置の単語をgrep検索
        nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W><CR>
        " grep検索結果の再呼出
        nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>
        " unite grep に ag(The Silver Searcher) を使う
        if executable('ag')
            let g:unite_source_grep_command = 'ag'
            let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
            let g:unite_source_grep_recursive_opt = ''
        endif
    "-------------------------------------------------------------------------
endif
"-------------------------------------------------------------------------
" ColorScheme
:colorscheme molokai
syntax on
"-------------------------------------------------------------------------

"--------------------------------------------------------------------------
"template
" テンプレート中に含まれる特定文字列を置き換える
autocmd MyAutoCmd User plugin-template-loaded call s:template_keywords()
function! s:template_keywords()
  silent! %s/<+DATE+>/\=strftime('%Y-%m-%d')/g
  silent! %s/<+FILENAME+>/\=expand('%:r')/g
endfunction
" テンプレート中に含まれる'<+CURSOR+>'にカーソルを移動
autocmd MyAutoCmd User plugin-template-loaded
    \   if search('<+CURSOR+>')
    \ |   silent! execute 'normal! "_da>'
    \ | endif

"--------------------------------------------------------------------------
" yankround
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_max_history = 50
let g:yankround_dir = '~/.cache/yankround'

 "------------------------------------------------------------------------------

" close vimfiler automatically when there are only vimfiler open
if dein#is_sourced('vimfiler')
    autocmd MyAutoCmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
" let s:hooks = neobundle#get_hooks("vimfiler")
" function! s:hooks.on_source(bundle)
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_enable_auto_cd = 1
  
  " .から始まるファイルおよび.pycで終わるファイルを不可視パターンに
  let g:vimfiler_ignore_pattern = "\%(^\..*\|\.pyc$\)"

  " vimfiler specific key mappings
  autocmd MyAutoCmd FileType vimfiler call s:vimfiler_settings()
  function! s:vimfiler_settings()
    " ^^ to go up
    nmap <buffer> ^^ <Plug>(vimfiler_switch_to_parent_directory)
    " use R to refresh
    nmap <buffer> R <Plug>(vimfiler_redraw_screen)
    " overwrite C-l
    nmap <buffer> <C-l> <C-w>l
  endfunction
" endfunction
endif
"----------------------------------------------------------------------------
" neocomplete
" if dein#is_sourced('neocomplete.vim')
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
" From
" https://github.com/ujiro99/dotfiles/blob/master/.vimrc.completion.neocomplcache
" 補完が自動で開始される文字数
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#auto_completion_start_length = 3


let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


" ポップアップメニューで表示される候補の数。初期値は100
let g:neocomplete#max_list = 30
" endfunction
" endif

"-----------------------------------------------------------------------------
" neosunippet
if dein#is_sourced('neosnippets')
    " let s:hooks = neobundle#get_hooks("neosnippet.vim")
    function! s:hooks.on_source(bundle)
        imap <C-k>     <Plug>(neosnippet_expand_or_jump)
        smap <C-k>     <Plug>(neosnippet_expand_or_jump)
        xmap <C-k>     <Plug>(neosnippet_expand_target)
        " SuperTab like snippets behavior.
        imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)"
            \: pumvisible() ? "\<C-n>" : "\<TAB>"
        smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)"
            \: "\<TAB>"
        " For snippet_complete marker.
        if has('conceal')
            set conceallevel=2 concealcursor=i
        endif
        " Enable snipMate compatibility feature.
        let g:neosnippet#enable_snipmate_compatibility = 1
        " Tell Neosnippet about the other snippets
        let g:neosnippet#snippets_directory=s:bundle_root . '/vim-snippets/snippets'
    endfunction
endif
"---------------------------------------------------------------------------
" インデント可視化
if dein#is_sourced('neosnippets')
    " let s:hooks = neobundmle#get_hooks("vim-indent-guides")
    " function! s:hooks.on_source(bundle)
    let g:indent_guides_guide_size = 1
    IndentGuidesEnable " 2013-06-24 10:00 追記
    " endfunction
endif

"----------------------------------------------------------------------------
" Python関連
" Djangoを正しくVimで読み込めるようにする
call dein#add("lambdalisue/vim-django-support", {'lazy':1,'on_ft':["python", "python3", "djangohtml"]})
" Vimで正しくvirtualenvを処理できるようにする
call dein#add("jmcantrell/vim-virtualenv", {'lazy':1,'on_ft':["python", "python3", "djangohtml"]})

" Jedi
call dein#add("davidhalter/jedi-vim", {'lazy':1,'on_ft':["python", "python3", "djangohtml"],'build':1})
  if dein#is_sourced("davidhalter/jedi-vim")
" let s:hooks = neobundle#get_hooks("jedi-vim")
" function! s:hooks.on_source(bundle)
    " autocmd FileType python setlocal omnifunc=jedi#completions
    " jediにvimの設定を任せると'completeopt+=preview'するので
    " 自動設定機能をOFFにし手動で設定を行う
    " let g:jedi#auto_vim_configuration = 0
    " let g:jedi#completions_enabled = 0
    " 補完の最初の項目が選択された状態だと使いにくいためオフにする <- 書いても書かなくても同じ
    " let g:jedi#popup_select_first = 0
    " quickrunと被るため大文字に変更
    let g:jedi#rename_command = '<Leader>R'
    " gundoと被るため大文字に変更 (2013-06-24 10:00 追記)
    let g:jedi#goto_assignments_command = '<Leader>G'
    " let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

    autocmd FileType python setlocal omnifunc=jedi#completions
    autocmd FileType python setlocal completeopt-=preview
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#completions_enabled = 0
    if !exists('g:neocomplete#force_omni_input_patterns')
            let g:neocomplete#force_omni_input_patterns = {}
    endif
    let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
" endfunction
endif

"--------------------------------------------------------------------------
" lightline.vim
"let g:lightline = {
"      \ 'colorscheme': 'wombat',
"      \ 'component': {
"      \   'readonly': '%{&readonly?"\u2b64":""}',
"      \ },
"      \ 'separator': { 'left': "\u2b80", 'right': "\u2b82" },
"      \ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" },
"      \ }
"
"" カラー設定
"set t_Co=256


let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode',
        \   'syntastic': 'SyntasticStatuslineFlag',
        \   'charcode': 'MyCharCode',
        \   'gitgutter': 'MyGitGutter',
        \ }
        \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      let _ = fugitive#head()
      return strlen(_) ? '⭠ '._ : ''
      " return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction


function! MyGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added . ' ',
        \ g:gitgutter_sign_modified . ' ',
        \ g:gitgutter_sign_removed . ' '
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

" https://github.com/Lokaltog/vim-powerline/blob/develop/autoload/Powerline/Functions.vim

let g:powerline_pycmd="python3"
python3 import sys; sys.path.append("/Users/tsuji/Library/Python/3.4/lib/python/site-packages")
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

function! MyCharCode()
  if winwidth('.') <= 70
    return ''
  endif

  " Get the output of :ascii
  redir => ascii
  silent! ascii
  redir END

  if match(ascii, 'NUL') != -1
    return 'NUL'
  endif

  " Zero pad hex values
  let nrformat = '0x%02x'

  let encoding = (&fenc == '' ? &enc : &fenc)

  if encoding == 'utf-8'
    " Zero pad with 4 zeroes in unicode files
    let nrformat = '0x%04x'
  endif

  " Get the character and the numeric value from the return value of :ascii
  " This matches the two first pieces of the return value, e.g.
  " "<F>  70" => char: 'F', nr: '70'
  let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')

  " Format the numeric value
  let nr = printf(nrformat, nr)

  return "'". char ."' ". nr
endfunction
"--------------------------------------------------------------------------
" vim-quickrun

let g:quickrun_config = {
\   "_" : {
\       "runner" : "vimproc",
\       "runner/vimproc/updatetime" : 60
\   },
\}


