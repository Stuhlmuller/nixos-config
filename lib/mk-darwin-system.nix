{ self, nix-darwin }:
{
  hostName,
  system,
  user,
}:
nix-darwin.lib.darwinSystem {
  specialArgs = {
    inherit self hostName user;
  };

  modules = [
    { nixpkgs.hostPlatform = system; }
    ../hosts/darwin/${hostName}
  ];
}
