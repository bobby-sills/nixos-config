{ pkgs, lib, ... }:
let
  nordvpn = pkgs.stdenv.mkDerivation rec {
    pname = "nordvpn";
    version = "4.6.0";

    src = pkgs.fetchurl {
      url = "https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/n/nordvpn/nordvpn_${version}_amd64.deb";
      sha256 = "1qs2r5qbhj64b1yljngabajsipxz3nhq6pmg7hs9cb73mj02zsdp";
    };

    nativeBuildInputs = with pkgs; [ dpkg patchelf makeWrapper ];

    buildInputs = with pkgs; [
      glibc
      libgcc
      systemd
      iptables
      iproute2
      procps
      libxml2
      zlib
      openssl
      sqlite
    ];

    unpackPhase = "dpkg-deb -x $src .";

    installPhase = ''
      mkdir -p $out/bin $out/lib/nordvpn $out/share
      if [ -d usr/bin ]; then cp -r usr/bin/* $out/bin/; fi
      if [ -d usr/sbin ]; then cp -r usr/sbin/* $out/bin/; fi
      if [ -d usr/lib/nordvpn ]; then cp -r usr/lib/nordvpn/* $out/lib/nordvpn/; fi
      if [ -d usr/share ]; then cp -r usr/share/* $out/share/; fi

      for bin in $out/bin/nordvpn $out/bin/nordvpnd; do
        if [ -f "$bin" ]; then
          patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" "$bin"
          patchelf --set-rpath "$out/lib/nordvpn:${pkgs.lib.makeLibraryPath buildInputs}" "$bin"
        fi
      done

      wrapProgram $out/bin/nordvpn \
        --prefix PATH : "${pkgs.lib.makeBinPath [ pkgs.iptables pkgs.iproute2 pkgs.procps ]}" \
        --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath buildInputs}"

      wrapProgram $out/bin/nordvpnd \
        --prefix PATH : "${pkgs.lib.makeBinPath [ pkgs.iptables pkgs.iproute2 pkgs.procps ]}" \
        --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath buildInputs}"
    '';

    meta = with pkgs.lib; {
      description = "NordVPN CLI client";
      homepage = "https://nordvpn.com";
      license = licenses.unfree;
      platforms = platforms.linux;
    };
  };
in
{
  environment.systemPackages = [ nordvpn ];

  users.users.nordvpn = {
    isSystemUser = true;
    group = "nordvpn";
    description = "NordVPN daemon user";
  };
  users.groups.nordvpn = {};

  systemd.tmpfiles.rules = [
    "d /var/lib/nordvpn 0755 nordvpn nordvpn -"
    "d /var/lib/nordvpn/data 0755 nordvpn nordvpn -"
  ];

  systemd.services.nordvpnd = {
    description = "NordVPN Daemon";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${nordvpn}/bin/nordvpnd";
      Restart = "always";
      User = "nordvpn";
      Group = "nordvpn";
      StateDirectory = "nordvpn";
      RuntimeDirectory = "nordvpn";
      WorkingDirectory = "/var/lib/nordvpn";
      Environment = "PATH=${pkgs.lib.makeBinPath [ pkgs.iptables pkgs.iproute2 pkgs.procps ]}";
    };
  };
}
