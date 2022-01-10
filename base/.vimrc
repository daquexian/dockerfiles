set encoding=utf-8

set cmdheight=2

set updatetime=300

cmap w!! w !sudo tee > /dev/null %
cmap vsb vertical sb

let mapleader="\<space>"
map <leader>tl :TlistToggle<CR>

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

set autoindent

set expandtab

set awa

set ignorecase
set smartcase

set noincsearch
set backspace=indent,eol,start
set wildmenu
highlight clear SignColumn
set hidden
set laststatus=2
set ruler
set cursorline
set cursorcolumn
" set hlsearch
set number
set nocompatible              " be iMproved, required
filetype off                  " required

nnoremap <leader>, :b#<CR>

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Plug 'drmikehenry/vim-headerguard'

" Plug 'liuchengxu/vista.vim'
" let g:vista#renderer#enable_icon = 0
" let g:vista_default_executive = 'coc'
" let g:vista_fzf_preview = ['up:60%']
" let g:vista_sidebar_width = 60


" Plug 'ludovicchabant/vim-gutentags'
" let g:gutentags_define_advanced_commands = 1
"
" " Thanks to https://zhuanlan.zhihu.com/p/36279445
" " gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
" let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
"
" " 所生成的数据文件的名称
" let g:gutentags_ctags_tagfile = '.tags'
"
" " 同时开启 ctags 和 gtags 支持：
" let g:gutentags_modules = []
" if executable('ctags')
" 	let g:gutentags_modules += ['ctags']
" endif
" if executable('gtags-cscope') && executable('gtags')
" 	let g:gutentags_modules += ['gtags_cscope']
" endif
"
" " 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
" let g:gutentags_cache_dir = expand('~/.cache/tags')
"
" " 配置 ctags 的参数
" let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
" let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
" let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
"
" " 如果使用 universal ctags 需要增加下面一行
" let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
"
" " 禁用 gutentags 自动加载 gtags 数据库的行为
" let g:gutentags_auto_add_gtags_cscope = 0
"
" let $GTAGSLABEL = 'native-pygments'
" let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'
"
" let g:gutentags_generate_on_empty_buffer = 0
" let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']
" let g:gutentags_ctags_exclude = [
" \  '*.git', '*.svn', '*.hg',
" \  'cache', 'build', 'dist', 'bin', 'node_modules', 'bower_components',
" \  '*-lock.json',  '*.lock',
" \  '*.min.*',
" \  '*.bak',
" \  '*.zip',
" \  '*.pyc',
" \  '*.class',
" \  '*.sln',
" \  '*.csproj', '*.csproj.user',
" \  '*.tmp',
" \  '*.cache',
" \  '*.vscode',
" \  '*.pdb',
" \  '*.exe', '*.dll', '*.bin',
" \  '*.mp3', '*.ogg', '*.flac',
" \  '*.swp', '*.swo',
" \  '*.cmake',
" \  '.DS_Store', '*.plist',
" \  '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png', '*.svg',
" \  '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
" \  '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx', '*.xls',
" \]
"
" Plug 'skywind3000/gutentags_plus'
"
" Plug 'tenfyzhong/vim-gencode-cpp'

" Plug 'skywind3000/asyncrun.vim'

set noshowmode

Plug 'octol/vim-cpp-enhanced-highlight'
let g:cpp_experimental_template_highlight = 1
Plug 'tpope/vim-unimpaired'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-repeat'

" Plug 'daquexian/project_manager.vim'

"""""""""""""" vim-qf
" Plug 'romainl/vim-qf'

" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}

inoremap <silent><expr> <c-k> coc#refresh()
function! GoToDefinition()
  let l:r = CocAction('jumpDefinition')
  if !r
    let l:r = CocLocations('tagls','$tagls/textDocument/definition')
    if r
      echo "[coc.nvim] use tagls as callback"
    else
      echohl WarningMsg | echom "[coc.nvim] definition not found by tagls" | echohl None
    endif
  endif
endfunction

function! GoToReferences()
  let l:r = CocAction('jumpReferences')
  if !r
    let l:r = CocLocations('tagls','$tagls/textDocument/references')
    if r
      echo "[coc.nvim] use tagls as callback"
    else
      echohl WarningMsg | echom "[coc.nvim] references not found by tagls" | echohl None
    endif
  endif
endfunction

nmap <silent> <leader>jd :call GoToDefinition()<cr>
nmap <silent> <leader>jj <Plug>(coc-rename)
nmap <silent> <leader>ji <Plug>(coc-implementation)
nmap <silent> <leader>jf :call GoToReferences()<cr>
nmap <silent> <leader>jt <Plug>(coc-type-definition)<cr>
nnoremap <silent> <leader>kd :call CocLocations('tagls','$tagls/textDocument/definition')<cr>
nnoremap <silent> <leader>kf :call CocLocations('tagls','$tagls/textDocument/references')<cr>
nnoremap <silent> <leader>je :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true,'levels':10})<cr>
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
" Use `[c` and `]c` to navigate diagnostics
nmap <silent> <C-j> <Plug>(coc-diagnostic-next)
nmap <silent> <C-k> <Plug>(coc-diagnostic-prev)
nnoremap <silent> K :call CocActionAsync('doHover')<cr>
nnoremap <silent> <A-i> :call CocActionAsync('showSignatureHelp')<cr>
imap <silent> <A-i> <c-o><A-i>
augroup cocaug
  au!
  au CursorMoved * sil call CocActionAsync('highlight')
  " Setup formatexpr specified filetype(s).
  au FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  au User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" " Using CocList
" " Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" " let g:coc_snippet_prev = '<S-TAB>'
nnoremap <silent><nowait> <space>y  :<C-u>CocList -A --normal yank<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocFzfList outline<cr>

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
let g:fzf_layout = {'down': '70%'}
" let g:fzf_layout = { 'window': { 'width': 1, 'height': 1 } }

nnoremap <leader>f :Files<cr>
nnoremap <leader>b :Buffers<cr>

let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
let $FZF_DEFAULT_OPTS='--bind ctrl-f:page-down,ctrl-b:page-up,ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up'


" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], preview window, [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 fzf#vim#with_preview('up:60%'),
  \                 <bang>0)

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview('up:60%'),
  \   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('up:60%'), <bang>0)

command! -bang -nargs=? -complete=dir Buffers
  \ call fzf#vim#buffers(<q-args>, fzf#vim#with_preview('up:60%'), <bang>0)

""""""""""""""

" Plug 'SirVer/ultisnips'
" let g:UltiSnipsExpandTrigger       = "<Nop>"
" let g:UltiSnipsJumpForwardTrigger  = "<Nop>"

" Plug 'honza/vim-snippets'

"""""""""""""" vim-airline
Plug 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#exclude_preview = 1
" let airline#extensions#tabline#disable_refresh = 1
" let g:airline#extensions#tabline#buffer_min_count = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
let g:airline_section_z = ''

" Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
" Plug 'kyazdani42/nvim-web-devicons'

"""""""""""""" nerdtree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
let g:NERDTreeDirAllows=0
nmap <Leader>ll :NERDTreeToggle<CR>
" 设置NERDTree子窗口宽度
let NERDTreeWinSize=32
" 设置NERDTree子窗口位置
let NERDTreeWinPos="left"
let NERDTreeShowHidden=0
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1

"""""""""""""" vim-prototxt
Plug 'chiphogg/vim-prototxt', { 'for': 'prototxt' }

"""""""""""""" vim-numbertoggle
Plug 'jeffkreeftmeijer/vim-numbertoggle'

"""""""""""""" tcomment_vim
Plug 'tomtom/tcomment_vim'

""""""""""""""

" Plug 'kassio/neoterm'

""""""""""""""

" Plug 'Luxed/ayu-vim' " or other package manager
" Plug 'sainnhe/gruvbox-material'
" let g:gruvbox_material_palette = 'original'
" let g:gruvbox_material_statusline_style = 'original'
Plug 'sainnhe/edge'
" Plug 'Mofiqul/vscode.nvim'
" Plug 'Shatur/neovim-ayu' " or other package manager
" Plug 'Th3Whit3Wolf/one-nvim'

