{
  description = "Rodman's nix-darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self, nix-darwin, ... }:
    {
      darwinConfigurations."Rodmans-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        modules = [
          (
            { pkgs, ... }:
            {
              environment.systemPackages = with pkgs; [
                curl
                gh
                git
                gnupg
                jq
                nixfmt
                ripgrep
              ];

              nix.settings.experimental-features = [
                "nix-command"
                "flakes"
              ];

              programs.direnv.enable = true;

              system.primaryUser = "themanofrod";
              system.configurationRevision = self.rev or self.dirtyRev or null;
              system.stateVersion = 6;

              nixpkgs.hostPlatform = "aarch64-darwin";
            }
          )
        ];
      };
    };
}
