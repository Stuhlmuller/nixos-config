{ pkgs, user, ... }:
{
  system.primaryUser = user.name;

  environment.variables.STARSHIP_CONFIG = "${../../themes/gruvbox-rainbow/starship.toml}";

  programs.zsh = {
    enable = true;
    promptInit = ''
      eval "$(${pkgs.starship}/bin/starship init zsh)"
    '';
  };
}
