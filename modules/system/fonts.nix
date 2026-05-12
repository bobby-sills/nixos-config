{ pkgs, ... }:
{
	fonts.packages = [
		pkgs.nerd-fonts.symbols-only
		pkgs.nerd-fonts.iosevka
		pkgs.corefonts
		pkgs.noto-fonts-cjk-sans
	];

}
