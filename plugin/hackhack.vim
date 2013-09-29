" Vim global plugin for awesome hacktastic hacking
" Last Change: Aug 28 2013
" Maintainer: James Kolb
"
" Copyright (C) 2013, James Kolb. All rights reserved.
"
" This program is free software: you can redistribute it and/or modify
" it under the terms of the GNU Affero General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" (at your option) any later version.
" 
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU Affero General Public License for more details.
" 
" You should have received a copy of the GNU Affero General Public License
" along with this program.  If not, see <http://www.gnu.org/licenses/>.
"

let g:S_save_cpo = &cpo
set cpo&vim
if exists("g:loaded_hackhack")
  finish
endif
let g:loaded_hackhack = 1


"CommandName, WindowName (default is hackhack)
function! HackHack(commandName, ...)
  highlight SignColumn ctermbg=black
  if a:0>0
    let g:S_windowName=a:1
  else
    let g:S_windowName="HackHack"
  endif
  setlocal updatetime=400
  let g:ConqueTerm_TERM='xterm'
  exec "ConqueTerm ".a:commandName
  hi HHBorder ctermfg=DarkBlue cterm=bold guifg=darkgrey
  hi HHPrompt ctermfg=DarkCyan  guifg=darkgrey
  sign define doublearrow text=>> texthl=HHPrompt
  sign define dot text=. texthl=HHPrompt
  sign define a text=a texthl=HHPrompt
  sign define b text=b texthl=HHPrompt
  sign define c text=c texthl=HHPrompt
  sign define d text=d texthl=HHPrompt
  sign define e text=e texthl=HHPrompt
  sign define f text=f texthl=HHPrompt
  sign define g text=g texthl=HHPrompt
  sign define h text=h texthl=HHPrompt
  sign define i text=i texthl=HHPrompt
  sign define j text=j texthl=HHPrompt
  sign define k text=k texthl=HHPrompt
  sign define l text=l texthl=HHPrompt
  sign define m text=m texthl=HHPrompt
  sign define n text=n texthl=HHPrompt
  sign define o text=o texthl=HHPrompt
  sign define p text=p texthl=HHPrompt
  sign define q text=q texthl=HHPrompt
  sign define r text=r texthl=HHPrompt
  sign define s text=s texthl=HHPrompt
  sign define t text=t texthl=HHPrompt
  sign define u text=u texthl=HHPrompt
  sign define v text=v texthl=HHPrompt
  sign define w text=w texthl=HHPrompt
  sign define y text=y texthl=HHPrompt
  sign define z text=z texthl=HHPrompt
  sign define A text=A texthl=HHPrompt
  sign define B text=B texthl=HHPrompt
  sign define C text=C texthl=HHPrompt
  sign define D text=D texthl=HHPrompt
  sign define E text=E texthl=HHPrompt
  sign define F text=F texthl=HHPrompt
  sign define G text=G texthl=HHPrompt
  sign define H text=H texthl=HHPrompt
  sign define I text=I texthl=HHPrompt
  sign define J text=J texthl=HHPrompt
  sign define K text=K texthl=HHPrompt
  sign define L text=L texthl=HHPrompt
  sign define M text=M texthl=HHPrompt
  sign define N text=N texthl=HHPrompt
  sign define O text=O texthl=HHPrompt
  sign define P text=P texthl=HHPrompt
  sign define Q text=Q texthl=HHPrompt
  sign define R text=R texthl=HHPrompt
  sign define S text=S texthl=HHPrompt
  sign define T text=T texthl=HHPrompt
  sign define U text=U texthl=HHPrompt
  sign define V text=V texthl=HHPrompt
  sign define W text=W texthl=HHPrompt
  sign define Y text=Y texthl=HHPrompt
  sign define Z text=Z texthl=HHPrompt
  "This will gIve an Error but still work
  silent! sign define blank text=  texthl=HHPrompt
  setlocal statusline=%#HHBorder#-\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ %<
  "nnoremap <buffer> s <C-W>j
  
  nnoremap <buffer> i :call g:S_ShowPrompt()<CR>i
  nnoremap <buffer> I :call g:S_ShowPrompt()<CR>I
  nnoremap <buffer> a :call g:S_ShowPrompt()<CR>a
  nnoremap <buffer> A :call g:S_ShowPrompt()<CR>A
  "make these use the dumb things
  nnoremap <buffer> p :call g:S_ShowPrompt()<CR>:exec 'normal!"'.v:register.'p'<CR>
  nnoremap <buffer> P :call g:S_ShowPrompt()<CR>:exec 'normal!"'.v:register.'p'<CR>
  call matchadd('HHBorder', '^¦')
  augroup HackHack
    autocmd! CursorHold 
    autocmd! CursorHoldI 
    autocmd! VimResized 
    autocmd! InsertEnter 
    autocmd! CursorMoved 
    autocmd! CursorMovedI 
  augroup END
  augroup HackHack
    "autocmd  VimResized <buffer> exec "normal!\<C-W>100+"
    autocmd  CursorHold <buffer> call g:S_UpdateTerminal(0, 0)
    autocmd  CursorHoldI <buffer> call g:S_UpdateTerminal(1, 0)
  augroup END
  if bufexists(g:S_windowName)
    let counter = 0
    while bufexists(g:S_windowName.counter)
      let counter += 1
    endwhile
    let g:S_windowName=g:S_windowName.counter
  endif
  exec "sign place 1 line=1 name=blank buffer=".bufnr(expand("%"))
  exec "belowright 1 split ".g:S_windowName
  setlocal winfixheight
  setlocal noswapfile
  setlocal bufhidden=hide
  setlocal buftype=nofile
  "exec "normal! i>  "
  "nnoremap <buffer> s <C-W>k
  inoremap <silent> <buffer> <CR> <C-O>:call g:S_CarriageReturn(1)<CR>
  nnoremap <silent> <buffer> <CR> :call g:S_CarriageReturn(0)<CR>
  augroup HackHack
    autocmd CursorHoldI  <buffer> call g:S_UpdateTerminal(1, 1)
    autocmd CursorHold   <buffer> call g:S_UpdateTerminal(0, 1)
    "autocmd VimResized   <buffer> exec "normal!\<C-W>100-"
    "autocmd InsertEnter  <buffer> call g:S_FixPrompt(1)
    "autocmd CursorMovedI <buffer> call g:S_FixPrompt(1)
    "autocmd CursorMoved  <buffer> call g:S_FixPrompt(0)
    autocmd CursorHold   *        call g:S_ClearUnfocusedEntries()
    autocmd CursorHoldI   *        call g:S_ClearUnfocusedEntries()
    "autocmd InsertEnter  *        call g:S_ClearUnfocusedEntries()
  augroup END
  inoremap <silent> <buffer> <UP> <C-O>:call g:S_HistoryUp()<CR>
  inoremap <silent> <buffer> <DOWN> <C-O>:call g:S_HistoryDown()<CR>
  nnoremap <silent> <buffer> <UP>  @=":call g:S_HistoryUp()<C-V><CR>"<CR>:echo ""<CR>
  nnoremap <silent> <buffer> <DOWN>  @=":call g:S_HistoryDown()<C-V><CR>"<CR>:echo ""<CR>
  nnoremap <silent> <buffer> k  @=":call g:S_HistoryUp()<C-V><CR>"<CR>:echo ""<CR>
  nnoremap <silent> <buffer> j  @=":call g:S_HistoryDown()<C-V><CR>"<CR>:echo ""<CR>
  inoremap <silent> <buffer> <TAB> <ESC>:call g:S_TabPress()<CR>A
  nnoremap <silent> <buffer> / :call g:S_Search('/')<CR>A
  nnoremap <silent> <buffer> ? :call g:S_Search('?')<CR>A
  nnoremap <silent> <buffer> n @=":call g:S_NextSearch(1)<C-V><CR>"<CR>:echo ""<CR>
  nnoremap <silent> <buffer> N @=":call g:S_NextSearch(-1)<C-V><CR>"<CR>:echo ""<CR>
  nnoremap <silent> <buffer> <C-C> :call g:S_SendLine("\x03")<CR>
  inoremap <silent> <buffer> <C-C> <C-O>:call g:S_SendLine("\x03")<CR>
  nnoremap <silent> <buffer> <C-D> :call g:S_SendLine("\x04")<CR>
  inoremap <silent> <buffer> <C-D> <C-O>:call g:S_SendLine("\x04")<CR>
  nnoremap <silent> <buffer> gg :call g:S_GotoHistoryBeginning()<CR>
  nnoremap <silent> <buffer> G :call g:S_GotoHistoryEnd()<CR>
  nnoremap <silent> <buffer> '. :call g:S_GotoTempBuffer()<CR>
  nnoremap <silent> <buffer> ' :call g:S_GotoMark()<CR>
  nnoremap <silent> <buffer> m :call g:S_Mark()<CR>
  nnoremap <silent> <buffer> mm :call g:S_Mark()<CR>
  nnoremap g? ?
  nnoremap g/ /
  nnoremap gn n
  nnoremap gN N


  "stop updates from breaking window switcheg:S_"
  call g:S_DummyMap('<C-W><ESC>')
  call g:S_MapNumbers()
  call g:S_MapRegisters()

  wincmd k
  "syntax match garbage /_237.*_237/ conceal
  call g:S_ExtendLines()
  call g:S_ReadAndUpdatePromptChar(200)
  "normal!0i>
  wincmd j
  normal!dd
