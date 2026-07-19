let
  name = "themanofrod";
in
{
  inherit name;

  darwinModule = ./darwin.nix;
  nixConfigDirectory = "/Users/${name}/github-repositories/nixos-config";
}
