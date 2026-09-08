# modules/features/anna-password.nix
{ config, lib, ... }:
let
  cfg = config.jsp.anna-password;
in
{
  options.jsp.anna-password.enable =
    lib.mkEnableOption "anna's login password, decrypted by agenix";

  config = lib.mkIf cfg.enable {
    age.secrets.anna-password = {
      file = ../../secrets/anna-password.age;
    };
    users.users.anna.hashedPasswordFile =
      config.age.secrets.anna-password.path;
  };
}
