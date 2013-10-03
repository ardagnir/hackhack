hackhack
========

HackHack is a vim plugin for running a shell within vim that responds to vim commands. It's basically like readline's vi-mode ...crossed with ninjapirates that shoot lasers out of their eyes.

##Requirements:
- Vim 7+ with python support
- the ConqueTerm vim plugin
  - The original is at http://code.google.com/p/conque/
  - But you should probably use my fixed version: http://github.com/ardagnir/conque-term

##Installation
Use pathogen.

    cd ~/.vim/bundle
    git clone https://github.com/ardagnir/hackhack

##Use
Call the HackHack function with your chosen shell.<br/>
Example:<br/>
<code>:call HackHack("bash")</code>

The hackhack console behaves very similarly to bash's vi-mode (except that it has full vim features).

If you run a curses-style application, it will temporarily go into "Direct Input Mode" where hackhack just sends your commands directly to the terminal.

If you move to the main terminal window, hackhack will enter "Browse Mode". You can use this to search through text output and yank from it. Hitting a,i, or p will jump you back into normal mode.

##Todo/Bugs:
Hackhack is still rough around the edges, but I'm keeping track of progress in the issue tracker:

https://github.com/ardagnir/hackhack/issues?state=open

##License:
HackHack is licensed under the AGPL v3.0.