endfunction
"eventully i should name my terminals and input windows
"and loop through each input window updating it's terminal
"

let g:S_TypingSearch=0
let g:S_AllowPromptFixing=1
let g:S_NormalPromptChar='>'
let g:S_PromptChar=g:S_NormalPromptChar
let g:S_TempBuffer=""
let g:S_TempBufferIndex=-1
let g:S_BufferMarker="."
let g:S_windowName=""
let g:S_mode="normal"

function! g:S_ClearUnfocusedEntries()
  if buflisted(g:S_windowName) && expand('%')!=g:S_windowName
    if g:ReadlineMode == 1
      let g:ReadlineMode = 2
      wincmd j
      call g:S_HidePrompt()
      wincmd k
    endif
  endif
endfunction

function! g:S_GotoTempBuffer()
  if g:S_TempBufferIndex>=0
    "call g:S_StoreTempBuffer()
    call g:S_RemoveArrow()
    let g:S_HistoryIndex=g:S_TempBufferIndex
    call g:S_GrabFromHistory()
    call g:S_AddArrow()
  endif
endfunction

function! g:S_GotoHistoryBeginning()
  if g:S_TypingSearch
    return
  endif
  call g:S_StoreTempBuffer()
  call g:S_RemoveArrow()
  let g:S_HistoryIndex=len(g:S_History)
  call g:S_GrabFromHistory()
  call g:S_AddArrow()
