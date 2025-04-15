"
" MISCELLANEOUS BEHAVIOR
"
" Use syntax highlighting and filetyping.
:syntax on
:filetype plugin on
" Keep 100 commands in the history
set history=100
" Always show the status line with ruler.  Don't show the mode name.
set laststatus=2 ruler showmode
" Show matching (), {}, [] pairs
set showmatch
" Treat . [ * special in patterns
set magic
" Do not interpret modeline directives in files we open (more secure)
set nomodeline
" Enable CSS in exported HTML (see :TOhtml)
"let html_use_css = 1
let html_number_lines = 1
" Highlight search results
set hlsearch
" File suffixes to ignore for editing selection (via :e).
set suffixes=.aux,.dvi,.gz,.idx,.log,.ps,.swp,.o,.tar,.tgz,~
" File name tab completion should be more like the shell's
set wildmode=longest,list
" Enable backspace to do everything
set backspace=indent,eol,start
" Activate our skeleton generator whenever we open a new source file
"autocmd BufNewFile * 1,$!/home/dap/bin/skel <afile>
" Don't show me the begware screen.
set shortmess=I

" Try enabling the mouse for a while
set mouse=n

"
" NAVIGATION
"
" Don't rudely jump to the start of the line when moving up/down.
set nostartofline
" Cursor should never be more than 5 lines from the top or bottom
set scrolloff=5

