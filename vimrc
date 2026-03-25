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
" Edit: this was nice for being able to use the scroll wheel, but prevents
" using double-click to select words.
"set mouse=n

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
" I don't want hard wraps in most files by default.
set textwidth=0
set tabstop=8
set autoindent
set formatoptions=tcroq
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
autocmd BufEnter *.rs :nmap <C-\>? :call <SID>lsp_show_status()<CR>
" Enable $/progress notifications from rust-analyzer.  vim-lsp only
" declares window.workDoneProgress:true (needed for rust-analyzer to send
" $/progress at all) when this is set.  We don't subscribe to
" lsp_progress_updated, so the overhead is just vim-lsp's internal
" bookkeeping with no downstream callbacks.
let g:lsp_work_done_progress_enabled = 1
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
  " The following line enables logging.  It's useful for debugging.  But
  " when enabling detailed progress events from rust-analyzer, this causes
  " vim to spend all its cycles writing log output for the whole period
  " while rust-analyzer is loading.
  " let g:lsp_log_file=expand("~/.vim/vim-lsp.log")
  au User lsp_setup call lsp#register_server({
      \ 'name': 'rust-analyzer',
      \ 'cmd': {server_info->['rust-analyzer']},
      \ 'whitelist': ['rust'],
      \ 'initialization_options': {
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

  " dap 2026-02-05: applying this somewhat blindly from
  " https://github.com/prabirshrestha/vim-lsp/issues/871
  call lsp#callbag#pipe(
    \ lsp#stream(),
    \ lsp#callbag#filter({x->has_key(x, 'response') && has_key(x['response'], 'method') && x['response']['method'] ==# 'window/logMessage'}),
    \ lsp#callbag#forEach({x->lsp#utils#echo_with_truncation(x['response']['params']['message'])})
    \ )

  command! LspCargoReload call <SID>reload_workspace()

  " Track rust-analyzer indexing progress and show it in the command line.
  " g:lsp_work_done_progress_enabled (set above) is required for vim-lsp to
  " declare window.workDoneProgress:true so that rust-analyzer sends $/progress
  " at all.  We subscribe to the stream ourselves (like the window/logMessage
  " handler above) so we can rate-limit 'report' events to at most one echo
  " per second.  'begin' and 'end' events are rare and processed immediately.
  let s:ra_progress_tokens    = {}
  let s:ra_progress_info      = ''
  let s:ra_progress_last_echo = -1

  call lsp#callbag#pipe(
      \ lsp#stream(),
      \ lsp#callbag#filter({x ->
      \     has_key(x, 'response') &&
      \     get(x['response'], 'method', '') ==# '$/progress' &&
      \     get(x, 'server', '') ==# 'rust-analyzer'}),
      \ lsp#callbag#subscribe({'next': {x -> s:ra_on_progress(x)}})
      \ )

  function! s:ra_on_progress(data) abort
      let l:params = a:data['response']['params']
      let l:token  = string(l:params['token'])
      let l:kind   = l:params['value']['kind']

      if l:kind ==# 'begin'
          let l:title = l:params['value']['title']
          let s:ra_progress_tokens[l:token] = l:title
          let s:ra_progress_info = '[rust-analyzer] ' . l:title
          echomsg s:ra_progress_info
          return
      endif

      if l:kind ==# 'end'
          if has_key(s:ra_progress_tokens, l:token)
              unlet s:ra_progress_tokens[l:token]
          endif
          if empty(s:ra_progress_tokens)
              let s:ra_progress_info = ''
              " If experimental/serverStatus quiescent:true hasn't arrived
              " (rust-analyzer may not send it), fall back to declaring ready
              " when all progress tokens have drained.  If another phase
              " follows, its 'begin' will immediately overwrite this.
              echomsg '[rust-analyzer] ready (probably)'
          endif
          return
      endif

      " kind == 'report': bail out early if we echoed within the last second.
      let l:now = localtime()
      if l:now == s:ra_progress_last_echo | return | endif
      let s:ra_progress_last_echo = l:now

      let l:title = get(s:ra_progress_tokens, l:token, '')
      let l:msg = '[rust-analyzer]' . (empty(l:title) ? '' : ' ' . l:title)
      let l:pct = get(l:params['value'], 'percentage', -1)
      if l:pct >= 0
          let l:msg .= ' (' . float2nr(l:pct + 0.5) . '%)'
      endif
      let s:ra_progress_info = l:msg
      echomsg l:msg
  endfunction

  " Show the current rust-analyzer status on demand (bound to <C-\>?).
  function! s:lsp_show_status() abort
      let l:status = lsp#get_server_status('rust-analyzer')
      if l:status ==# 'running'
          if !empty(s:ra_progress_info)
              echo s:ra_progress_info
          elseif empty(s:ra_progress_tokens)
              echo '[rust-analyzer] ready (probably)'
          else
              echo '[rust-analyzer] loading...'
          endif
      else
          echo '[rust-analyzer] ' . l:status
      endif
  endfunction

  augroup lsp_rust_progress
      au!
      autocmd User lsp_server_init
          \ if lsp#get_server_status('rust-analyzer') ==# 'running' |
          \     let s:ra_progress_tokens = {} |
          \     let s:ra_progress_info = '' |
          \     echomsg '[rust-analyzer] loading...' |
          \ endif
  augroup END
endif

" Go configuration
autocmd BufEnter *.go :nmap <C-\>g :GoDef<CR>
autocmd BufEnter *.go :nmap <C-\>h :GoInfo<CR>
autocmd BufEnter *.go :nmap <C-\>c :GoCallers<CR>
autocmd BufEnter *.go :nmap <C-\>s :GoReferrers<CR>
