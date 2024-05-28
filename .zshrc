
#{{{ generic settings
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt hist_ignore_all_dups
setopt autocd extendedglob nomatch
unsetopt beep
# changes the title of the terminal window to current working dir
precmd () {print -Pn "\e]0;%2~\a"}
#}}}

#{{{ Prompt


git_prompt() {
    local branch="$(git symbolic-ref HEAD 2> /dev/null | cut -d'/' -f3)"
    local branch_truncated="${branch:0:30}"
    if (( ${#branch} > ${#branch_truncated} )); then
        branch="${branch_truncated}..."
    fi

    [ -n "${branch}" ] && echo " [  : ${branch} ]"
}

## prompt apes lualine
# fade chars ▓▒░
setopt PROMPT_SUBST
function zle-line-init zle-keymap-select {
    case ${KEYMAP} in
        (vicmd)         PROMPT=$'%F{0m}%K{2m} NORMAL %F{2m}%k%K{234m}%b%F{251m} %3~%k%F{234m}%f%(?..%B%F{red} %? %b%F{2m})%F{2m}$(git_prompt)%f\n  ' ;;
        (main|viins)    PROMPT=$'%F{0m}%K{75m} INSERT %F{75m}%k%K{234m}%b%F{251m} %3~%k%F{234m}%(?..%B%F{red} %? %b)%F{75m}$(git_prompt)\n%F{75m}>%f ' ;;
        (*)             PROMPT=$'%{\e[0;32m%}%~%{\e[0m%} $ ' ;;
    esac
    zle reset-prompt
}
#}}}

#{{{ exports
## comment this out if using wayland
# xmodmap -e 'keycode 108 = Super_L'

## use neovim to read man pages and edit commands
PATH="$HOME/.local/bin:$PATH"
export MANPAGER="nvim +Man!"
export EDITOR=nvim
#}}}

#{{{ compinit
autoload -U compinit
zstyle ':completion:*' menu select

# case insensitive completion. i don't understand any of it.
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zmodload zsh/complist
compinit
_comp_options+=(globdots) #include hidden files

#}}}

#{{{ keys

## about modifier keys
## i think these change on different keyboards
## but 'showkey -a' will show what's what.
## for now;
##    ctrl ^
##    alt ^[
##    ctrl alt ^[^
##    ^[[A up ^[[B down ^[[D left ^[[C right
##    ^M enter
##    ^? backspace


# vi keys stuff
zle -N zle-line-init
zle -N zle-keymap-select
bindkey -v
# bindkey -M viins 'kj' vi-cmd-mode
bindkey -v '^?' backward-delete-char

# completes the menu... reversively
bindkey '^[[Z' reverse-menu-complete

## to edit command in $EDITOR (nvim)
autoload -z edit-command-line
zle -N edit-command-line
## kj space to eedit command TODO think of something better
bindkey -M vicmd 'kj ' edit-command-line
bindkey -M viins 'kj ' edit-command-line

#}}}

#{{{ aliases

## standard shellrc stuff
alias cp="cp -i"
alias df='df -h'
alias free='free --mega'
alias np='nano -w PKGBUILD'
alias more=less
alias grep='grep --colour=always'
alias egrep='egrep --colour=always'
alias fgrep='fgrep --colour=always'
alias mkdir="mkdir -pv"
alias mv="mv -i "
alias rm="rm -i "

## various helpers
alias ffs="cat ~/.zshrc | egrep --color=never 'alias|function' | fzf" ## look up aliases. TODO can probably improve on this
alias gethwmon='for i in /sys/class/hwmon/hwmon*/temp*_input; do echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $(readlink -f $i)"; done' ## find out where the core temp is today

## repetative strain
alias srcz="source ~/.zshrc"
alias fixz="nvim ~/.zshrc"
alias nm='nemo ./ '
alias e="nvim"
alias pkc="sudo pkill -u chris"
alias mkx="chmod +x "
alias mkm="sudo chown chris:chris "

# dots back up and restore
alias htd='\cp -R -f ~/dots /mnt/pt1/nothome/linuxstuff/'
alias dth='\cp -R -f /mnt/pt1/nothome/linuxstuff/dots ~/'

# cd
alias ..="cd .."
alias ..2="cd ../../"
alias ..3="cd ../../../"
alias cdls='cd $1 && ls'
alias mkcd='mkcd_alias() { mkdir -p "$1" && cd "$1"; }; mkcd_alias'
#
## cd with rofi
function cdd() {
        newdir=$(find /home/chris /mnt/pt1/ /mnt/pt2/ -type d | grep -v -E "cache|GIMP|cargo|/Code|inkscape|RSS Guard|chris2|chrisway" | rofi -filter "$1" -i -dmenu)
        if ! [[ $newdir == "" ]]; then
            cd $newdir
        fi
}

# listing and finding
alias ls='ls --group-directories-first --color=always'
alias lsl='ls -lh'
alias lsla='ls -lha'
alias lslta='ls -ltha'
alias lsf="find ./ | sort"
alias lscp="find ./ -type f | sort | wl-copy"
function fd() {
    find ./ -iname "*$1*" | sort
}

#}}}

## plugins
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# autoload -Uz compinit
# fpath+=~/.zfunc
