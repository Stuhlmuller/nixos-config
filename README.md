# nixos-config

`nix-darwin` configuration for Rodman's Apple silicon Mac. Applying it installs
the base command-line tools system-wide and enables `direnv` for project flakes.

## Onboard the Mac

Run each block in Terminal.

### 1. Confirm the target

```sh
uname -m
id -un
scutil --get LocalHostName
```

The expected values are `arm64`, `themanofrod`, and `Rodmans-MacBook-Pro`.

### 2. Install Apple's command-line tools

```sh
xcode-select --print-path >/dev/null 2>&1 || xcode-select --install
```

If an installer opens, finish it before continuing. Then verify Git is ready:

```sh
xcode-select --print-path
git --version
```

See [Apple's installation guide](https://developer.apple.com/documentation/xcode/installing-the-command-line-tools/).

### 3. Install and activate Nix

Use the [official macOS installer](https://nix.dev/install-nix):

```sh
curl -L https://nixos.org/nix/install | sh
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
nix --version
```

Enable flakes before the first system build:

```sh
mkdir -p "$HOME/.config/nix"
touch "$HOME/.config/nix/nix.conf"
grep -qxF 'extra-experimental-features = nix-command flakes' "$HOME/.config/nix/nix.conf" ||
  printf '%s\n' 'extra-experimental-features = nix-command flakes' >> "$HOME/.config/nix/nix.conf"
nix config show experimental-features
```

The final command should list both `nix-command` and `flakes`.

### 4. Clone the configuration

```sh
mkdir -p "$HOME/github-repositories"
git clone https://github.com/Stuhlmuller/nixos-config.git "$HOME/github-repositories/nixos-config"
cd "$HOME/github-repositories/nixos-config"
```

### 5. Build and apply the system

Evaluate and build before changing macOS:

```sh
nix flake check
nix build .#darwinConfigurations.Rodmans-MacBook-Pro.system --no-link
```

Bootstrap `nix-darwin` and activate this configuration:

```sh
sudo nix run github:nix-darwin/nix-darwin/master#darwin-rebuild -- \
  switch --flake .#Rodmans-MacBook-Pro
```

Open a new Terminal, then verify the installed system and tools:

```sh
darwin-version
command -v darwin-rebuild curl direnv gh git gpg jq nixfmt rg
```

## Apply later changes

From this repository, run:

```sh
nix flake check
sudo darwin-rebuild switch --flake .#Rodmans-MacBook-Pro
```

The configuration installs `curl`, Git/GitHub CLI, GnuPG, `jq`, `nixfmt`, and
`ripgrep` for all users. Language runtimes, services, and infrastructure CLIs
belong in project flakes.
