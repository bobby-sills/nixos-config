{ ... }:
{
  programs.spotify-player = {
    enable = true;
    settings = {
      notify_transient = true;
      theme = "custom";
      layout = {
        playback_window_height = 11;
      };
      cover_img_length = 24;
      cover_img_width = 9;
      cover_img_scale = 1.0;
    };

    keymaps = [
      {
        command = "Quit";
        key_sequence = "q";
      }
    ];

    actions = [
      {
        action = "ToggleLiked";
        key_sequence = "C-l";
        target = "PlayingTrack";
      }
      {
        action = "AddToPlaylist";
        key_sequence = "C-a";
      }
    ];

    themes = [
      {
        name = "custom";
        component_style = {
          playback_progress_bar = { fg = "Green"; };
        };
      }
    ];
  };
}
