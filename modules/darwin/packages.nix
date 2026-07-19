{ pkgs, ... }:
{
  environment.systemPackages = import ../../packages/cli.nix { inherit pkgs; };

  fonts.packages = [ pkgs.nerd-fonts.meslo-lg ];
}
