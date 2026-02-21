# secrets/secrets.nix
let
  aether = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILZUcZ76u9ZaQ3ak77tcX+Kv4MwLeVECe28h3hp6foK0 root@nixos"; # cat /etc/ssh/ssh_host_ed25519_key.pub on aether
  athena = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMqgHeus5mbrPbLTvvu56aN0yyZcKHrqKnkqRivZNR1j root@annasnix"; # cat /etc/ssh/ssh_host_ed25519_key.pub on athena
  joshua = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOz7G/K/Ab5ktOMNcYkIVbZVkFoyq4aJqItnhrviXaZv joshua@nixos"; # cat ~/.ssh/id_ed25519.pub on aether
in {
  "joshua-password.age".publicKeys = [ aether athena joshua ];
  "anna-password.age".publicKeys = [ athena joshua ];
  "joshua-ssh-key.age".publicKeys = [ aether athena joshua ];
}