endfunction

function! g:S_GotoHistoryEnd()
  if g:S_TypingSearch
    return
  endif
  call g:S_StoreTempBuffer()
  call g:S_RemoveArrow()
  let g:S_HistoryIndex=0
  call g:S_GrabFromHistory()
  call g:S_AddArrow()
endfunction

"function! g:S_FixPrompt(insertMode)
  "if !g:S_AllowPromptFixing
    "return
  "endif
  "while getpos('.')[1]>1
    "normal!gg"_ddG
  "endwhile
  "if getpos('.')[2]==1
    "let tempReg=getreg('"', 1)
    "let regType=getregtype('"')
    "normal!yl
    "let capturedKey=@"
    "call setreg('"',tempReg,regType)
    "if capturedKey!=g:S_PromptChar
      "exec "normal!i".g:S_PromptChar
    "endif
    "normal!l
  "endif
  "if getpos('.')[2]<=2
    "let tempReg=getreg('"', 1)
    "let regType=getregtype('"')
    "normal!yl
    "let capturedKey=@"
    "call setreg('"',tempReg,regType)
    "if capturedKey!=" "
      "exec "normal!0a "
    "endif
    "normal!l
  "endif
  ""extra steps need to be taken for a blank line in insert mode
  "if getpos('.')[2]<=2 && a:insertMode
    "startinsert!
  "endif
"endfunction

let g:S_SearchTerm=""
let g:S_MatchCount=0

function! g:S_NextSearch(direction)
  if g:S_TypingSearch
    return
  endif
  if g:S_SearchMode=='?'
    let direction=-a:direction
  else
    let direction=a:direction
  endif
  let g:S_MatchCount=g:S_MatchCount+direction
  let g:searchLocation=match(g:S_History,g:S_SearchTerm,0, g:S_MatchCount)
  if g:searchLocation>=0 && g:S_MatchCount>0
    call g:S_StoreTempBuffer()
    call g:S_RemoveArrow()
    let g:S_HistoryIndex=len(g:S_History)-g:searchLocation
    call g:S_GrabFromHistory()
    call g:S_AddArrow()
  else
    let g:S_MatchCount=g:S_MatchCount-direction
  endif
endfunction

function! g:S_Search(mode)
  let g:S_AllowPromptFixing=0
  let g:S_SearchMode=a:mode 
  let g:S_TypingSearch=1
  call g:S_StoreTempBuffer()
  exec "normal!\"_dd"
  let g:S_PromptChar=a:mode
  call g:S_ChangePrompt(g:S_PromptChar)
  let g:S_AllowPromptFixing=1
endfunction

function! g:S_GrabCommandLine()
  let tempReg=getreg('"', 1)
  let regType=getregtype('"')
  let @"="\n"
  normal!dd
  let ret=@"
  call setreg('"',tempReg,regType)
  return ret
endfunction

