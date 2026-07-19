{ pkgs, user, ... }:
{
  system.primaryUser = user.name;
<<<<<<< Updated upstream

  environment.variables.STARSHIP_CONFIG = "${../../themes/gruvbox-rainbow/starship.toml}";
=======
  environment.shellAliases.reload = "exec zsh -l";
>>>>>>> Stashed changes

  programs.zsh = {
    enable = true;
    promptInit = ''
      eval "$(${pkgs.starship}/bin/starship init zsh)"
    '';
  };
}
