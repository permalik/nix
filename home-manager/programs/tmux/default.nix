{
	inputs,
	lib,
	config,
	pkgs,
	nixpkgs-unstable,
	userConfig,
	...
}:
{
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
			set-option -g prefix C-a
			bind C-Space send-prefix

			bind-key h select-pane -L
			bind-key j select-pane -D
			bind-key k select-pane -U
			bind-key l select-pane -R
			bind '"' split-window -c "#{pane_current_path}"
			bind '%' split-window -h -c "#{pane_current_path}"
			bind-key v split-window -v -c "#{pane_current_path}" -l '25%'
			bind-key b split-window -h -c "#{pane_current_path}" -l '30%'
		'';
	};
}
