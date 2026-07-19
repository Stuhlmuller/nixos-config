# nixos-config

`nix-darwin` configuration for Rodman's Apple silicon Mac. Applying it installs
the base command-line tools system-wide and enables `direnv` for project flakes.

## Onboard the Mac

Complete the one-time prerequisites below, then run `make` from this repository.

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

Run the default workflow. It checks and builds the configuration before asking
for administrator access to activate it:

```sh
make
```

Open a new Terminal after it finishes, then verify the installed system and
tools:

```sh
make verify
```

## Apply later changes

From this repository, run:

```sh
make
```

Use `make check` to validate only, `make build` to build without activating,
`make switch` to activate without rebuilding first, or `make help` to list all
available commands. Override the configuration for another host with
`make HOST=<host-name>`.

The configuration installs `curl`, Git/GitHub CLI, GnuPG, `jq`, `nixfmt`, and
`ripgrep` for all users. It also enables Starship with its default prompt and
installs MesloLGS Nerd Font. Language runtimes, services, and infrastructure
CLIs belong in project flakes.

## Repository layout

```text
flake.nix                  Flake inputs and named system outputs
Makefile                   Check, build, activate, and verify commands
hosts/darwin/              One entry point per Mac installation
lib/                       Constructors shared by system outputs
modules/darwin/            Small, reusable nix-darwin configuration modules
packages/                  Package collections grouped by purpose
profiles/darwin/           Roles composed from reusable modules
themes/                    Shared application theme presets
users/                     User identity and user-specific system settings
```

To add another Mac, create `hosts/darwin/<host>/default.nix` and add a matching
`darwinConfigurations.<host>` call in `flake.nix`. Put settings shared by
multiple Macs in `modules/darwin/`, then compose them into a profile rather than
copying them between hosts.

Each user directory owns its hardcoded identity and platform modules. For
example, `users/themanofrod/default.nix` declares the account name and points to
that user's nix-darwin module. Other parts of the configuration consume this
user object without repeating the username.
