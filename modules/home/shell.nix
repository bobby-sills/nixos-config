{ pkgs, ... }:
let
  micmute_toggle = pkgs.writeShellScriptBin "micmute-toggle" ''
    wpctl set-mute @DEFAULT_SOURCE@ toggle
    if wpctl get-volume @DEFAULT_SOURCE@ | grep -q MUTED; then
      echo 1 > /sys/class/leds/platform::micmute/brightness
    else
      echo 0 > /sys/class/leds/platform::micmute/brightness
    fi
    swayosd-client --input-volume mute-toggle
  '';
  hyprsunset_osd = pkgs.writeShellScriptBin "hyprsunset-osd" ''
    hyprctl hyprsunset temperature "$1"
    kelvin=$(hyprctl hyprsunset temperature)
    progress=$(awk -v k="$kelvin" 'BEGIN {printf "%.3f", (k - 1000) / 19000}')
    swayosd-client --custom-progress "$progress" --custom-icon "night-light-symbolic"
  '';
  idle_inhibitor = pkgs.writeShellScriptBin "idle-inhibitor" ''
    PIDFILE="/tmp/idle-inhibitor.pid"
    ICON=

    toggle() {
      if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
        kill "$(cat "$PIDFILE")"
        rm -f "$PIDFILE"
      else
        systemd-inhibit --what=idle --who="idle-inhibitor" --why="User requested" sleep infinity &
        echo $! >"$PIDFILE"
      fi
      pkill -RTMIN+9 waybar
    }

    status() {
      if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
        echo "{\"text\": \"$ICON \", \"class\": \"activated\"}"
      else
        echo '{"text": "", "class": "deactivated"}'
      fi
    }

    case "$1" in
    toggle) toggle ;;
    status) status ;;
    *) status ;;
    esac
  '';
in
{
  home.packages = [
    micmute_toggle
    hyprsunset_osd
    idle_inhibitor
    (pkgs.writeShellScriptBin "rebuild" ''
      set -e
      cd ~/nixos-config

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

      sudo nixos-rebuild switch --flake ~/nixos-config#nixos-btw

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
      lg = "lazygit";
      r = "rebuild";
    };
    initExtra = ''
      export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
      export GTK_USE_PORTAL=1
      export FZF_CTRL_T_COMMAND="find . -not \( -path '*/gdrive*' -prune \) -type f 2>/dev/null"
      nordvpn() {
        command nordvpn "$@" | grep -v "A new version of NordVPN is available!" | grep -v "Please update the app."
      }
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

  programs.yt-dlp = {
    enable = true;
    settings = {
      embed-subs = true;
      sub-langs = "en,en-orig";
    };
  };

  xdg.configFile."gdu/gdu.yaml".text = ''
    ignore-dirs:
      - /home/bobby/gdrive
  '';
}
