export ZSH_PATH = "{$HOME}/.config/zsh/"

source "$ZSH_PATH/.zinit.zsh"

# ZSH Powerlevel10k and its configure file
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -f $ZSH_PATH/.p10k.zsh ]] || source $ZSH_PATH/.p10k.zsh

for file in ./*.zsh 
do
  source $file
done