function! g:S_DoSearch()
  let g:S_PromptChar=g:S_NormalPromptChar
  "match ignores smartcase, so if smartcase is set and there are NO upper case
  "in search, we'll perform a case insenesitve search ourselves
  let reverseHistoryIndex=len(g:S_History)-g:S_HistoryIndex
  let caseMagic=0
  let g:S_SearchTerm=split(g:S_GrabCommandLine().'\n ','\n')[0]
  let g:S_MatchCount=0
  let searchLocation=-2
  while searchLocation<reverseHistoryIndex && searchLocation!=-1
    let g:S_MatchCount=g:S_MatchCount+1
    let searchLocation=match(g:S_History,g:S_SearchTerm,0, g:S_MatchCount)
  endwhile
  if g:S_SearchMode=="/" && searchLocation==reverseHistoryIndex
    let g:S_MatchCount=g:S_MatchCount+1
    let searchLocation=match(g:S_History,g:S_SearchTerm,0, g:S_MatchCount)
  elseif g:S_SearchMode=="?"
    let g:S_MatchCount=g:S_MatchCount-1
    let searchLocation=match(g:S_History,g:S_SearchTerm,0, g:S_MatchCount)
  endif

  let g:S_TypingSearch=0
  if searchLocation>=0
    call g:S_RemoveArrow()
    let g:S_HistoryIndex=len(g:S_History)-searchLocation
    call g:S_GrabFromHistory()
    call g:S_AddArrow()
  endif
endfunction

let g:lastPathString=""
function! g:S_ReadAndUpdatePromptChar(howLong)
    let startingInReadline=g:ReadlineMode
    "if g:lastPathString!="" 
      "exec "normal!".g:lastPathLine."gg0i_237".g:lastPathString."_237"
    "endif
    
    if g:ReadlineMode==1
      call g:S_UnDashify()
    else
      echo ""
    endif
    let readInput=conque_term#get_instance().read(a:howLong)
    if g:ReadlineMode==1
      call g:S_Dashify()
    else
      call g:S_ExtendLines()
    endif
    "if g:lastPathString!="" 
      "exec "normal!".g:lastPathLine."gg0d".(len(g:lastPathString)+8)."l"
    "endif
    "silent! exec "normal!gg/^_237\<CR>"
    "while getpos('.')[1]>1
      "let g:lastPathLine=getpos('.')[1]
      "exec "normal!d4ld/_237\<CR>"
      "normal!"_d4l
      "wincmd j
      "exec "lcd ".@"
      "let g:lastPathString=@"
      ""make sure to save register!!!
      "wincmd k
      "silent! exec "normal!gg/^_237\<CR>"
    "endwhile
    "normal!G
    let possiblePromptIndex=len(readInput)-1
    let findSavePoint=split(readInput,'[?1049h')
    if len(readInput)>0
      let g:SaveInput=readInput
    endif
    if len(findSavePoint)>1
      let g:ReadlineMode=0
    endif
    "let findSavePoint=split(readInput." ",'1049l')
    "if len(findSavePoint)>1
      "let g:ReadlineMode=1
    "endif
    if len(findSavePoint)>0 && len(split(findSavePoint[-1],'[?1049l'))>1
      let g:ReadlineMode=1
    endif
    if g:ReadlineMode==1
      while readInput[possiblePromptIndex]==" " && possiblePromptIndex>1
        let possiblePromptIndex=possiblePromptIndex-1
      endwhile

      if readInput[possiblePromptIndex]!=" " && readInput[possiblePromptIndex]!=""
        let oldPromptChar=g:S_PromptChar
        let g:S_NormalPromptChar=readInput[possiblePromptIndex]
        if g:S_NormalPromptChar==" " || g:S_NormalPromptChar=="\n"
          let g:S_NormalPromptChar="."
        endif
        if !g:S_TypingSearch
          let g:S_PromptChar=g:S_NormalPromptChar
        endif
        if g:S_PromptChar!=oldPromptChar
          "don't switch buffers, do it from this buffer
          wincmd j
          "let pos = getpos('.')
          "exec "normal!0r".g:S_PromptChar
          "call setpos('.',pos)
          call g:S_ChangePrompt(g:S_PromptChar)
          wincmd k
        endif
      endif
    endif
    if g:ReadlineMode==0 && startingInReadline==1
      wincmd j
      call g:S_HidePrompt()
      wincmd k
    elseif g:ReadlineMode==1 && startingInReadline==0
      call g:S_ShowPrompt()
      return 1
    endif
    return 0
endfunction

