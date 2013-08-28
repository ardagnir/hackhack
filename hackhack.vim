" Vim global plugin for a vim-mode command line
" Last Change: Aug 28 2013
" Maintainer: James Kolb
"
" Copyright (C) 2013, James Kolb. All rights reserved.
"
" This program is free software: you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" (at your option) any later version.
" 
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
" 
" You should have received a copy of the GNU General Public License
" along with this program.  If not, see <http://www.gnu.org/licenses/>.

let s:save_cpo = &cpo
set cpo&vim
if exists("g:loaded_hackhack")
  finish
endif
let g:loaded_hackhack = 1

"CommandName, WindowName (default is hackhack)
function! HackHack(commandName, ...)
  if a:0>0
    let windowName=a:1
  else
    let windowName="HackHack"
  endif
  setlocal updatetime=200
  exec "ConqueTerm ".a:commandName
  hi HHBorder ctermfg=DarkBlue cterm=bold guifg=darkgrey
  hi HHPrompt ctermfg=DarkCyan  guifg=darkgrey
  setlocal statusline=%#HHBorder#-\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ %<
  "nnoremap <buffer> s <C-W>j
  call matchadd('HHPrompt', '^>')
  call matchadd('HHPrompt', '^\.')
  exec "belowright 1 split ".windowName
  setlocal noswapfile
  setlocal bufhidden=hide
  setlocal buftype=nofile
  exec "normal! i>  "
  "nnoremap <buffer> s <C-W>k
  inoremap <silent> <buffer> <CR> <ESC>:call <SID>CarriageReturn(1)<CR>A
  nnoremap <silent> <buffer> <CR> :call <SID>CarriageReturn(0)<CR>
  autocmd  CursorHoldI <buffer> call <SID>UpdateTerminal(1)
  autocmd  CursorHold <buffer> call <SID>UpdateTerminal(0)
  autocmd  VimResized <buffer> exec "normal!\<C-W>100-"
  autocmd  InsertEnter <buffer> call <SID>FixPrompt(1)
  autocmd  CursorMovedI <buffer> call <SID>FixPrompt(1)
  autocmd  CursorMoved <buffer> call <SID>FixPrompt(0)
  inoremap <silent> <buffer> <UP> <C-O>:call <SID>HistoryUp()<CR>
  inoremap <silent> <buffer> <DOWN> <C-O>:call <SID>HistoryDown()<CR>
  nnoremap <silent> <buffer> <UP>  @=":call <SID>HistoryUp()<C-V><CR>"<CR>:echo ""<CR>
  nnoremap <silent> <buffer> <DOWN>  @=":call <SID>HistoryDown()<C-V><CR>"<CR>:echo ""<CR>
  nnoremap <silent> <buffer> k  @=":call <SID>HistoryUp()<C-V><CR>"<CR>:echo ""<CR>
  nnoremap <silent> <buffer> j  @=":call <SID>HistoryDown()<C-V><CR>"<CR>:echo ""<CR>
  inoremap <silent> <buffer> <TAB> <ESC>:call <SID>TabPress()<CR>A
  nnoremap <silent> <buffer> / :call <SID>Search('/')<CR>A
  nnoremap <silent> <buffer> ? :call <SID>Search('?')<CR>A
  nnoremap <silent> <buffer> n @=":call <SID>NextSearch(1)<C-V><CR>"<CR>:echo ""<CR>
  nnoremap <silent> <buffer> N @=":call <SID>NextSearch(-1)<C-V><CR>"<CR>:echo ""<CR>
  nnoremap <silent> <buffer> <C-C> :call <SID>SendLine("\x03")<CR>
  inoremap <silent> <buffer> <C-C> <C-O>:call <SID>SendLine("\x03")<CR>
  nnoremap <silent> <buffer> <C-D> :call <SID>SendLine("\x04")<CR>
  inoremap <silent> <buffer> <C-D> <C-O>:call <SID>SendLine("\x04")<CR>
  nnoremap <silent> <buffer> gg :call <SID>GotoHistoryBeginning()<CR>
  nnoremap <silent> <buffer> G :call <SID>GotoHistoryEnd()<CR>
  call matchadd('HHPrompt', '^.')

  "stop updates from breaking window switches:"
  nnoremap <unique> <C-W><ESC> <C-W><ESC>
  call s:MapRegisters()

  wincmd k
  call s:ReadAndUpdatePromptChar(200)
  normal!0i>
  wincmd j
  normal!dd
