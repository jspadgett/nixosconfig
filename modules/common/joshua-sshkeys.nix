# modules/common/joshua-sshkeys.nix
{ ... }: {
  users.users.joshua.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOz7G/K/Ab5ktOMNcYkIVbZVkFoyq4aJqItnhrviXaZv joshua@nixos" # aether - ~/.ssh/id_ed25519.pub
  ];
}
