# modules/features/melissa-password.nix
{ config, ... }: {
  age.secrets.melissa-password = {
    file = ../../secrets/melissa-password.age;
  };
  users.users.melissa.hashedPasswordFile =
    config.age.secrets.melissa-password.path;
}
