{ pkgs, ... }:
let
  yaziWrapper = pkgs.writeShellScriptBin "yazi-wrapper" ''
    multiple="$1"
    directory="$2"
    save="$3"
    path="$4"
    out="$5"
    debug="$6"

    set -e
    [ "$debug" = 1 ] && set -x

    cmd="${pkgs.yazi}/bin/yazi"
    termcmd="''${TERMCMD:-${pkgs.kitty}/bin/kitty --title 'termfilechooser'}"

    if [ "$save" = "1" ]; then
      set -- --chooser-file="$out" "$path"
    elif [ "$directory" = "1" ]; then
      set -- --chooser-file="$out" --cwd-file="''${out}.1" "$path"
    elif [ "$multiple" = "1" ]; then
      set -- --chooser-file="$out" "$path"
    else
      set -- --chooser-file="$out" "$path"
    fi

    command="$termcmd $cmd"
    for arg in "$@"; do
      escaped=$(printf "%s" "$arg" | sed 's/"/\\"/g')
      command="$command \"$escaped\""
    done
    sh -c "$command"

    if [ "$directory" = "1" ]; then
      if [ ! -s "$out" ] && [ -s "''${out}.1" ]; then
        cat "''${out}.1" > "$out"
        rm "''${out}.1"
      else
        rm -f "''${out}.1"
      fi
    fi
  '';