function! g:S_HidePrompt()
    normal!ZZ
    call g:S_UnDashify()
    exec "sign unplace * buffer=".bufnr(expand("%"))
    if g:ReadlineMode==0
      exec "setlocal statusline=".g:S_windowName."\\ (Direct\\ Input)"
      call g:S_MapDirectInputKeys()
    endif
    if g:ReadlineMode==2
      exec "setlocal statusline=".g:S_windowName."\\ (Browse\\ Mode)"
    endif
    stopinsert
endfunction

function! g:S_ShowPrompt()
  call g:S_UnmapDirectInputKeys()
  "RESTORE OLD BUFFER
  let g:ReadlineMode=1
  setlocal statusline=%#HHBorder#-\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ -\ %<
  exec "belowright 1 split ".g:S_windowName
  setlocal winfixheight
  call g:S_AddArrow()
endfunction

function! g:S_UpdateTerminal(insert_mode, hackPrompt)
    let hackPrompt=a:hackPrompt
    let insert_mode=a:insert_mode
    if g:ReadlineMode==2
      return
    endif
    if hackPrompt
      wincmd k
    endif
    "normal!G0"_x
    if g:S_ReadAndUpdatePromptChar(0)
      let hackPrompt=1
      wincmd k
      startinsert
    endif
    if g:S_HistoryIndex==0 && g:ReadlineMode==1
      call g:S_JumpToLastLine()
      call g:S_RemoveArrowNoJump()
      let g:S_ZeroArrowPoint=getpos('.')[1]
      call g:S_AddArrowNoJump()
    "elseif g:ReadlineMode==0
      "call g:S_JumpToLastLine()
    endif
    "if g:S_HistoryIndex==0 
      "normal!0i>
    "elseif g:S_TempBufferIndex==0
      "exec "normal!I".g:S_BufferMarker
    "else
      "exec "normal!I "
    "endif
    if g:ReadlineMode==1
      call g:S_GotoArrowLine()
    endif
    if hackPrompt
      wincmd j
    endif
    call g:S_RestartUpdateCounter(insert_mode)
endfunction!

function! g:S_TabPress()
    let g:S_AllowPromptFixing=0
    let tempReg=getreg('"', 1)
    let regType=getregtype('"')
    normal! 0d$
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
    exec "normal!\"_ddi".tabcompletevar
    let g:S_AllowPromptFixing=1
endfunction

function! g:S_RestartUpdateCounter(insert_mode)
    if a:insert_mode
        call feedkeys("\<C-o>f\e", "n")
    else
        call feedkeys("f\e", "n")
    endif
endfunction

let g:S_History = []
let g:S_HistoryIndex=0
let g:S_HistoryLine=[]
let g:S_ZeroArrowPoint=0

let g:S_SearchMode=' '


function! g:S_SendLine(line)
  let g:lineSent=a:line
  silent wincmd k
  call g:S_JumpToLastLine()
  let g:S_History=g:S_History+[a:line[0:-2]]
  let g:S_ZeroArrowPoint=getpos('.')[1]
  let g:S_HistoryLine=g:S_HistoryLine+[g:S_ZeroArrowPoint]
  let g:S_HistoryIndex=0
  call conque_term#get_instance().write(a:line)
  "normal!0"_x
  call g:S_RemoveArrowNoJump()
  call g:S_ReadAndUpdatePromptChar(80)
  "call g:S_ExtendLines()
  "exec "normal!".g:S_ZeroArrowPoint."ggI "
  call g:S_JumpToLastLine()
  let g:S_ZeroArrowPoint=getpos('.')[1]
  if g:ReadlineMode==1
    call g:S_AddArrowNoJump()
  endif
  "exec "normal!G0i>\<ESC>$"
  silent wincmd j
endfunction

let g:S_fullBuffer=""
let g:ReadlineMode=1

"breaks register
function! g:S_CarriageReturn(insertMode)
  "prevent carriage return spam
  while getchar(1)==13 "carriage return
    call getchar(0)
  endwhile
  if g:S_TypingSearch!=0
    call g:S_DoSearch()
    call feedkeys("\<ESC>",'n')
    let g:S_PromptChar=g:S_NormalPromptChar
    call g:S_ChangePrompt(g:S_PromptChar)
    return
  endif
  "silent wincmd k
  "let tempReg=getreg('"', 1)
  "let regType=getregtype('"')
  "silent normal!ggyG
  "let g:S_fullBuffer=@"
  "call setreg('"',tempReg,regType)
  "silent wincmd j
  call g:S_EraseOldBufferMarker()
  let g:S_TempBuffer=""
  let g:S_TempBufferIndex=-1
  let capturedKeys=g:S_GrabCommandLine()
  call g:S_SendLine(capturedKeys)
  call g:S_RestartUpdateCounter(a:insertMode)
