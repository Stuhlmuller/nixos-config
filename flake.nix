{
  description = "NixOS systems and tools";

  inputs = {
    # Pin our primary nixpkgs repository. This is the main nixpkgs repository
    # we'll use for our configurations. Be very careful changing this because
    # it'll impact your entire system.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    # We use the unstable nixpkgs repo for some packages.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      # We need to use nightly home-manager because it contains this
      # fix we need for nushell nightly:
      # https://github.com/nix-community/home-manager/commit/a69ebd97025969679de9f930958accbe39b4c705
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  }

  outputs = { nixpkgs, ... }@inputs: let
    # Overlays is the list of overlays we want to apply from flake inputs.
    overlays = [

      (_final: prev: let
        system = prev.stdenv.hostPlatform.system;
        unstable = import inputs.nixpkgs-unstable {
          inherit system;
        };
      in {
        # gh CLI on stable has bugs.
        gh = unstable.gh;

        # Want the latest version of these
        nushell = unstable.nushell;
      })
    ];

    mkSystem = import ./lib/mksystem.nix {
      inherit overlays nixpkgs inputs;
    };
  in {
    darwinConfigurations.macbook-pro-m4 = mkSystem "macbook-pro-m4" {
      system = "aarch64-darwin";
      user   = "themanofrod";
      darwin = true;
    };
  };
}
