{pkgs, ...}: {
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
  };
}