endfunction

function! g:S_TestTop()
  call conque_term#get_instance().write("top\n")
  let g:result=conque_term#get_instance().read(1000)
endfunction

function! g:S_EraseOldBufferMarker()
  "if g:S_TempBufferIndex>=0
    "wincmd k
    "if g:S_TempBufferIndex==0
      "exec "normal!".g:S_ZeroArrowPoint."gg"
    "else
      "exec "normal!".g:S_HistoryLine[-g:S_TempBufferIndex]."gg"
    "endif
    "exec "normal!0r "
    "wincmd j
  "endif
  sign unplace 4
endfunction


function! g:S_StoreTempBuffer()
  if g:S_HistoryIndex!=0
    let historyLine=g:S_History[-g:S_HistoryIndex]
  else
    let historyLine=split(g:S_TempBuffer."\n ","\n")[0]
  endif
  let commandLine=g:S_GrabCommandLine()
  if historyLine."\n"!=commandLine && historyLine." \n"!=commandLine
    call g:S_EraseOldBufferMarker()
    let g:S_TempBuffer=commandLine
    if commandLine!="\n" && commandLine!=" \n"
      let g:S_TempBufferIndex=g:S_HistoryIndex
    else
      let g:S_TempBufferIndex=-1
    endif
  endif
endfunction

function! g:S_HistoryUp()
  if g:S_HistoryIndex<len(g:S_History)
    if g:S_TypingSearch
      return
    endif
    call g:S_StoreTempBuffer()
    call g:S_RemoveArrow()
    let g:S_HistoryIndex=g:S_HistoryIndex+1
    call g:S_GrabFromHistory()
    call g:S_AddArrow()
  endif
endfunction

function! g:S_HistoryDown()
  if g:S_TypingSearch
    return
  endif 
  call g:S_StoreTempBuffer()
  call g:S_RemoveArrow()
  let g:S_HistoryIndex=g:S_HistoryIndex-1
  if g:S_HistoryIndex<0
    let g:S_HistoryIndex=0
  endif
  call g:S_GrabFromHistory()
  call g:S_AddArrow()
endfunction

function! g:S_GotoArrowLine()
  if g:S_HistoryIndex==0
    exec "normal!".g:S_ZeroArrowPoint."gg"
  else
    exec "normal!".g:S_HistoryLine[-g:S_HistoryIndex]."gg"
  endif
endfunction

function! g:S_GetArrowLine()
  if g:S_HistoryIndex==0
    return g:S_ZeroArrowPoint
  else
    return g:S_HistoryLine[-g:S_HistoryIndex]
  endif
endfunction

function! g:S_RemoveArrowNoJump()
  let lineNum=g:S_GetArrowLine()
  if g:S_HistoryIndex==g:S_TempBufferIndex
    exec "sign place 4 line=".lineNum." name=dot buffer=".bufnr(expand("%"))
  else
    exec "sign place 1 line=".lineNum." name=blank buffer=".bufnr(expand("%"))
  endif
  exec "sign unplace ".2
endfunction

"I shouldn't need to jump, since i can set on ann buffer
function! g:S_RemoveArrow()
  wincmd k
  "call g:S_GotoArrowLine()
  "if g:S_HistoryIndex==g:S_TempBufferIndex
    "exec "normal!0r".g:S_BufferMarker."$"
  "else
    "normal!0r $
  "endif
  call g:S_RemoveArrowNoJump()
  wincmd j
endfunction

function! g:S_AddArrowNoJump()
  let lineNum=g:S_GetArrowLine()
  exec "normal!".lineNum."gg"
  exec "sign place 2 line=".lineNum." name=doublearrow buffer=".bufnr(expand("%"))
  sign unplace 1
endfunction

function! g:S_AddArrow()
  wincmd k
  "call g:S_GotoArrowLine()
  "normal!0r>
  call g:S_AddArrowNoJump()
  wincmd j
endfunction

function! g:S_GrabFromHistory()
  let g:S_AllowPromptFixing=0
  "The bottom line always retrieves the temp buffer
  if g:S_HistoryIndex==g:S_TempBufferIndex || g:S_HistoryIndex==0
    normal! gg"_dG
    exec "normal!A".g:S_TempBuffer
    normal! gg
  else
    let historyLine=g:S_History[-g:S_HistoryIndex]
    normal! gg"_dG
    exec "normal!A".historyLine
    normal! gg
  endif
  let g:S_AllowPromptFixing=1
endfunction

