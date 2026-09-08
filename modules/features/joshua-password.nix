# modules/features/joshua-password.nix
{ config, lib, ... }:
let
  cfg = config.jsp.joshua-password;
in
{
  options.jsp.joshua-password.enable =
    lib.mkEnableOption "joshua's login password, decrypted by agenix";

  config = lib.mkIf cfg.enable {
    age.secrets.joshua-password = {
      file = ../../secrets/joshua-password.age;
    };
    users.users.joshua.hashedPasswordFile =
      config.age.secrets.joshua-password.path;
  };
}