"
" SHORTCUTS
"
nmap [b :buffers<C-m>:buffer
nmap [d :buffers<C-m>:bdelete

"
" FORMATTING
"
" Use 8-space tabs
set shiftwidth=8
" Don't expand tabs to spaces.
set noexpandtab
" Emacs-like auto-indent for C (only indent when I hit tab in column 0)
set cinkeys=0{,0},:,0#,!0<Tab>,!^F
" Keep return types <t> and parameters <p> in K&R-style C at the left edge <0>
" Indent continuation lines/lines with unclosed parens 4 spaces <+4,(4,u4,U1>
" Don't indent case labels within a switch <:0>
set cinoptions=p0,t0,+4,(4,u0,U1,:0

"
" FILETYPES
"
" Default settings here.  The rest are in .vim/ftdetect and .vim/after.
set noexpandtab
set shiftwidth=8
set tabstop=8
set autoindent
set formatoptions=tcroq
set textwidth=80
set number

augroup Binary
  au!
  au BufReadPre  *.o let &bin=1
  au BufReadPost *.o if &bin | %!xxd
  au BufReadPost *.o set ft=xxd | endif
  au BufWritePre *.o if &bin | %!xxd -r
  au BufWritePre *.o endif
  au BufWritePost *.o if &bin | %!xxd
  au BufWritePost *.o set nomod | endif
augroup END

"
" CSCOPE settings
" Originally by Jason Duell (jduell@alumni.princeton.edu), 2002/3/7
"
" Test to see if vim was built with '--enable-cscope'.
if has("cscope")

    " Use cscope by default (can be cscope-fast for illumos)
    set cscopeprg=cscope
    " Use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag
    " Check cscope for definition of a symbol before checking ctags (1 for reverse)
    set csto=0

    if filereadable("cscope.out")
        cs add cscope.out
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    set cscopeverbose
    
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

endif

"
" Asciidoc overrides
" These came from the "Example ~/.vimrc File" in the "Asciidoc User Guide" at
" https://www.methods.co.nz/asciidoc/.
"
autocmd BufEnter *.adoc :set formatoptions=tcqn formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\\|^\\s*<\\d\\+>\\s\\+\\\\|^\\s*[a-zA-Z.]\\.\\s\\+\\\\|^\\s*[ivxIVX]\\+\\.\\s\\+ comments=s1:/*,ex:*/,://,b:#,:%,:XCOMM,fb:-,fb:*,fb:+,fb:.,fb:>
autocmd BufEnter *.adoc :set textwidth=0

"
" Rust settings
"
" In the past, I overrode rustfmt to use the nightly build so that it doesn't
" barrel on ignoring a bunch of unstable flags that might be set.  This may
" still be useful for Dropshot.
"let g:rustfmt_command = "rustfmt +nightly --edition=2018"
"let g:rustfmt_command = "cargo fmt --"
"
" In the past, we included `--edition` here, but a better solution is to put the
" edition into rustfmt.toml for each crate.
" We do specify `--color=never` because in some error cases it seems to spit out
" color that makes it hard to see the actual error message.
let g:rustfmt_command = "rustfmt --color=never"
" For whatever reason, the plugin is not correctly determining whether to use
" --write-mode=display or --emit=stdout
let g:rustfmt_emit_files = 1

" rust.vim seems to override these settings that were set above.
" TODO there's probably a better place to put these.
autocmd BufEnter *.rs :set formatoptions-=l
autocmd BufEnter *.rs :set textwidth=80
" For Rust, remap my cscope binding to use LSP for definitions.
autocmd BufEnter *.rs :nmap <C-\>s :LspReference<CR>
autocmd BufEnter *.rs :nmap <C-\>g :LspDefinition<CR>
autocmd BufEnter *.rs :nmap <C-\>f :LspWorkspaceSymbol<CR>
" These aren't analogs for cscope bindings, but they're useful!
autocmd BufEnter *.rs :nmap <C-\>a :LspCodeAction<CR>
autocmd BufEnter *.rs :nmap <C-\>r :RustFmt<CR>
autocmd BufEnter *.rs :nmap <C-\>h :LspHover<CR>
" Disable automatic diagnostics while I'm typing.
let g:lsp_diagnostics_enabled = 0
" Disable automatic highlights while I'm typing.
let g:lsp_document_highlight_enabled = 0
" Disable the "sign" in the gutter that shows up when code actions are available
let g:lsp_document_code_action_signs_enabled = 0
" Don't autocomplete for every character I type.
let g:asyncomplete_auto_popup = 0
" Instead, autocomplete when I type <tab> after a non-whitespace
" character.  This snippet comes from the "asyncomplete.vim" README.
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Configure the RLS server to use rust-analyzer.
if executable('rust-analyzer')
  let g:lsp_log_file=expand("~/.vim/vim-lsp.log")
  au User lsp_setup call lsp#register_server({
      \ 'name': 'rust-analyzer',
      \ 'cmd': {server_info->['rust-analyzer']},
      \ 'whitelist': ['rust'],
      \ 'initialization_options': {
      \    'check': {
      \        'extraArgs': [ '--target-dir', 'target/rust-analyzer-dap' ]
      \    },
      \    'cargo': {
      \        'extraArgs': [ '--target-dir', 'target/rust-analyzer-dap' ]
      \    },
      \    'procMacro': { 'enable': v:true, },
      \    'assist': {
      \         'importGranularity': 'item',
      \         'importGroup': v:false
      \    },
      \ },
      \ })

  " Have rust-analyzer reload the workspace.  This is often necessary after
  " Cargo.toml updates, for example.  Copied from
  " https://github.com/mattn/vim-lsp-settings.
  function! s:reload_workspace() abort
      call lsp#callbag#pipe(
          \ lsp#request('rust-analyzer', {
          \   'method': 'rust-analyzer/reloadWorkspace',
          \ }),
          \ lsp#callbag#subscribe({
          \   'next': {x -> execute('echo "Cargo workspace reloaded"', '')},
          \   'error': {e -> lsp_settings#utils#error(e)},
          \ })
          \ )
  endfunction

  command! LspCargoReload call <SID>reload_workspace()
endif

" Go configuration
autocmd BufEnter *.go :nmap <C-\>g :GoDef<CR>
autocmd BufEnter *.go :nmap <C-\>h :GoInfo<CR>
autocmd BufEnter *.go :nmap <C-\>c :GoCallers<CR>
autocmd BufEnter *.go :nmap <C-\>s :GoReferrers<CR>