function! g:S_MapNumbers()
  "This stops all numbers under 10million, including those with zeros, but not 0 itself from
  "breaking when we check term.
  "will have problems though.
  call g:S_DummyMap('1000000<ESC>')
  call g:S_DummyMap('2000000<ESC>')
  call g:S_DummyMap('3000000<ESC>')
  call g:S_DummyMap('4000000<ESC>')
  call g:S_DummyMap('5000000<ESC>')
  call g:S_DummyMap('6000000<ESC>')
  call g:S_DummyMap('7000000<ESC>')
  call g:S_DummyMap('8000000<ESC>')
  call g:S_DummyMap('9000000<ESC>')
endfunction

function! g:S_MapRegisters()
  call g:S_DummyMap('""<ESC>')
  call g:S_DummyMap('"0<ESC>')
  call g:S_DummyMap('"1<ESC>')
  call g:S_DummyMap('"2<ESC>')
  call g:S_DummyMap('"3<ESC>')
  call g:S_DummyMap('"4<ESC>')
  call g:S_DummyMap('"5<ESC>')
  call g:S_DummyMap('"6<ESC>')
  call g:S_DummyMap('"7<ESC>')
  call g:S_DummyMap('"8<ESC>')
  call g:S_DummyMap('"9<ESC>')
  call g:S_DummyMap('"a<ESC>')
  call g:S_DummyMap('"b<ESC>')
  call g:S_DummyMap('"c<ESC>')
  call g:S_DummyMap('"d<ESC>')
  call g:S_DummyMap('"e<ESC>')
  call g:S_DummyMap('"f<ESC>')
  call g:S_DummyMap('"g<ESC>')
  call g:S_DummyMap('"h<ESC>')
  call g:S_DummyMap('"i<ESC>')
  call g:S_DummyMap('"j<ESC>')
  call g:S_DummyMap('"k<ESC>')
  call g:S_DummyMap('"l<ESC>')
  call g:S_DummyMap('"m<ESC>')
  call g:S_DummyMap('"n<ESC>')
  call g:S_DummyMap('"o<ESC>')
  call g:S_DummyMap('"p<ESC>')
  call g:S_DummyMap('"q<ESC>')
  call g:S_DummyMap('"r<ESC>')
  call g:S_DummyMap('"s<ESC>')
  call g:S_DummyMap('"t<ESC>')
  call g:S_DummyMap('"u<ESC>')
  call g:S_DummyMap('"v<ESC>')
  call g:S_DummyMap('"w<ESC>')
  call g:S_DummyMap('"x<ESC>')
  call g:S_DummyMap('"y<ESC>')
  call g:S_DummyMap('"z<ESC>')
  call g:S_DummyMap('"A<ESC>')
  call g:S_DummyMap('"B<ESC>')
  call g:S_DummyMap('"C<ESC>')
  call g:S_DummyMap('"D<ESC>')
  call g:S_DummyMap('"E<ESC>')
  call g:S_DummyMap('"F<ESC>')
  call g:S_DummyMap('"G<ESC>')
  call g:S_DummyMap('"H<ESC>')
  call g:S_DummyMap('"I<ESC>')
  call g:S_DummyMap('"J<ESC>')
  call g:S_DummyMap('"K<ESC>')
  call g:S_DummyMap('"L<ESC>')
  call g:S_DummyMap('"M<ESC>')
  call g:S_DummyMap('"N<ESC>')
  call g:S_DummyMap('"O<ESC>')
  call g:S_DummyMap('"P<ESC>')
  call g:S_DummyMap('"Q<ESC>')
  call g:S_DummyMap('"R<ESC>')
  call g:S_DummyMap('"S<ESC>')
  call g:S_DummyMap('"T<ESC>')
  call g:S_DummyMap('"U<ESC>')
  call g:S_DummyMap('"V<ESC>')
  call g:S_DummyMap('"W<ESC>')
  call g:S_DummyMap('"X<ESC>')
  call g:S_DummyMap('"Y<ESC>')
  call g:S_DummyMap('"Z<ESC>')
  call g:S_DummyMap('":<ESC>')
  call g:S_DummyMap('".<ESC>')
  call g:S_DummyMap('"%<ESC>')
  call g:S_DummyMap('"#<ESC>')
  call g:S_DummyMap('"=<ESC>')
  call g:S_DummyMap('"*<ESC>')
  call g:S_DummyMap('"+<ESC>')
  call g:S_DummyMap('"~<ESC>')
  call g:S_DummyMap('"_<ESC>')
  call g:S_DummyMap('"-<ESC>')
  call g:S_DummyMap('"/<ESC>')
endfunction

