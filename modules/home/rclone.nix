{ pkgs, ... }:
{
  systemd.user.services.rclone-gdrive = {
    Unit = {
      Description = "rclone Google Drive mount";
      After = [ "network-online.target" ];
    };
    Service = {
      Type = "notify";
      ExecStart = "${pkgs.rclone}/bin/rclone mount gdrive: %h/gdrive --vfs-cache-mode writes";
      ExecStop = "${pkgs.fuse3}/bin/fusermount3 -u %h/gdrive";
      Restart = "on-failure";
    };
    Install = {};
  };
}
