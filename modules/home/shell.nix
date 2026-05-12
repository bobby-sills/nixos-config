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
        if ! git diff --cached --quiet; then
          git commit -m "$MSG"
        fi
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

  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      unimatrix = "unimatrix -c green -b -s 96 -l o";
      ls = "eza --icons=always";
      hl = "hledger -f ~/finance/main.journal --pretty";
    };
    initExtra = ''
      export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
    '';
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

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
    };
    initLua = ''
      require("pref-by-location"):setup({})
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

  programs.yt-dlp = {
    enable = true;
    settings = {
      embed-subs = true;
      sub-langs = "en,en-orig";
    };
  };
}
