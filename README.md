hackhack
========

HackHack is a vim plugin for running a shell within vim that responds to vim commands. It's basically like readline's vi-mode ...crossed with ninjapirates that shoot lasers out of their eyes.
<br/><br/>
<H5>Requirements:</H5>
Vim 7+ with python support<br/>
the ConqueTerm vim plugin (http://code.google.com/p/conque/)<br/>
<br/>
<H5>Installation:</H5>
Copy hackhack.vim to your plugin directory<br/>
<br/>
<H5>Use:</H5>
Call the HackHack function with your chosen shell.<br/>
Example:<br/>
<code>:call HackHack("bash")</code>
<br/><br/>
The main area is a conque shell. If your cursor is in that area, it behaves like a normal conque shell.<br/>
<br>
The bottom line is the hackhack console. If your cursor is in that area:<br/>
Pressing <b>return</b> sends a command line to the shell.<br/>
<b>Control C</b> and <b>Control D</b> are sent directly to the shell.<br/>
You can edit command lines to send to the shell using insert mode.<br/>
In normal mode you can navigate through your command line using standard vim-keys or search through the history using <b>/</b>, <b>?</b>, <b>j</b> and <b>k</b><br/>
The line of history you are accessing in history is marked with a '>'. Up to one modified history line is stored in a temporary buffer marked with a '.'. Pressing <b>'G'</b> or scrolling down to the current line also accesses that buffer.<br/>
Hackhack uses it's own history which is seperate from the history of your shell.<br/>
<br/><br/>
<H5>Todo:</H5>
<ul>
<li>Integrate the main window and bottom panel together better.</li>
<li>Stop yy and dd from grabbing the prompt char.</li>
<li>Fix n and N so they search from cursor position instead of last search position.</li>
<li>Add support for smartcase searching.</li>
<li>Better tab completion support.</li>
<li>Make a way to scroll through only parts of history that match current input.</li>
<li>Implement search history.</li>
<li>Add support for marks.</li>
</ul>
<br/>
<H5>License:</H5>
HackHack is licensed under the AGPL v3.0.
