{pkgs, ...}:
{
  xdg.configFile."zathura/catppuccin-mocha".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/zathura/main/src/catppuccin-mocha";
    hash = "sha256-/HXecio3My2eXTpY7JoYiN9mnXsps4PAThDPs4OCsAk=";
  };
  programs.zathura = {
    enable = true;
    extraConfig = "include catppuccin-mocha";
  };
}