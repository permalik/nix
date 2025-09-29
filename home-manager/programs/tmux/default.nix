{
  inputs,
  lib,
  config,
  pkgs,
  nixpkgs-unstable,
  userConfig,
  ...
}: {
  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    clock24 = true;
    historyLimit = 1000000;
    plugins = [
      # yank
      pkgs.tmuxPlugins.nord
    ];

    extraConfig = ''
      set-option -g mouse on
      unbind C-b
      set -g prefix C-a
      bind C-Space send-prefix

      setw -g mode-keys vi
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R
      bind '"' split-window -c "#{pane_current_path}"
      bind '%' split-window -h -c "#{pane_current_path}"
      bind-key v split-window -v -c "#{pane_current_path}" -l '25%'
      bind-key b split-window -h -c "#{pane_current_path}" -l '30%'

      set-option -g allow-rename off
      set-option -g terminal-overrides 'xterm-256color:RGB'
      # set -g @plugin 'tmux-plugins/tpm'
      # set -g @plugin 'tmux-plugins/tmux-resurrect'
      # set -g @resurrect-strategy-nvim 'session'
      set -g status-left-length 85
      set -g status-left "[fg=colour9,bold]permalik #[fg=colour214,bold]#S"
      set -g window-status-format "#[fg=default]#I::#W"
      set -g status-current-format "[fg=default,bold bg=default]| #[fg=colour159 bg=black]#W #[fg=default,bold bg=default]"
      set -g status-style bg=default
      set status-right "#[fg=black] #[bg=colour214] %b %d %Y %l:%M %p"
      # run '~/.tmux/plugins/tpm/tpm'
    '';
  };
}
# set -g mouse on
# unbind C-b
# set -g prefix C-a
# bind C-Space send-prefix
#
# setw -g mode-keys vi
# bind-key h select-pane -L
# bind-key j select-pane -D
# bind-key k select-pane -U
# bind-key l select-pane -R
# bind '"' split-window -c "#{pane_current_path}"
# bind '%' split-window -h -c "#{pane_current_path}"
# bind-key v split-window -v -c "#{pane_current_path}" -l '25%'
# bind-key b split-window -h -c "#{pane_current_path}" -l '30%'
#
# set-option -g terminal-overrides 'xterm-256color:RGB'
# set -g @plugin 'tmux-plugins/tpm'
# set -g @plugin 'tmux-plugins/tmux-resurrect'
# set -g @resurrect-strategy-nvim 'session'
# set -g status-left-length 85
# set -g status-left "tmalik#[fg=colour135] "
# set -g window-status-current-format "#[fg=black,bold bg=default]│#[fg=white bg=cyan]#W#[fg=black,bold bg=default]│"
# set -g window-status-current-format "#[fg=black,bold bg=default]│#[fg=colour135 bg=black]#W#[fg=black,bold bg=default]│"
# set -g status-style bg=default
# set -g status-right "#[fg=black] #[bg=red] %b %d %Y %l:%M %p"
#
# run '~/.tmux/plugins/tpm/tpm'

