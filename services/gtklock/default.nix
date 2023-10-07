{ pkgs, config, ... }:
{
  # example: https://github.com/jovanlanik/gtklock/wiki/Per-output-background-example
  xdg.configFile."${config.home.homeDirectory}/.config/gtklock/config.ini".text = ''

  '';
  xdg.configFile."${config.home.homeDirectory}/.config/gtklock/style.css".text = ''
    #input-label {
        font-size: 0;
        /* opacity: 0;*/
    }
  '';
}