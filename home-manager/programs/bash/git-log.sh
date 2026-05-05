alias gl="pretty_git_log"

pretty_git_log() {
    local hash relative_time author refs subject format

    hash="C(always,yellow)%h%C(always,reset)"
    relative_time="%C(always,green)%ar%C(always,reset)"
    author="%C(always,bold blue)%an%C(always,reset)"
    refs="%C(always,red)%d%C(always,reset)"
    subject="%s"

    format="$hash $relative_time{$author{$refs $subject"

    git log --graph --pretty="tformat:$format" "$@" |
        column -t -s '{' |
        less -XRS --quit-if-one-screen
}
