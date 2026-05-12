{ pkgs, ... }:
{
	fonts.packages = [
		pkgs.nerd-fonts.symbols-only
		pkgs.nerd-fonts.iosevka
		pkgs.corefonts
		pkgs.noto-fonts-cjk-sans
	];

	fonts.fontconfig.localConf = ''
		<fontconfig>
			<alias binding="strong">
				<family>sans-serif</family>
				<prefer><family>Noto Color Emoji</family></prefer>
			</alias>
			<alias binding="strong">
				<family>serif</family>
				<prefer><family>Noto Color Emoji</family></prefer>
			</alias>
			<alias binding="strong">
				<family>monospace</family>
				<prefer><family>Noto Color Emoji</family></prefer>
			</alias>
		</fontconfig>
	'';
}
