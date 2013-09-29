hackhack
========

HackHack is a vim plugin for running a shell within vim that responds to vim commands. It's basically like readline's vi-mode ...crossed with ninjapirates that shoot lasers out of their eyes.

##Requirements:
- Vim 7+ with python support
- the ConqueTerm vim plugin
  - The original is at http://code.google.com/p/conque/)
  - But you should probably use my fixed version: http://github.com/ardagnir/conque-term

##Installation
Use pathogen.

    cd ~/.vim/bundle
    git clone https://github.com/ardagnir/united-front

##Use
Call the HackHack function with your chosen shell.<br/>
Example:<br/>
<code>:call HackHack("bash")</code>

The main area is a conque shell. If your cursor is in that area, it behaves like a normal conque shell.

The bottom line is the hackhack console. If your cursor is in that area:
- Pressing <b>return</b> sends a command line to the shell.
- <b>Control C</b> and <b>Control D</b> are sent directly to the shell.
- You can edit command lines to send to the shell using insert mode.
- In normal mode you can navigate through your command line using standard vim-keys or search through the history using <b>/</b>, <b>?</b>, <b>j</b> and <b>k</b>
- The line of history you are accessing in history is marked with a '>'. Up to one modified history line is stored in a temporary buffer marked with a '.'. Pressing <b>'G'</b> or scrolling down to the current line also accesses that buffer.
- Hackhack uses it's own history which is seperate from the history of your shell.

##Todo:
- Integrate the main window and bottom panel together better.
- Stop yy and dd from grabbing the prompt char.
- Fix n and N so they search from cursor position instead of last search position.
- Add support for smartcase searching.
- Better tab completion support.
- Make a way to scroll through only parts of history that match current input.
- Implement search history.
- Add support for marks.

##License:
HackHack is licensed under the AGPL v3.0.
