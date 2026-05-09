{ pkgs, ... }:
{
  home.sessionVariables = {
    TZ = "Asia/Bangkok";
  };

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
    settings = {
      mgr.sort_reverse = true;
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
