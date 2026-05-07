{ pkgs, inputs, ... }:
let
  slack-tui = pkgs.buildNpmPackage {
    pname = "slack-tui";
    version = "0.2.0";
    src = pkgs.fetchFromGitHub {
      owner = "hikalium";
      repo = "slack-tui";
      rev = "c6cc127f9091873e5c3a24472f86afeabda639af";
      hash = "sha256-WuDyhFfrT1fQu5Os74SIXYP8sAiZ/Vk6GpDclEg6duw=";
    };
    npmDepsHash = "sha256-xu2BHaxIV5djl4lDdvme/wDDgN+bJnJUfBQGm5OYtLY=";
  };
in
{
	nixpkgs.config.allowUnfree = true;

	users.users.bobby = {
		isNormalUser = true;
		extraGroups = [ "wheel" "video" "networkmanager" ];
		packages = with pkgs; [
			tree
		];
	};

	programs.firefox.enable = true;

	programs.obs-studio.enable = true;

	environment.systemPackages = with pkgs; [
		vim
		wget
		foot
		waybar
		kitty
		git
		eza
		hyprpaper
		claude-code
		wofi
		yazi
		gdu
		brightnessctl
		ttyper
		hyprshot
		mpv
		bluetui
		impala
		spotify-player
		ripgrep
		gh
		python3
		inputs.helium-nix.packages.x86_64-linux.default
		beeper
		pipes
		cbonsai
		unimatrix
		hyprsunset
		deno
		ffmpeg
		slack-tui
	];
}
