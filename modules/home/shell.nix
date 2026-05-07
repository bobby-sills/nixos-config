{ pkgs, ... }:
{
	home.packages = [
		(pkgs.writeShellScriptBin "rebuild" ''
			set -e
			cd ~/nixos-dotfiles

			PUSH=0
			NO_COMMIT=0
			MSG="update config"

			while [[ $# -gt 0 ]]; do
				case "$1" in
					-p|--push) PUSH=1; shift ;;
					-n|--no-commit) NO_COMMIT=1; shift ;;
					*) MSG="$1"; shift ;;
				esac
			done

			if [[ $NO_COMMIT -eq 0 ]]; then
				git add -A
				git diff --cached --stat
				git commit -m "$MSG"
			fi

			sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos-btw

			if [[ $PUSH -eq 1 ]]; then
				git push
			fi
		'')
	];

programs.bash.profileExtra = ''
  if [ -z "''${WAYLAND_DISPLAY}" ] && [ "''${XDG_VTNR}" -eq 1 ]; then
    exec start-hyprland
  fi
'';

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
unimatrix = "unimatrix -c green -b -s 96 -l o";
ls = "eza --icons=always";
		};
	};

	programs.fzf = {
		enable = true;
		enableBashIntegration = true;
	};

	programs.yt-dlp = {
		enable = true;
		settings = {
			write-subs = true;
			write-auto-subs = true;
			embed-subs = true;
			sub-langs = "en.*,en";
		};
	};
}
