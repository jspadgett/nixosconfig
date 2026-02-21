# modules/features/joshua-ssh-private-key.nix
{ config, ... }: {
  age.secrets.joshua-ssh-key = {
    file = ../../secrets/joshua-ssh-key.age;
    owner = "joshua";
    mode = "0600";
  };
   systemd.tmpfiles.rules = [
     "L /home/joshua/.ssh/id_ed25519 - - - - ${config.age.secrets.joshua-ssh-key.path}"
];
}
