{pkgs, ...}: {
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    colorSchemes = {
      apatheia = {
        background = "#11111b";
      };
    };
    extraConfig = builtins.readFile ./wezterm.lua;
  };
}
