{ lib, user, ... }:
{
  environment.shellAliases = {
    c = "clear";
    da = "direnv allow";
    rebuild = "direnv reload";
    reload = "make -C ${lib.escapeShellArg user.nixConfigDirectory} && exec zsh -l";
  };
}