in
{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    shellWrapperName = "y";
    plugins = {
      pref-by-location = pkgs.yaziPlugins.mkYaziPlugin {
        pname = "pref-by-location";
        version = "unstable-2025-05-09";
        src = pkgs.fetchurl {
          url = "https://github.com/boydaihungst/pref-by-location.yazi/archive/refs/heads/master.tar.gz";
          hash = "sha256-uGNihFVF1RnZ6sCAZ+g/kZTkNqWI23UPS2huxElpRng=";
        };
      };
      restore = pkgs.yaziPlugins.mkYaziPlugin {
        pname = "restore";
        version = "unstable-2026-05-13";
        src = pkgs.fetchurl {
          url = "https://github.com/boydaihungst/restore.yazi/archive/refs/heads/master.tar.gz";
          hash = "sha256-OfIIUqJ9cxpQ/Ycwc7orHOA2Pxr/Ww7r7eqAIykCkYE=";
        };
      };
    };
    initLua = ''
      require("pref-by-location"):setup({})
      require("restore"):setup({})
    '';
    keymap = {
      mgr.prepend_keymap = [
        { on = [ "," "d" ]; run = [ "sort --dir-first=no" "plugin pref-by-location -- save" ]; desc = "Directories and files mixed"; }
        { on = [ "," "D" ]; run = [ "sort --dir-first=yes" "plugin pref-by-location -- save" ]; desc = "Directories first"; }
        { on = "."; run = [ "hidden toggle" "plugin pref-by-location -- save" ]; desc = "Toggle the visibility of hidden files"; }
        { on = [ "m" "s" ]; run = [ "linemode size" "plugin pref-by-location -- save" ]; desc = "Linemode: size"; }
        { on = [ "m" "p" ]; run = [ "linemode permissions" "plugin pref-by-location -- save" ]; desc = "Linemode: permissions"; }
        { on = [ "m" "b" ]; run = [ "linemode btime" "plugin pref-by-location -- save" ]; desc = "Linemode: btime"; }
        { on = [ "m" "m" ]; run = [ "linemode mtime" "plugin pref-by-location -- save" ]; desc = "Linemode: mtime"; }
        { on = [ "m" "o" ]; run = [ "linemode owner" "plugin pref-by-location -- save" ]; desc = "Linemode: owner"; }
        { on = [ "m" "n" ]; run = [ "linemode none" "plugin pref-by-location -- save" ]; desc = "Linemode: none"; }
        { on = [ "," "t" ]; run = "plugin pref-by-location -- toggle"; desc = "Toggle auto-save preferences"; }
        { on = [ "," "R" ]; run = "plugin pref-by-location -- reset"; desc = "Reset preference of cwd"; }
        { on = [ "," "M" ]; run = [ "sort mtime --reverse=no" "linemode mtime" "plugin pref-by-location -- save" ]; desc = "Sort by modified time"; }
        { on = [ "," "m" ]; run = [ "sort mtime --reverse" "linemode mtime" "plugin pref-by-location -- save" ]; desc = "Sort by modified time (reverse)"; }
        { on = [ "," "B" ]; run = [ "sort btime --reverse=no" "linemode btime" "plugin pref-by-location -- save" ]; desc = "Sort by birth time"; }
        { on = [ "," "b" ]; run = [ "sort btime --reverse" "linemode btime" "plugin pref-by-location -- save" ]; desc = "Sort by birth time (reverse)"; }
        { on = [ "," "E" ]; run = [ "sort extension --reverse=no" "plugin pref-by-location -- save" ]; desc = "Sort by extension"; }
        { on = [ "," "e" ]; run = [ "sort extension --reverse" "plugin pref-by-location -- save" ]; desc = "Sort by extension (reverse)"; }
        { on = [ "," "A" ]; run = [ "sort alphabetical --reverse=no" "plugin pref-by-location -- save" ]; desc = "Sort alphabetically"; }
        { on = [ "," "a" ]; run = [ "sort alphabetical --reverse" "plugin pref-by-location -- save" ]; desc = "Sort alphabetically (reverse)"; }
        { on = [ "," "N" ]; run = [ "sort natural --reverse=no" "plugin pref-by-location -- save" ]; desc = "Sort naturally"; }
        { on = [ "," "n" ]; run = [ "sort natural --reverse" "plugin pref-by-location -- save" ]; desc = "Sort naturally (reverse)"; }
        { on = [ "," "S" ]; run = [ "sort size --reverse=no" "linemode size" "plugin pref-by-location -- save" ]; desc = "Sort by size"; }
        { on = [ "," "s" ]; run = [ "sort size --reverse" "linemode size" "plugin pref-by-location -- save" ]; desc = "Sort by size (reverse)"; }
        { on = [ "," "r" ]; run = [ "sort random --reverse=no" "plugin pref-by-location -- save" ]; desc = "Sort randomly"; }
        { on = [ "g" "m" ]; run = "cd /mnt/media"; desc = "Go to /mnt/media"; }
        { on = [ "g" "v" ]; run = "cd ~/Videos"; desc = "Go to ~/Videos"; }
        { on = [ "g" "t" ]; run = "cd ~/.local/share/Trash/files"; desc = "Go to Trash"; }
        { on = [ "d" "u" ]; run = "plugin restore"; desc = "Restore last deleted files/folders"; }
        { on = [ "d" "U" ]; run = "plugin restore -- --interactive"; desc = "Restore deleted files/folders (interactive)"; }
      ];
    };
    settings = {
      opener = {
        video = [{ run = ''mpv "$@"''; orphan = true; }];
        audio = [{ run = ''mpv "$@"''; orphan = true; }];
      };
      open.rules = [
        { mime = "video/*"; use = "video"; }
        { mime = "audio/*"; use = "audio"; }
      ];
    };
  };

  home.packages = [ yaziWrapper pkgs.xdg-desktop-portal-termfilechooser pkgs.trash-cli ];

  systemd.user.services.xdg-desktop-portal-termfilechooser = {
    Service.ExecStart = [
      ""
      "${pkgs.xdg-desktop-portal-termfilechooser}/libexec/xdg-desktop-portal-termfilechooser -r"
    ];
  };

  xdg.configFile."xdg-desktop-portal-termfilechooser/config".text = ''
    [filechooser]
    cmd=${yaziWrapper}/bin/yazi-wrapper
    default_dir=$HOME
    open_mode=last
    save_mode=last
  '';

  xdg.desktopEntries.yazi = {
    name = "Yazi";
    exec = "kitty yazi %u";
    terminal = false;
    mimeType = [ "inode/directory" ];
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications."inode/directory" = "yazi.desktop";
  };
}