endfunction
"eventully i should name my terminals and input windows
"and loop through each input window updating it's terminal
"

let s:TypingSearch=0
let s:AllowPromptFixing=1
let s:NormalPromptChar='>'
let s:PromptChar=s:NormalPromptChar
let s:TempBuffer=""
let s:TempBufferIndex=-1
let s:BufferMarker="."

function! s:GotoHistoryBeginning()
  if s:TypingSearch
    return
  endif
  call s:StoreTempBuffer()
  call s:RemoveArrow()
  let s:HistoryIndex=len(s:History)
  call s:GrabFromHistory()
  call s:AddArrow()
endfunction

function! s:GotoHistoryEnd()
  if s:TypingSearch
    return
  endif
  call s:StoreTempBuffer()
  call s:RemoveArrow()
  let s:HistoryIndex=0
  call s:GrabFromHistory()
  call s:AddArrow()
endfunction

function! s:FixPrompt(insertMode)
  if !s:AllowPromptFixing
    return
  endif
  while getpos('.')[1]>1
    normal!gg"_ddG
  endwhile
  if getpos('.')[2]==1
    let tempReg=getreg('"', 1)
    let regType=getregtype('"')
    normal!yl
    let capturedKey=@"
    call setreg('"',tempReg,regType)
    if capturedKey!=s:PromptChar
      exec "normal!i".s:PromptChar
    endif
    normal!l
  endif
  if getpos('.')[2]<=2
    let tempReg=getreg('"', 1)
    let regType=getregtype('"')
    normal!yl
    let capturedKey=@"
    call setreg('"',tempReg,regType)
    if capturedKey!=" "
      exec "normal!0a "
    endif
    normal!l
  endif
  "extra steps need to be taken for a blank line in insert mode
  if getpos('.')[2]<=2 && a:insertMode
    startinsert!
  endif
endfunction

let s:SearchTerm=""

function! s:NextSearch(direction)
  if s:TypingSearch
    return
  endif
  if s:SearchMode=='?'
    let direction=-a:direction
  else
    let direction=a:direction
  endif
  let s:MatchCount=s:MatchCount+direction
  let g:searchLocation=match(s:History,s:SearchTerm,0, s:MatchCount)
  if g:searchLocation>=0 && s:MatchCount>0
    call s:StoreTempBuffer()
    call s:RemoveArrow()
    let s:HistoryIndex=len(s:History)-g:searchLocation
    call s:GrabFromHistory()
    call s:AddArrow()
  else
    let s:MatchCount=s:MatchCount-direction
  endif
endfunction

function! s:Search(mode)
  let s:AllowPromptFixing=0
  let s:SearchMode=a:mode 
  let s:TypingSearch=1
  call s:StoreTempBuffer()
  exec "normal!\"_ddI".a:mode." "
  let s:PromptChar=a:mode
  let s:AllowPromptFixing=1
endfunction

function! s:GrabCommandLine()
  let tempReg=getreg('"', 1)
  let regType=getregtype('"')
  normal!02lD"_dd
  let ret=@"
  call setreg('"',tempReg,regType)
  return ret
endfunction

