{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;

    promptInit = ''
      export STARSHIP_CONFIG=${../../../themes/nerd-font.toml}
      eval "$(${pkgs.starship}/bin/starship init zsh)"
    '';
  };
}
