{ pkgs, ... }:
{
  environment.systemPackages = import ../../packages/cli.nix { inherit pkgs; };
}
