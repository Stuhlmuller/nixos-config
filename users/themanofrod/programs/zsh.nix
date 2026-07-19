{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;

    promptInit = ''
      eval "$(${pkgs.starship}/bin/starship init zsh)"
    '';
  };
}
