# modules/features/joshua-password.nix
{ config, ... }: {
  age.secrets.joshua-password = {
    file = ../../secrets/joshua-password.age;
  };
  users.users.joshua.hashedPasswordFile = 
    config.age.secrets.joshua-password.path;
}