function! s:DoSearch()
  let s:PromptChar=s:NormalPromptChar
  "match ignores smartcase, so if smartcase is set and there are NO upper case
  "in search, we'll perform a case insenesitve search ourselves
  let reverseHistoryIndex=len(s:History)-s:HistoryIndex
  let caseMagic=0
  let s:SearchTerm=s:GrabCommandLine()
  let s:MatchCount=0
  let searchLocation=-2
  while searchLocation<reverseHistoryIndex && searchLocation!=-1
    let s:MatchCount=s:MatchCount+1
    let searchLocation=match(s:History,s:SearchTerm,0, s:MatchCount)
  endwhile
  if s:SearchMode=="/" && searchLocation==reverseHistoryIndex
    let s:MatchCount=s:MatchCount+1
    let searchLocation=match(s:History,s:SearchTerm,0, s:MatchCount)
  elseif s:SearchMode=="?"
    let s:MatchCount=s:MatchCount-1
    let searchLocation=match(s:History,s:SearchTerm,0, s:MatchCount)
  endif

  let s:TypingSearch=0
  if searchLocation>=0
    call s:RemoveArrow()
    let s:HistoryIndex=len(s:History)-searchLocation
    call s:GrabFromHistory()
    call s:AddArrow()
  endif
endfunction

function! s:ReadAndUpdatePromptChar(howLong)
    let readInput=conque_term#get_instance().read(a:howLong)
    let possiblePromptIndex=len(readInput)-1
    while readInput[possiblePromptIndex]==" " && possiblePromptIndex>1
      let possiblePromptIndex=possiblePromptIndex-1
    endwhile

    if readInput[possiblePromptIndex]!=" " && readInput[possiblePromptIndex]!=""
      let oldPromptChar=s:PromptChar
      let s:NormalPromptChar=readInput[possiblePromptIndex]
      if !s:TypingSearch
        let s:PromptChar=s:NormalPromptChar
      endif
      if s:PromptChar!=oldPromptChar
        wincmd j
        let pos = getpos('.')
        exec "normal!0r".s:PromptChar
        call setpos('.',pos)
        wincmd k
      endif
    endif
endfunction

function! s:UpdateTerminal(insert_mode)
    wincmd k
    normal!G0"_x
    call s:ReadAndUpdatePromptChar(1)
    let s:ZeroArrowPoint=getpos('.')[1]
    if s:HistoryIndex==0 
      normal!0i>
    elseif s:TempBufferIndex==0
      exec "normal!I".s:BufferMarker
    else
      exec "normal!I "
    endif
    call s:GotoArrowLine()
    wincmd j
    call s:RestartUpdateCounter(a:insert_mode)
endfunction! s:

function! s:TabPress()
    let s:AllowPromptFixing=0
    let tempReg=getreg('"', 1)
    let regType=getregtype('"')
    normal! 02ld$
    let capturedKeys=@"
    call setreg('"',tempReg,regType)
    silent wincmd k
    call conque_term#get_instance().write(capturedKeys."\t")
    let tabcompletevar=""
    let sanity=10
    while sanity > 0 && (tabcompletevar=="" || tabcompletevar==capturedKeys)
      let tabcompletevar=tabcompletevar.conque_term#get_instance().read(50,0)
      let sanity=sanity-1
    endwhile
    call conque_term#get_instance().write("\x15")
    call conque_term#get_instance().read(50,0)
    silent wincmd j
    exec "normal!\"_ddA".s:PromptChar." ".tabcompletevar
    let s:AllowPromptFixing=1
endfunction

function! s:RestartUpdateCounter(insert_mode)
    if a:insert_mode
        call feedkeys("\<C-o>f\e", "n")
    else
        call feedkeys("f\e", "n")
    endif
endfunction

let s:History = []
let s:HistoryIndex=0
let s:HistoryLine=[]
let s:ZeroArrowPoint=0

let s:SearchMode=' '


function! s:SendLine(line)
  call s:RemoveArrow()
  silent wincmd k
  normal!G
  let s:History=s:History+[a:line[0:-2]]
  let s:ZeroArrowPoint=getpos('.')[1]
  let s:HistoryLine=s:HistoryLine+[s:ZeroArrowPoint]
  let s:HistoryIndex=0
  call conque_term#get_instance().write(a:line)
  normal!0"_x
  call s:ReadAndUpdatePromptChar(100)
  exec "normal!".s:ZeroArrowPoint."ggI "
  normal!G
  let s:ZeroArrowPoint=getpos('.')[1]
  exec "normal!G0i>\<ESC>$"
  silent wincmd j
