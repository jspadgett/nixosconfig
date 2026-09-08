# /modules/features/joshua-ssh-private-key.nix
{ config, lib, ... }:
let
  cfg = config.jsp.joshua-ssh-private-key;
in
{
  options.jsp.joshua-ssh-private-key.enable =
    lib.mkEnableOption "joshua's SSH private key, decrypted by agenix and symlinked into ~/.ssh";

  config = lib.mkIf cfg.enable {
    age.secrets.joshua-ssh-key = {
      file = ../../secrets/joshua-ssh-key.age;
      owner = "joshua";
      mode = "0600";
    };

    systemd.tmpfiles.rules = [
      "L /home/joshua/.ssh/id_ed25519 - - - - ${config.age.secrets.joshua-ssh-key.path}"
    ];
  };
}
