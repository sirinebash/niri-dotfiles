# ~/.config/zsh/prompt.zsh

# Prevent Python virtualenv from polluting the prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

FUNCNEST=100

eval "$(starship init zsh)"


# --- Blank line between commands (starship's add_newline is off) ---
# Skipped above the first prompt of a shell and right after `clear`.
typeset -gi _prompt_newline_skip=1
_prompt_newline() {
  (( _prompt_newline_skip )) && _prompt_newline_skip=0 || print
}
_prompt_newline_preexec() {
  # $3 is the command with aliases expanded, so the `c` alias counts too
  local -a words=(${(z)3})
  [[ $words[1] == clear ]] && _prompt_newline_skip=1
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _prompt_newline          # after starship's precmd
add-zsh-hook preexec _prompt_newline_preexec