"Dummy maps shouldn't affect anything except that they will stop cursorhold
"from triggering in the middle of their key sequence.
function! g:S_DummyMap(mapping)
  if mapcheck(a:mapping, "n") == ""
    exec "nnoremap <unique> ".a:mapping." ".a:mapping
  endif
endfunction

function! g:S_Dashify()
  call g:S_ExtendLines()
  silent exec("%s/^/¦/e")
endfunction

function! g:S_UnDashify()
  silent exec("%s/^¦//e")
endfunction

function! g:S_ExtendLines()
  "let origline=getpos('.')[1]
  normal! H
  let topLine=getpos('.')[1]
  normal! L
  let numLines=getpos('.')[1]-topLine+1
  if numLines<winheight(winnr())
    exec "normal!".(winheight(winnr())-numLines)."o\<ESC>"
  endif
  return
  "exec "normal!".origline."gg"
endfunction

function! g:S_JumpToLastLine()
  normal!G$
  while getpos('.')[2]==1
    normal!k$
  endwhile
endfunction

function! g:S_ChangePrompt(promptChar)
  sign unplace 3
  exec "sign define prompt text=".a:promptChar." texthl=HHPrompt"
  exec "sign place 3 line=1 name=prompt buffer=".bufnr(expand("%"))
endfunction

function! g:S_Mark()
  let num=getchar()
  let char=nr2char(num)
  wincmd k
    call g:S_GotoArrowLine()
    silent! exec "normal!m".char
    silent! exec "sign unplace ".num
    silent! exec "sign place ".num." line=".g:S_GetArrowLine()." name=".char." buffer=".bufnr(expand("%"))
  wincmd j
endfunction

function! g:S_GotoMark()
  let char=nr2char(getchar())
  wincmd k
    echo getpos("'a")
    silent! exec "normal!'".char
    call g:S_HistoryFromCursorPos()
  wincmd j
endfunction

function! g:S_HistoryFromCursorPos()
  let cursorline = getpos('.')[1]
  wincmd j
  call g:S_StoreTempBuffer()
  wincmd k
  call g:S_RemoveArrowNoJump()
  if cursorline==g:S_ZeroArrowPoint
    let g:S_HistoryIndex = 0
  else
    let g:S_HistoryIndex = 1
    while g:S_HistoryLine[-g:S_HistoryIndex]>cursorline && g:S_HistoryIndex<len(g:S_History)
      let g:S_HistoryIndex+=1
    endwhile
  endif
  wincmd j
  call g:S_GrabFromHistory()
  wincmd k
  call g:S_AddArrowNoJump()
endfunction

function! g:S_MapDirectInputKeys()
  let g:i=1
  while g:i<256
    if g:i==124
      silent exec "nnoremap <buffer> \\| :call conque_term#get_instance().write(nr2char(".g:i."))<CR>:call g:S_ReadAndUpdatePromptChar(0)<CR>"
    elseif g:i==9
      silent exec "nnoremap <buffer> <TAB> :call conque_term#get_instance().write(nr2char(".g:i."))<CR>:call g:S_ReadAndUpdatePromptChar(0)<CR>"
    elseif g:i==10
      silent exec "nnoremap <buffer> <C-J> :call conque_term#get_instance().write(nr2char(".g:i."))<CR>:call g:S_ReadAndUpdatePromptChar(0)<CR>"
    elseif g:i==22
      silent exec "nnoremap <buffer> <C-V> :call conque_term#get_instance().write(nr2char(".g:i."))<CR>:call g:S_ReadAndUpdatePromptChar(0)<CR>"
    elseif g:i==32
      silent exec "nnoremap <buffer> <SPACE> :call conque_term#get_instance().write(nr2char(".g:i."))<CR>:call g:S_ReadAndUpdatePromptChar(0)<CR>"
    else
      silent exec "nnoremap <buffer> ".nr2char(g:i)." :call conque_term#get_instance().write(nr2char(".g:i."))<CR>:call g:S_ReadAndUpdatePromptChar(0)<CR>"
    endif
    let g:i+=1
  endwhile
endfunction

function! g:S_UnmapDirectInputKeys()
  let i=1
  while i<256
    if i==124
      silent! exec "nunmap <buffer> \\|"
    elseif i==9
      silent! exec "nunmap <buffer> <TAB>"
    elseif i==10
      silent! exec "nunmap <buffer> <C-J>"
    elseif i==22
      silent! exec "nunmap <buffer> <C-V>"
    elseif i==32
      silent! exec "nunmap <buffer> <SPACE>"
    else
      silent! exec "nunmap <buffer> ".nr2char(i)
    endif
    let i+=1
  endwhile
endfunction


  

let &cpo = g:S_save_cpo
unlet g:S_save_cpo
