if status is-interactive
    # Commands to run in interactive sessions can go here
end
###greeting###
function fish_greeting
end
##########alias###########
alias install='sudo pacman -S'
alias remove='sudo pacman -R'
alias update='sudo pacman -Syu'
#alias update='~/scripts/update.sh'
alias v='vim'
alias ls='lsd'
alias v='vim'
alias i3c='vim .config/i3/config'
alias fi='vim .config/fish/config.fish'
alias ytF='cd ytDownloads && yt-dlp -F'
alias ytf='yt-dlp -f'
alias gitc='cd git && git clone'
alias rr='ranger'
alias show='devour sxiv '
alias lf='lfcd'
#alias vlc='devour vlc '
#alias mpv='devour mpv '
alias nc='ncmpcpp'
alias movie='notflix'
alias live='lazywal-cli'
#alias emacs='devour emacsclient -c -a 'emacs''
alias notify='notify-send "" "Task completed" && paplay ~/Music/systemsounds/communication-channel-519.ogg'
alias dt='dragon -t -k'
alias dt='devour dragon -t -k'
alias umobile='fusermount -u ~/Mobile/'
alias mobile='simple-mtpfs  ~/Mobbile/'
alias kr='kdeconnect-cli -n path7 --refresh'
alias kill_brightness='kill $(pgrep brightness_)'
#alias kshare-t='kdeconnect-cli --name path7 --share-text'
#alias kshare='kdeconnect-cli --name path7 --share'
#prompt#####
##name: sashimi
#function fish_prompt
#  set -l last_status $status
#  set -l cyan (set_color -o cyan)
#  set -l yellow (set_color -o yellow)
#  set -g red (set_color -o red)
#  set -g blue (set_color -o blue)
#  set -l green (set_color -o green)
#  set -g normal (set_color normal)
#
#  set -l ahead (_git_ahead)
#  set -g whitespace ' '
#
#  if test $last_status = 0
#    set initial_indicator "$green◆"
#    set status_indicator "$normal❯$cyan❯$green❯"
#  else
#    set initial_indicator "$red✖ $last_status"
#    set status_indicator "$red❯$red❯$red❯"
#  end
#  set -l cwd $cyan(basename (prompt_pwd))
#
#  if [ (_git_branch_name) ]
#
#    if test (_git_branch_name) = 'master'
#      set -l git_branch (_git_branch_name)
#      set git_info "$normal git:($red$git_branch$normal)"
#    else
#      set -l git_branch (_git_branch_name)
#      set git_info "$normal git:($blue$git_branch$normal)"
#    end
#
#    if [ (_is_git_dirty) ]
#      set -l dirty "$yellow ✗"
#      set git_info "$git_info$dirty"
#    end
#  end

#  # Notify if a command took more than 5 minutes
#  if [ "$CMD_DURATION" -gt 300000 ]
#    echo The last command took (math "$CMD_DURATION/1000") seconds.
#  end
#
#  echo -n -s $initial_indicator $whitespace $cwd $git_info $whitespace $ahead $status_indicator $whitespace
#end
#
#function _git_ahead
#  set -l commits (command git rev-list --left-right '@{upstream}...HEAD' 2>/dev/null)
#  if [ $status != 0 ]
#    return
#  end
#  set -l behind (count (for arg in $commits; echo $arg; end | grep '^<'))
#  set -l ahead  (count (for arg in $commits; echo $arg; end | grep -v '^<'))
#  switch "$ahead $behind"
#    case ''     # no upstream
#    case '0 0'  # equal to upstream
#      return
#    case '* 0'  # ahead of upstream
#      echo "$blue↑$normal_c$ahead$whitespace"
#    case '0 *'  # behind upstream
#      echo "$red↓$normal_c$behind$whitespace"
#    case '*'    # diverged from upstream
#      echo "$blue↑$normal$ahead $red↓$normal_c$behind$whitespace"
#  end
#end
#
#function _git_branch_name
#  echo (command git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
#end
#
#function _is_git_dirty
#  echo (command git status -s --ignore-submodules=dirty 2>/dev/null)
#end

#GREEN="/e[1;92m"
#CYAN="/e1;36m"
#NC='/033[0m'
#export PS1="${CYAN}[\W]${GREEN}❯❯❯${NC}"

#####path#####
export PATH="$HOME/.emacs.d/bin:$PATH"
#export BROWSER="/usr/bin/firefox"
export BROWSER="firefox"
#export RANGER_LOAD_DEFAULT_RC=FALSE (currently not working properly)
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

set -U fish_color_operator 802444
set -U fish_color_escape 802444
set -U fish_color_autosuggestion 777777
set -U fish_color_comment 555555
set -U fish_color_param default
set -U fish_color_error f53054
set -U fish_color_end 3f37b3
set -U fish_color_redirection 312684
set -U fish_color_quote 4c2ca4
set -U fish_color_command default

set -x PATH  ./.local/bin/ $PATH 
set EDITOR vim
set d7 dmenu -X 2 -Y 2 -W 1435 -fn ubuntu -bw 2 -nb '#1e1e1e' -nf '#ff0900' -sf '#00a1ff' -sb '#1e1e1e'
#if test -f /home/prabhu7k/.autojump/share/autojump/autojump.fish; . /home/prabhu7k/.autojump/share/autojump/autojump.fish; end
if test -e /usr/share/autojump/autojump.fish
    . /usr/share/autojump/autojump.fish
end

    
    bind \cH backward-kill-word
    bind \el forward-bigword

