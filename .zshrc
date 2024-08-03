# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
ZSH_DISABLE_COMPFIX=true
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH=$HOME/.config/yarn/global/node_modules/.bin:$PATH
export PATH=$HOME/.asdf/installs/rust/1.54.0/bin:$PATH
export PATH=$HOME/.asdf/installs/nodejs/8.4.0/.npm/bin:$PATH
export PATH=$HOME/.asdf/shims:$PATH
source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"
source "/Users/patrickhereford/.asdf/installs/rust/1.77.1/env"

# Path to your oh-my-zsh installation.
export ZSH=/Users/patrickhereford/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

export GOPATH="/Users/patrickhereford"
export JAVA_HOME="/Library/Java/Home"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias python='python3'

alias beg="bundle exec guard"
alias mtw="fswatch lib test | MIX_ENV=test mix test --listen-on-stdin --stale"

alias tmux="TERM=screen-256color-bce tmux"

# Username.
# If user is root, then pain it in red. Otherwise, just print in yellow.
spaceship_user() {
  if [[ $USER == 'root' ]]; then
    echo -n "%{$fg_bold[red]%}"
  else
    echo -n "%{$fg_bold[yellow]%}"
  fi
  echo -n "%n"
  echo -n "%{$reset_color%}"
}

## Prompt
PROMPT='%{%f%b%k%}$(build_prompt)$(drink_water) '
export PATH="/usr/local/opt/openssl/bin:$PATH"


# fzf via Homebrew
if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh
fi

# fzf + ag configuration
export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='
--color dark,hl:33,hl+:37,fg+:235,bg+:136,fg+:254
--color info:254,prompt:37,spinner:108,pointer:235,marker:235
'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

WATER_TIME=1200 # Set time interval in seconds
DRINK_WATER_CONF="${DRINK_WATER_CONF:-$HOME/.water}"

drink_water() {
  # If the file doesn't exist, create it
  if [ ! -f $DRINK_WATER_CONF ]; then
    date +%s > $DRINK_WATER_CONF
  fi

  # Tail is used to remain compatible with the pervious file format
  next_time=$(($(tail -1 $DRINK_WATER_CONF) + $WATER_TIME))

  if [ $next_time -lt $(date +%s) ]; then
    echo -n "💧 You're thirsty"
  fi
}

not_thirsty() {
  date +%s > $DRINK_WATER_CONF
  echo "Water is essential"
}

next_drink() {
  next_time=$(($(cat $DRINK_WATER_CONF) + $WATER_TIME))
  next_date=""
  # Mac's date command uses a different flag
  case "$(uname)" in
    'Darwin')
      next_date="$(date -r $next_time)"
      ;;
    *)
      next_date="$(date --date="@$next_time")"
      ;;
  esac

  echo "Next drink at $next_date"
}

export PATH="$PATH:/Users/patrickhereford/.foundry/bin"
export PATH="/usr/local/opt/openjdk/bin:$PATH"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
