# modules/nas/fast-darktable-nfs.nix
{ ... }: {
  fileSystems."/mnt/darktable" = {
    device  = "192.168.1.188:/mnt/fast/darktable";
    fsType  = "nfs";
    options = [
      "x-systemd.automount"        # mount on first access
      "x-systemd.idle-timeout=600" # unmount after 10min idle
      "noauto"                     # don't mount at boot
      "_netdev"                    # wait for network
      "hard"                       # retry indefinitely (safe for DB)
      "timeo=600"                  # 60s timeout before retry
      "retrans=5"                  # retry 5 times
      "nfsvers=4"                  # use NFSv4
    ];
  };

  fileSystems."/mnt/darktable/db" = {
    device  = "192.168.1.188:/mnt/fast/darktable/db";
    fsType  = "nfs";
    options = [
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "noauto"
      "_netdev"
      "hard"
      "sync"                       # critical — SQLite needs real fsync
      "timeo=600"
      "retrans=5"
      "nfsvers=4"
    ];
  };
}