endfunction

"breaks register
function! s:CarriageReturn(insertMode)
  if s:TypingSearch!=0
    call s:DoSearch()
    call feedkeys("\<ESC>",'n')
    return
  endif
  call s:EraseOldBufferMarker()
  let s:TempBuffer=""
  let s:TempBufferIndex=-1
  let capturedKeys=s:GrabCommandLine()
  call s:SendLine(capturedKeys."\n")
  call s:RestartUpdateCounter(a:insertMode)
endfunction

function! s:TestTop()
  call conque_term#get_instance().write("top\n")
  let g:result=conque_term#get_instance().read(1000)
endfunction

function! s:EraseOldBufferMarker()
  if s:TempBufferIndex>=0
    wincmd k
    if s:TempBufferIndex==0
      exec "normal!".s:ZeroArrowPoint."gg"
    else
      exec "normal!".s:HistoryLine[-s:TempBufferIndex]."gg"
    endif
    exec "normal!0r "
    wincmd j
  endif
endfunction


function! s:StoreTempBuffer()
  if s:HistoryIndex!=0
    let historyLine=s:History[-s:HistoryIndex]
  else
    let historyLine=s:TempBuffer
  endif
  let commandLine=s:GrabCommandLine()
  if historyLine!=commandLine && historyLine." "!=commandLine
    call s:EraseOldBufferMarker()
    let s:TempBuffer=commandLine
    if commandLine!="" && commandLine!=" "
      let s:TempBufferIndex=s:HistoryIndex
    else
      let s:TempBufferIndex=-1
    endif
  endif
endfunction

function! s:HistoryUp()
  if s:HistoryIndex<len(s:History)
    if s:TypingSearch
      return
    endif
    call s:StoreTempBuffer()
    call s:RemoveArrow()
    let s:HistoryIndex=s:HistoryIndex+1
    call s:GrabFromHistory()
    call s:AddArrow()
  endif
endfunction

function! s:HistoryDown()
  if s:TypingSearch
    return
  endif 
  call s:StoreTempBuffer()
  call s:RemoveArrow()
  let s:HistoryIndex=s:HistoryIndex-1
  if s:HistoryIndex<0
    let s:HistoryIndex=0
  endif
  call s:GrabFromHistory()
  call s:AddArrow()
endfunction

function! s:GotoArrowLine()
  if s:HistoryIndex==0
    exec "normal!".s:ZeroArrowPoint."gg"
  else
    exec "normal!".s:HistoryLine[-s:HistoryIndex]."gg"
  endif
endfunction

function! s:RemoveArrow()
  wincmd k
  call s:GotoArrowLine()
  if s:HistoryIndex==s:TempBufferIndex
    exec "normal!0r".s:BufferMarker."$"
  else
    normal!0r $
  endif
  wincmd j
endfunction

function! s:AddArrow()
  wincmd k
  call s:GotoArrowLine()
  normal!0r>
  wincmd j
endfunction

function! s:GrabFromHistory()
  let s:AllowPromptFixing=0
  "The bottom line always retrieves the temp buffer
  if s:HistoryIndex==s:TempBufferIndex || s:HistoryIndex==0
    normal! 0"_d$
    exec "normal!A".s:PromptChar." ".s:TempBuffer
  else
    let historyLine=s:History[-s:HistoryIndex]
    normal! 0"_d$
    exec "normal!A".s:PromptChar." ".historyLine
  endif
  let s:AllowPromptFixing=1
endfunction

