" JupNeb vim configuration
" Based on the example vim config provided in the vim package

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
if has('syntax') && has('eval')
  packadd matchit
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Begin Josh Taylor added stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fuzzy finding in all subdirectories
set path+=**
set wildmenu

" Create a ctags file for vim tag hopping
command! MakeTags !ctags -R .

" Build using ninja out-of-source
command! Ninja !ninja -C build

" Support multiple buffers without warnings
set hidden

" Expand tabs to two spaces
set tabstop=2 shiftwidth=2 expandtab


" Use the gruvbox theme
let g:gruvbox_italic=1
"let g:gruvbox_improved_strings=1
"let g:gruvbox_improved_warnings=1
let g:gruvbox_contrast_dark='hard'
set bg=dark
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

" Better colors in the console
set termguicolors

" Powerline
py3 from powerline.vim import setup as powerline_setup
py3 powerline_setup()
py3 del powerline_setup
set laststatus=2

" Line numbers
set relativenumber
set number

" Automatically call clang-format when a C/C++ file is saved
function! Formatonsave()
  let l:formatdiff = 1
  pyf /usr/share/clang/clang-format.py
endfunction
autocmd BufWritePre *.h,*.cc,*.cpp call Formatonsave()

" Automatically open latex files using a saved i3 layout on workspace 7 with a
" preview window using mupdf. Latex files are compiled auotmatically upon
" saving their vim buffer, and the 'r' key is sent to mupdf to signal it to
" reload the pdf file with newly compiled changes. Comment these out if you
" are not using i3 (or are using vim through a plain SSH terminal)
autocmd BufWritePost *.tex !pdflatex % --output-directory=%:p:h; xdotool search --class "mupdf" key r
autocmd BufReadPost *.tex silent !i3-msg "move container to workspace 7 ; workspace 7 ; append_layout ~/.config/i3/latex-7.json"; mupdf %:r.pdf &
