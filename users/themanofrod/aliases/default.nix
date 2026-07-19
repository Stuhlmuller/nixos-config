{ lib, user, ... }:
{
  environment.shellAliases.reload = "make -C ${lib.escapeShellArg user.nixConfigDirectory} && exec zsh -l";
}
