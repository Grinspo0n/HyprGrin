###########
### ZSH ###
###########


#############
### STYLE ###
#############

NEWLINE=$'\n'
PROMPT="%F{228}%~%f${NEWLINE}>"

##################
### LOAD ZPLUG ###
##################

if [ -e ~/.zplug/init.zsh ]; then
  source ~/.zplug/init.zsh
fi

###############
### PLUGINS ###
###############

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "popstas/zsh-command-time"

# Install plugins
if ! zplug check; then
  zplug install
fi

# Load plugins
zplug load

#######################
### BUN COMPLETIONS ###
#######################

[ -s "/home/alex/.bun/_bun" ] && source "/home/alex/.bun/_bun"

###############
### BUN ENV ###
###############

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

#############################
### ENVIRONMENT VARIABLES ###
#############################

export XDG_CURRENT_DESKTOP=KDE
export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK_THEME="Breeze-Dark"


####################
### BY GRINSPOON ###
####################
