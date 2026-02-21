# modules/features/anna-password.nix
{ config, ... }: {
  age.secrets.anna-password = {
    file = ../../secrets/anna-password.age;
  };
  users.users.anna.hashedPasswordFile = 
    config.age.secrets.anna-password.path;
}
