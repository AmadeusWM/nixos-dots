{ pkgs, config, ... }:
{
  # programs.vscode = {
  #   enable = true;
  #   extensions = with pkgs.vscode-extensions; [
  #     dracula-theme.theme-dracula
  #     ms-vscode.cpptools
  #     jnoortheen.nix-ide
  #     rust-lang.rust-analyzer
  #   ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
  #     # {
  #     #   name = "platformio-ide";
  #     #   publisher = "platformio";
  #     #   version = "3.3.0";
  #     #   sha256 = "sha256-PP+koBvJOSjYiExPIlsK8txiXgbBoum598JBgwwmWVA=";
  #     # }
  #     {
  #       name = "tauri-vscode";
  #       publisher = "tauri-apps";
  #       version = "0.2.6";
  #       sha256 = "sha256-O9NxFemUgt9XmhL6BnNArkqbCNtHguSbvVOYwlT0zg4=";
  #     }
  #   ];
  #   enableExtensionUpdateCheck = false;
  #   enableUpdateCheck = true;
  #   userSettings = {
  #     "terminal.integrated.defaultProfile.osx": "zsh",
  #     "terminal.integrated.fontFamily": "JetbrainsMono Nerd Font, Sans",
  #     "window.zoomLevel": 1,
  #     "platformio-ide.useBuiltinPIOCore" = false;
  #   };
  # };
}