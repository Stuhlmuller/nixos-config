{ hostName, user, ... }:
{
  imports = [
    ../../../profiles/darwin/workstation.nix
    user.darwinModule
  ];

  networking.hostName = hostName;
}
