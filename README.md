# nixos-config

Portable baseline for interactive development. Enter it with:

```sh
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
nix develop path:.
```

The base shell provides `curl`, Git/GitHub CLI, GnuPG, `jq`, `nixfmt`, and
`ripgrep`. Keep language runtimes, services, and infrastructure CLIs in each
project's flake.
