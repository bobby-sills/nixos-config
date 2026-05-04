{ pkgs, ... }:
{
	home.packages = [
		(pkgs.writeShellScriptBin "rebuild" ''
			set -e
			cd ~/nixos-dotfiles
			git add -A
			git diff --cached --stat
			git commit -m "''${1:-update config}"
			sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos-btw
		'')
	];

	programs.git = {
		enable = true;
		settings.user = {
			name = "Bobby Sills";
			email = "bobbysills@bobbysills.dev";
		};
	};

	services.ssh-agent.enable = true;

	programs.bash = {
		enable = true;
		shellAliases = {
			btw = "echo i use nixos, btw";
		};
		sessionVariables = {
			SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
		};
	};
}
