# modules/features/melissa-password.nix
{ config, lib, ... }:
let
  cfg = config.jsp.melissa-password;
in
{
  options.jsp.melissa-password.enable =
    lib.mkEnableOption "melissa's login password, decrypted by agenix";

  config = lib.mkIf cfg.enable {
    age.secrets.melissa-password = {
      file = ../../secrets/melissa-password.age;
    };
    users.users.melissa.hashedPasswordFile =
      config.age.secrets.melissa-password.path;
  };
}
