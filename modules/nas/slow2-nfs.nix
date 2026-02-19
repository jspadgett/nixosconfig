# modules/nas/slow2-nfs.nix
{ ... }: {

  fileSystems."/mnt/media" = {
    device  = "192.168.1.188:/mnt/slow2";
    fsType  = "nfs";
    options = [
      "x-systemd.automount"        # mount on first access
      "x-systemd.idle-timeout=600" # unmount after 10min idle
      "noauto"                     # don't mount at boot
      "_netdev"                    # wait for network
      "soft"                       # fail cleanly if NAS unreachable
      "timeo=30"                   # 3s per retry
      "retrans=3"                  # retry 3 times then give up
      "nfsvers=4"                  # use NFSv4
    ];
  };
}