" Enable true color 启用终端24位色
if exists('+termguicolors')     " enable true colors support in tmux
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
set t_ZH=[3m
set t_ZR=[23m

Plug 'christoomey/vim-tmux-navigator'

let g:tmux_navigator_no_mappings = 1

Plug 'knsh14/vim-github-link'

""""""""""""""

" Plug 'JamshedVesuna/vim-markdown-preview'

" let vim_markdown_preview_github=1
" let vim_markdown_preview_use_xdg_open=1

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function'
Plug 'sgur/vim-textobj-parameter'
let g:vim_textobj_parameter_mapping = 'a'
Plug 'bkad/CamelCaseMotion'
map <silent> X <Plug>CamelCaseMotion_w
omap <silent> iX <Plug>CamelCaseMotion_ie
xmap <silent> iX <Plug>CamelCaseMotion_ie
" Plug 'Julian/vim-textobj-variable-segment'

" Plug 'github/copilot.vim'
let g:copilot_browser = []
" imap <silent><script><expr> <C-f> copilot#Accept("\<CR>")
" imap <silent><script><expr> <C-j> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" Plug 'vim-scripts/DoxygenToolkit.vim'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'samoshkin/vim-mergetool'
let g:mergetool_layout = 'mr'
let g:mergetool_prefer_revision = 'local'
" Plug 'tpope/vim-dispatch'

Plug 'Krasjet/auto.pairs'
" Plug 'windwp/nvim-autopairs'

Plug 'justinmk/vim-sneak'
let g:sneak#s_next = 1

Plug 'tpope/vim-sleuth'

Plug 'm-pilia/vim-ccls'

Plug 'ericcurtin/CurtineIncSw.vim'

let g:vimspector_enable_mappings = 'HUMAN'

Plug 'puremourning/vimspector'

Plug 'antoinemadec/coc-fzf'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

call plug#end()            " required

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99

command! -nargs=0 A :call CurtineIncSw()
filetype plugin indent on    " required
syntax on

" set fixed height of preview window
set previewheight=20
au BufEnter ?* call PreviewHeightWorkAround()
func PreviewHeightWorkAround()
    if &previewwindow
        exec 'setlocal winheight='.&previewheight
    endif
endfunc

" close preview window for completion
set completeopt-=preview

" For prototxt
au Filetype prototxt setl ts=2 sts=2 sw=2
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml 
au Filetype yaml setl ts=2 sts=2 sw=2

autocmd VimEnter * call fzf#vim#with_preview('right:50%:hidden', '?')

tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"

nmap ˙ <A-h>
nmap ∆ <A-j>
nmap ˚ <A-k>
nmap ¬ <A-l>
nmap « <A-\>
nmap « <A-r>
nmap ¨ <A-u>
nmap ß <A-s>
nmap ´ <A-e>
nmap ç <A-c>
nmap ø <A-o>

tmap ˙ <A-h>
tmap ∆ <A-j>
tmap ˚ <A-k>
tmap ¬ <A-l>

nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
nnoremap <silent> <A-l> :TmuxNavigateRight<cr>
nnoremap <silent> <A-\> :TmuxNavigatePrevious<cr>

tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l

nmap <A-r> <Plug>BuildAndRun
nmap <A-u> <Plug>Run
nmap <A-s> <Plug>SelectConfig
nmap <A-e> <Plug>OpenConfig
nmap <A-c> :Tclose<cr>
nmap <A-o> :Topen<cr>

function! g:ConfigCallback()
    execute 'silent !cd '.g:cpp_project_props['build_dir'].'/..'
    execute 'silent !ln -sf ' . g:cpp_project_props['build_dir'] . '/compile_commands.json '.g:cpp_project_props['build_dir'].'/..'
    if exists(':CocRestart')
        execute 'CocRestart'
    endif
endfunction

inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

lua <<EOF

local ok, _ = pcall(require, 'nvim-treesitter.configs')
if ok then
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "viw",
      node_incremental = "viw",
      scope_incremental = "vis",
      node_decremental = "vdw",
    },
  },
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
end

EOF

set background=light

let g:airline_theme = 'edge'
let g:edge_current_word = 'underline'
let g:edge_diagnostic_text_highlight = 1
let g:edge_enable_italic = 1
function! s:edge_custom() abort
  " Link a highlight group to a predefined highlight group.
  " See `colors/edge.vim` for all predefined highlight groups.
  let s:configuration = edge#get_configuration()
  let s:palette = edge#get_palette(s:configuration.style)
  call edge#highlight('None', s:palette.none, s:palette.none)
  call edge#highlight('CustomParameter', s:palette.fg, s:palette.none, 'italic,nocombine')
  call edge#highlight('CustomProperty', s:palette.red, s:palette.none, 'italic,nocombine')
  highlight! link TSVariable None
  highlight! link TSParameter CustomParameter
  highlight! link TSProperty CustomProperty
  highlight! link TSVariableBuiltin Cyan
  highlight! link CocSem_property TSProperty
  highlight! link TSNamespace Green
endfunction
augroup EdgeCustom
  autocmd!
  autocmd ColorScheme edge call s:edge_custom()
augroup END
colorscheme edge
" hi CocHighlightText gui=underline
" hi CocHighlightText guibg=none guifg=none gui=underline
" hi DiffAdd ctermbg=235 ctermfg=108 cterm=reverse guibg=#262626 guifg=#9FFFB9 gui=reverse
" hi DiffChange ctermbg=235 ctermfg=103 cterm=reverse guibg=#262626 guifg=#8787af gui=reverse
" hi DiffDelete ctermbg=235 ctermfg=131 cterm=reverse guibg=#262626 guifg=#FFAFA0 gui=reverse
" hi DiffText ctermbg=235 ctermfg=208 cterm=reverse guibg=#262626 guifg=#ff8700 gui=reverse
" let g:coc_default_semantic_highlight_groups=1
" hi! link CocSem_function Function
" hi! link CocSem_macro PreProc
" hi! link CocSem_type Typedef
" hi! link CocSem_enum Typedef
" hi! link CocSem_class Typedef
" hi! link CocSem_parameter TODO

" copy to attached terminal using the yank(1) script:
" https://github.com/sunaku/home/blob/master/bin/yank
function! Yank(text) abort
  let escape = system('yank', a:text)
  if v:shell_error
    echoerr escape
  else
    call writefile([escape], '/dev/tty', 'b')
  endif
endfunction

" automatically run yank(1) whenever yanking in Vim
" (this snippet was contributed by Larry Sanderson)
function! CopyYank() abort
  call Yank(join(v:event.regcontents, "\n"))
endfunction
autocmd TextYankPost * call CopyYank()

packadd termdebug
let g:termdebug_wide = 1

nmap <leader>mt <plug>(MergetoolToggle)
nmap <leader>dg :diffget<cr>
nmap <leader>dp :diffput<cr>

