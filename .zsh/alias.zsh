# Packages
alias vim='nvim'
alias em='emacsclient'

# Package management
alias pac='sudo pacman -S'
alias emerge='sudo emerge --ask'

# Macros
alias proc='ps -e | grep'
alias lanping='ping -c 3 webmail.iitk.ac.in'
alias wanping='ping -c 3 www.google.com'
alias wifi='sudo wifi-menu'
alias fgrep='grep -r -i'

# Commonly used dirs
alias core='cd $HOME/ixchel/core/src/main/scala/org.gmantra.ixchel/models'
alias htt='cd $HOME/ixchel/http/src/main/scala/org.gmantra.ixchel/api'

# Mistakes
alias ks='ls'
alias sl='ls'

# Git aliases
alias g='git'
alias gco='git checkout'
alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gs='git status -sb'
alias gd='git diff'
alias gpl='git pull'
alias gps='git push'
alias push='git push'
alias fet='git fetch'
alias fpush='git push -f'

# systemctl
alias sst='sudo systemctl start'
alias ssp='sudo systemctl stop'
alias ssr='sudo systemctl restart'
