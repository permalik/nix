{ ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -al";
      gl = "pretty_git_log";
    };

    envExtra = ''
      export PATH=":$HOME/Library/pnpm:$PATH"
      export PATH=":$PATH:$HOME/.rvm/bin"
      export PATH="/usr/local/share/dotnet/x64:$PATH"
      export PATH="$PATH:$HOME/.local/bin"
      export PATH="/opt/homebrew/opt/tcl-tk/bin:$PATH"
      export LDFLAGS="-L/opt/homebrew/opt/tcl-tk/lib"
      export CPPFLAGS="-I/opt/homebrew/opt/tcl-tk/include"
      export JAVA_HOME=$(/usr/libexec/java_home -v 21)
      export PATH="$HOME/.local/bin/maven/3.9.11/bin:$JAVA_HOME/bin:$PATH"
      export PKG_CONFIG_PATH="/opt/homebrew/lib/pkgconfig:$PKG_CONFIG_PATH"
      export PATH="$HOME/go/bin:$PATH"
      export PATH="/run/current-system/sw/bin:$PATH"
      export PATH="$PATH:$HOME/aistor-binaries"
    '';

    initContent = ''
      pretty_git_log() {
          local hash relative_time author refs subject format

          hash="%C(always,yellow)%h%C(always,reset)"
          relative_time="%C(always,green)%ar%C(always,reset)"
          author="%C(always,bold blue)%an%C(always,reset)"
          refs="%C(always,red)%d%C(always,reset)"
          subject="%s"

          format="$hash $relative_time{$author{$refs $subject"

          git log --graph --pretty="tformat:$format" "$@" |
              column -t -s '{' |
              less -XRS --quit-if-one-screen
      }
    '';
  };
}
