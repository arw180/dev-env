Development Environment
===========================

Tools (applications):
* tmux
* vim
* zsh

Plugins, add-ons, etc:
* solarized color scheme: http://ethanschoonover.com/solarized (vim, iterm2, putty)
* vim plugins:
* zsh plugins:
* Moom (os x tiling manager)
* https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard (maybe)
* MacVim (os x)

Evnironments:
OSX (iTerm2, macvim)
Linux
Windows (only support for solorized colorscheme in putty)

## tmux
(tmux doesn't seem to be available via yum and must be built manually)

Building tmux from release tarball:

NOTE: tmux depends on libevent 2.x, which can be built via:

./configure --prefix=/usr --disable-static
make
sudo make install

Then, to build tmux:

./configure && make
sudo make install

https://danielmiessler.com/study/tmux/

had to add DISABLE_AUTO_TITLE=true to .zshrc to prevent tmux windows from being constantly renamed

## iterm2
* `Command-?`: locate current cursor position
* other features: instant replay, regex search, click to open urls, and jump to mark features
* loading solarized colors into iterm2: https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized

## key-bindings
* map caps lock to control: http://www.emacswiki.org/emacs/MovingTheCtrlKey
* bring iTerm2 forward to the front-most window (in Preferences-Keys, set as Option-t)
* uncheck the iTerm2 bell sound in Profiles->Terminals->notifications


# TODO:
create script to update all repos and generate a single tarball for the whole
dev env
document how to set this up on Linux distro and test w/ vagrant (ideally centos
and ubuntu)
document how to set up on os x (and test)

create cheat sheet for vim (and plugins), tmux, zsh (scrolling),
iTerm2 (maybe)


# Cheat Sheet
## tmux
Save tmux sessions: `<prefix> + ctrl-s` (tmux resurrect)
Restore tmux sessions: `<prefix> + ctrl-r` (tmux resurrect)
New named tmux session: `tmux new -s <mysession>`
Attach to existing sessions: `tmux a`
Detach from session: `<prefix> + d`
List tmux sessions: `tmux ls`
Kill session: `tmux kill-session -t <mysession>`

Inside of tmux, hit `<prefix>` and then:

`:source-file ~/.tmux.conf`: reload tmux config

`[`: enter scrolling mode. Use standard vim keys to scroll around. Use
`q` to quit scroll mode

Sessions:
* `s`: list sessions
* `$`: name the current session

Windows (tabs):
* `c`: create window
* `w`: list windows
* `n`: next window
* `p`: previous window
* `<#>`: go to window number
* `,`: name window
* `&`: kill window

Panes (splits):
* `%`: vertical split
* `"`: horizontal split
* `o`: switch active pane
* `q`: show pane numbers (type number to go to that pane)
* `x`: kill pane
* `{`: move current pain left
* `}`: move current pain right

Synchronize panes (send same command to each pane in window):
* `:setw synchronize-panes` (will toggle on/off)

Resize panes:
* `:resize-pane -U 10`: resize current pane up by 10 cells
* `:resize-pane -D 10`: resize current pane down by 10 cells
* `:resize-pane -L 10`: resize current pane left by 10 cells
* `:resize-pane -R 10`: resize current pane right by 10 cells

Copy mode:
* `[`: enter copy mode
* (no prefix) `<enter>`: copy selected text and exit copy mode
* (no prefix) `<space>`: start selection
* `]`: paste selected text


## vim
Comment/uncomment blocks:
Use block mode: `ctrl-v`. highlight via normal nav. `shift-i + <char>`, `esc`
Line comment (or multiple line comments in visual mode): `<leader>c<space>`
toggles comment

Git:
* `:Git <cmd>` (from vim-fugitive plugin) then any git command (including aliases)
* `:Gblame:`: Git blame interactive vertical split

Spelling:
* `setlocal spell` (enable spell check)
* `[s`: next misspelled word
* `]s`: previous misspelled word
* `z=`: see spelling suggestions

### vim-fugitive
* `:Gblame` to see git blame info
* `:help fugitive`
* `:Gstatus` to bring up output of `git status`
* `:Ggrep` to search the working tree using `git grep`
* `:Glog` loads all previous revisions of the file into the quickfix listso you
    can iterate over them and watch the file evolve
* `:Git` to run any arbitrary command `:Git!` to open the output of a command
    in a temp file

## zsh

## iterm2

:
