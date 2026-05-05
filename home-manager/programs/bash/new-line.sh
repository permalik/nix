new_line=$'\n'

if [[ $PS1 != *"$new_line"* ]]; then
    PS1="${PS1}${new_line}"
fi
