{
  description = "Rodman's nix-darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, nix-darwin, ... }:
    let
      mkDarwinSystem = import ./lib/mk-darwin-system.nix {
        inherit self nix-darwin;
      };
      primaryUser = import ./users/themanofrod;
    in
    {
      darwinConfigurations.macbook-pro-m4 = mkDarwinSystem {
        hostName = "macbook-pro-m4";
        system = "aarch64-darwin";
        user = primaryUser;
      };
    };
}
