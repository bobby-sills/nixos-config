{ ... }:
{
  programs.spotify-player = {
    enable = true;
    settings = {
      notify_transient = true;
      theme = "gruvbox-fix";
    };

    actions = [
      {
        action = "ToggleLiked";
        key_sequence = "C-l";
      }
    ];

    themes = [
      {
        name = "gruvbox-fix";
        component_style = {
          playback_progress_bar = {
	    fg = "Yellow"; 
	    bg = "BrightBlack";
	  };
        };
      }
    ];
  };
}