function! s:MapRegisters()
  nnoremap <unique> ""<ESC> ""<ESC>
  nnoremap <unique> "0<ESC> "0<ESC>
  nnoremap <unique> "1<ESC> "1<ESC>
  nnoremap <unique> "2<ESC> "2<ESC>
  nnoremap <unique> "3<ESC> "3<ESC>
  nnoremap <unique> "4<ESC> "4<ESC>
  nnoremap <unique> "5<ESC> "5<ESC>
  nnoremap <unique> "6<ESC> "6<ESC>
  nnoremap <unique> "7<ESC> "7<ESC>
  nnoremap <unique> "8<ESC> "8<ESC>
  nnoremap <unique> "9<ESC> "9<ESC>
  nnoremap <unique> "a<ESC> "a<ESC>
  nnoremap <unique> "b<ESC> "b<ESC>
  nnoremap <unique> "c<ESC> "c<ESC>
  nnoremap <unique> "d<ESC> "d<ESC>
  nnoremap <unique> "e<ESC> "e<ESC>
  nnoremap <unique> "f<ESC> "f<ESC>
  nnoremap <unique> "g<ESC> "g<ESC>
  nnoremap <unique> "h<ESC> "h<ESC>
  nnoremap <unique> "i<ESC> "i<ESC>
  nnoremap <unique> "j<ESC> "j<ESC>
  nnoremap <unique> "k<ESC> "k<ESC>
  nnoremap <unique> "l<ESC> "l<ESC>
  nnoremap <unique> "m<ESC> "m<ESC>
  nnoremap <unique> "n<ESC> "n<ESC>
  nnoremap <unique> "o<ESC> "o<ESC>
  nnoremap <unique> "p<ESC> "p<ESC>
  nnoremap <unique> "q<ESC> "q<ESC>
  nnoremap <unique> "r<ESC> "r<ESC>
  nnoremap <unique> "s<ESC> "s<ESC>
  nnoremap <unique> "t<ESC> "t<ESC>
  nnoremap <unique> "u<ESC> "u<ESC>
  nnoremap <unique> "v<ESC> "v<ESC>
  nnoremap <unique> "w<ESC> "w<ESC>
  nnoremap <unique> "x<ESC> "x<ESC>
  nnoremap <unique> "y<ESC> "y<ESC>
  nnoremap <unique> "z<ESC> "z<ESC>
  nnoremap <unique> "A<ESC> "A<ESC>
  nnoremap <unique> "B<ESC> "B<ESC>
  nnoremap <unique> "C<ESC> "C<ESC>
  nnoremap <unique> "D<ESC> "D<ESC>
  nnoremap <unique> "E<ESC> "E<ESC>
  nnoremap <unique> "F<ESC> "F<ESC>
  nnoremap <unique> "G<ESC> "G<ESC>
  nnoremap <unique> "H<ESC> "H<ESC>
  nnoremap <unique> "I<ESC> "I<ESC>
  nnoremap <unique> "J<ESC> "J<ESC>
  nnoremap <unique> "K<ESC> "K<ESC>
  nnoremap <unique> "L<ESC> "L<ESC>
  nnoremap <unique> "M<ESC> "M<ESC>
  nnoremap <unique> "N<ESC> "N<ESC>
  nnoremap <unique> "O<ESC> "O<ESC>
  nnoremap <unique> "P<ESC> "P<ESC>
  nnoremap <unique> "Q<ESC> "Q<ESC>
  nnoremap <unique> "R<ESC> "R<ESC>
  nnoremap <unique> "S<ESC> "S<ESC>
  nnoremap <unique> "T<ESC> "T<ESC>
  nnoremap <unique> "U<ESC> "U<ESC>
  nnoremap <unique> "V<ESC> "V<ESC>
  nnoremap <unique> "W<ESC> "W<ESC>
  nnoremap <unique> "X<ESC> "X<ESC>
  nnoremap <unique> "Y<ESC> "Y<ESC>
  nnoremap <unique> "Z<ESC> "Z<ESC>
  nnoremap <unique> ":<ESC> ":<ESC>
  nnoremap <unique> ".<ESC> ".<ESC>
  nnoremap <unique> "%<ESC> "%<ESC>
  nnoremap <unique> "#<ESC> "#<ESC>
  nnoremap <unique> "=<ESC> "=<ESC>
  nnoremap <unique> "*<ESC> "*<ESC>
  nnoremap <unique> "+<ESC> "+<ESC>
  nnoremap <unique> "~<ESC> "~<ESC>
  nnoremap <unique> "_<ESC> "_<ESC>
  nnoremap <unique> "/<ESC> "/<ESC>
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
