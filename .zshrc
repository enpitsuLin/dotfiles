# Variables environments
DOTFILE_PATH="${HOME}/.dotfiles"
ZSH_PATH="${DOTFILE_PATH}/zsh/"


# ZSH Powerlevel10k and its configure file
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load all other configuation file
for file in `ls ${ZSH_PATH}*.zsh`
do
  source $file
done

# Load my p10k configuation file
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
