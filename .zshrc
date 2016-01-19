source ~/.myscripts/zsh/zsh_sources
PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/opt/bin/:${ROOTPATH}:$PATH"

# Load zsh-autosuggestions.
#source ~/.zsh/zsh-autosuggestions/autosuggestions.zsh

# Enable autosuggestions automatically.
#zle-line-init() {
    #zle autosuggest-start
#}
#zle -N zle-line-init
#AUTOSUGGESTION_ACCEPT_RIGHT_ARROW=1

# http://stackoverflow.com/a/844299
#expand-or-complete-with-dots() {
  #echo -n "\e[31m...\e[0m"
  #zle expand-or-complete
  #zle redisplay
#}
#zle -N expand-or-complete-with-dots
#bindkey "^I" expand-or-complete-with-dots


EDITOR=vim

source /home/saksham/.zsh_cookies
