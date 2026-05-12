{ ... }:
{
	services.keyd = {
		enable = true;
		keyboards.default = {
			ids = [ "*" "!17aa:5054" ];
			settings.main.capslock = "overload(control, esc)";
		};
	};
}
