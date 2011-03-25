"=====[ Proper colours are nice ]=================================

colorscheme solarized
syn on

"=====[ Indenting support ]==================

"set wrapmargin=78
set autoindent "Retain indentation on next line
set smartindent "Turn on autoindenting of blocks
" But not magic outdenting of comments...
inoremap # X<C-H>#

" Indent/outdent current block...
map %% $>i}``
map $$ $<i}``

"=====[ Highlight a common mistake ]==================================

" Add new highlight combinations...
highlight YELLOW_ON_BLACK ctermfg=yellow ctermbg=black
highlight WHITE_ON_RED ctermfg=white ctermbg=red

" Track "faux" references...
function! BadRefs ()
match WHITE_ON_RED /_ref[ ]*[[{(]\|_ref[ ]*-[^>]/
endfunction
call BadRefs()


"=====[ Tab handling ]======================================

set tabstop=4 "Indentation levels every four columns
set expandtab "Convert all tabs that are typed to spaces
set shiftwidth=4 "Indent/outdent by four columns
set shiftround "Indent/outdent to nearest tabstop

function! WordTabAsCompletion(direction)
let col = col('.') - 1
echo ""
let prec = getline('.')
if !col || col >=2 && prec[col-2 : col-1] =~ '[^:]:' || prec[col-1] !~ '\k'
return "\<TAB>"
elseif "backward" == a:direction
return "\<C-N>"
else
return "\<C-P>"
endif
endfunction

inoremap <silent> <TAB> <c-r>=WordTabAsCompletion("forward")<CR>
inoremap <silent> <S-TAB> <c-r>=WordTabAsCompletion("backward")<CR>

""=====[ Indenting support ]==================

"set wrapmargin=78
"set autoindent "Retain indentation on next line
"set smartindent "Turn on autoindenting of blocks
"But not magic outdenting of comments...
"inoremap # X<C-H>#
"
"" Indent/outdent current block...
"map %% $>i}``
"map $$ $<i}``


" "Square up visual selections
set virtualedit=block

" "=====[ Toggle syntax highlighting ]==============================
"
" nmap <silent> ;y : if exists("syntax_on") <BAR>
" \ syntax off <BAR>
" \ else <BAR>
" \ syntax enable <BAR>
" \ endif<CR>
"
"
" "=====[ Miscellaneous features ]==================================
"
" set title "Show filename in titlebar of window
" set titleold=
"
" set nomore "Don't page long listings
"
" set autowrite "Save buffer automatically when changing files
" set autoread "Always reload buffer when external changes detected
"
" " What to save in .viminfo...
" set viminfo=h,'50,<10000,s1000,/1000,:100
"
" set backspace=indent,eol,start "BS past autoindents, line boundaries,
" " and even the start of insertion
"
" set matchpairs+=<:>,«:» "Match angle brackets too
"
" set background=dark "When guessing, guess bg is dark
"
"
" set fileformats=unix,mac,dos "Handle Mac and DOS line-endings
" "but prefer Unix endings
"
"
" set wildmode=list:longest,full "Show list of completions
" " and complete as much as possible,
" " then iterate full completions
"
" set noshowmode "Suppress mode change messages
"
"
" set updatecount=10 "Save buffer every 10 chars typed
"
"
" set textwidth=78 "Wrap at column 78
"
" set scrolloff=2 "Scroll when 2 lines from top/bottom
"
" set ruler "Show cursor location info on status line
"
" " Use space to jump down a page (like browsers do)...
" noremap <Space> <PageDown>
"
" " Keycodes and maps timeout in 3/10 sec...
" set timeout timeoutlen=300 ttimeoutlen=300
"
"
" "=====[ Smarter completion ]==================================
"
" "Add file of std words for <TAB> completion...
" set complete+=k~/.vim/std_completions
"
" "Adjust keyword characters for Perlish identifiers...
" set iskeyword+=:
" set iskeyword+=$
" set iskeyword+=%
" set iskeyword+=@
" set iskeyword-=,
"
"
" "=====[ Smarter searching ]==================================
"
" set incsearch "Lookahead as search pattern specified
" set ignorecase "Ignore case in all searches...
" set smartcase "...unless uppercase letters used
" set hlsearch "Highlight all search matches
"
" "Key mapping to switch off highlighting till next search...
" map H :nohlsearch<CR>
"
"
" "=====[ File navigation ]==================================
"
" " Edit a file...
" map e :n
"
" " Forward/back one file...
" map <DOWN> :next<CR>0
" map <UP> :prev<CR>0
"
" " Swap back to alternate file...
" map g :w<CR>:e #<CR>
"
"
" "=====[ Text formatting ]==================================
"
" " Format file with perltidy...
" map ;t 1G!Gperltidy<CR>
"
"
" " Format file with autoformat (capitalize to specify options)...
" map F !Gformat -T4 -
" map <silent> f !Gformat -T4<CR>
"
"
" "=====[ Run Perl programs from within vim ]========================
"
" " Execute Perl file...
" map W :!clear;perl -w %<CR>
"
" " Debug Perl file...
" map Q :!perl -d %<CR>
"
" " Run perldoc...
" map ?? :!pd
" set keywordprg=pd
"
"
" "=====[ Cut and paste from MacOSX clipboard ]====================
"
" nmap <silent> <C-P> :set paste<CR>
" \!!pbtranspaste<CR>
" \:set nopaste<CR>
" \:set fileformat=unix<CR>
"
" vmap <silent> <C-P> x:call TransPaste(visualmode())<CR>
"
" function! TransPaste(type)
" let reg_save = @@
"
" let clipboard = system("pbtranspaste")
"
" call setreg('@', clipboard, a:type)
"
" silent exe "normal! P"
"
" let @@ = reg_save
" endfunction
"
"
" nmap <silent> <C-C> :w !pbtranscopy<CR><CR>
" vmap <silent> <C-C> :<C-U>call TransCopy(visualmode(), 1)<CR>
"
" function! TransCopy(type, ...)
" let sel_save = &selection
" let &selection = "inclusive"
" let reg_save = @@
"
" if a:0 " Invoked from Visual mode, use '< and '> marks.
" silent exe "normal! `<" . a:type . "`>y"
" elseif a:type == 'line'
" silent exe "normal! '[V']y"
" elseif a:type == 'block'
" silent exe "normal! `[\<C-V>`]y"
" else
" silent exe "normal! `[v`]y"
" endif
"
" call system("pbtranscopy", @@)
"
" let &selection = sel_save
" let @@ = reg_save
" endfunction
"
"
" "=====[ Insert cut marks ]================================
"
" map -- A<CR><CR><CR><ESC>k6i-----cut-----<ESC><CR>
"
"
" "=====[ Manage tabs ]================================
"
" " Convert file to different tabspacings
"
" function! NewTabSpacing (newtabsize)
" let was_expanded = &expandtab
" normal TT
" execute "set ts=" . a:newtabsize
" execute "set sw=" . a:newtabsize
" execute "map F !Gformat -T" . a:newtabsize . " -"
" execute "map <silent> f !Gformat -T" . a:newtabsize . "<CR>"
" if was_expanded
" normal TS
" endif
" endfunction
"
" map <silent> T! :call NewTabSpacing(1)<CR>
" map <silent> T@ :call NewTabSpacing(2)<CR>
" map <silent> T# :call NewTabSpacing(3)<CR>
" map <silent> T$ :call NewTabSpacing(4)<CR>
" map <silent> T% :call NewTabSpacing(5)<CR>
" map <silent> T^ :call NewTabSpacing(6)<CR>
" map <silent> T& :call NewTabSpacing(7)<CR>
" map <silent> T* :call NewTabSpacing(8)<CR>
" map <silent> T( :call NewTabSpacing(9)<CR>
"
" " Convert to/from spaces/tabs...
" map <silent> TS :set expandtab<CR>:%retab!<CR>
" map <silent> TT :set noexpandtab<CR>:%retab!<CR>
"
"
" "=====[ Spelling support ]==================================
"
" " Correct common mistypings in-the-fly...
" iab retrun return
" iab pritn print
" iab teh the
" iab liek like
" iab liekwise likewise
" iab Pelr Perl
" iab pelr perl
" iab ;t 't
" iab moer more
" iab previosu previous
"
" " Ring the bell every time "it's" is typed...
" imap it's it's<ESC><ESC>a
"
"
" "=====[ Insert mode shortcuts ]==================================
"
" " Insert shebang lines...
" iab hbc #! /bin/csh
" iab hbs #! /bin/sh
" iab hbp #! /usr/bin/perl -w
"
" " Insert common Perl code structures...
" iab udd use Data::Dumper 'Dumper';<CR>warn Dumper [];<ESC>hi
" iab ubm use Benchmark qw( cmpthese );<CR><CR>cmpthese -10, {<CR>};<ESC>O
" iab usc use Smart::Comments;<CR>###
" iab pnl print \n";<ESC>3hi
" iab uts use Test::Simple 'no_plan';
" iab utm use Test::More 'no_plan';
" iab dbs $DB::single = 1;<ESC>
"
" iab <silent> rov Readonly my => ????;<ESC>9h:silent call
" SetEscapesToNextField("2l")<CR>a
"
"
" "=====[ Highlight a common mistake ]==================================
"
" " Add new highlight combinations...
" highlight YELLOW_ON_BLACK ctermfg=yellow ctermbg=black
" highlight WHITE_ON_RED ctermfg=white ctermbg=red
"
" " Track "faux" references...
" function! BadRefs ()
" match WHITE_ON_RED /_ref[ ]*[[{(]\|_ref[ ]*-[^>]/
" endfunction
" call BadRefs()
"
"
" "=====[ Tab handling ]======================================
"
" set tabstop=4 "Indentation levels every four columns
" set expandtab "Convert all tabs that are typed to spaces
" set shiftwidth=4 "Indent/outdent by four columns
" set shiftround "Indent/outdent to nearest tabstop
"
" function! WordTabAsCompletion(direction)
" let col = col('.') - 1
" echo ""
" let prec = getline('.')
" if !col || col >=2 && prec[col-2 : col-1] =~ '[^:]:' || prec[col-1] !~ '\k'
" return "\<TAB>"
" elseif "backward" == a:direction
" return "\<C-N>"
" else
" return "\<C-P>"
" endif
" endfunction
"
" inoremap <silent> <TAB> <c-r>=WordTabAsCompletion("forward")<CR>
" inoremap <silent> <S-TAB> <c-r>=WordTabAsCompletion("backward")<CR>
"
"
" "=====[ Grammar checking ]========================================
"
" let g:check_grammar = 0
"
" function! CheckGrammar ()
" if g:check_grammar
" "match WHITE_ON_RED /_ref[ ]*[[{(]\|_ref[ ]*-[^>]/
" call BadRefs()
" let g:check_grammar = 0
" else
" match WHITE_ON_RED
" /\c\<your\>\|\<you're\>\|\<it's\>\|\<its\>\|\<we're\>\|\<were\>\|\<where\>\|\<they're\>\|\<there\>\|\<their\>/
" let g:check_grammar = 1
" endif
" echo ""
" endfunction
"
" " Toggle grammar checking...
" map <silent> ;g :call CheckGrammar()<CR>``
"
"
" "=====[ Add or subtract comments ]===============================
"
" function! ToggleComment ()
" let currline = getline(".")
" if currline =~ '^#'
" s/^#//
" elseif currline =~ '\S'
" s/^/#/
" endif
" endfunction
"
" map <silent> # :call ToggleComment()<CR>j0
"
"
" "=====[ Highlight cursor column on request ]===================
"
" highlight CursorColumn term=bold ctermfg=black ctermbg=green
"
" map <silent> ;c :set cursorcolumn!<CR>
"
"
" "=====[ Highlight spelling errors on request ]===================
"
" set spelllang=en_au
" map <silent> ;s :setlocal invspell<CR>
"
