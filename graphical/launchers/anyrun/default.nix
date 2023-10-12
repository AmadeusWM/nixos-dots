{ pkgs, inputs, ... }:
{
  imports = [inputs.anyrun.homeManagerModules.default];
  programs.anyrun = {
    enable = true;
    config = {
      plugins = [
        # An array of all the plugins you want, which either can be paths to the .so files, or their packages
        inputs.anyrun.packages.${pkgs.system}.applications
        inputs.anyrun.packages.${pkgs.system}.dictionary
        inputs.anyrun.packages.${pkgs.system}.translate
        # "${inputs.anyrun.packages.${pkgs.system}.anyrun-with-all-plugins}/lib/kidex"
      ];
      width = { fraction = 0.3; };
      y.absolute = 15;
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
    };
    extraCss = ''
      * {
        transition: 200ms ease;
        font-family: Lexend;
        font-size: 1.3rem;
      }

      #window,
      #match,
      #entry,
      #plugin,
      #main {
        background: transparent;
      }

      #match:selected {
        background: rgba(203, 166, 247, 0.7);
      }

      #match {
        padding: 3px;
        border-radius: 16px;
      }

      #entry, #plugin:hover {
        border-radius: 8px;
      }

      box#main {
        background: rgba(12, 11, 16, 0.7);
        border: 1px solid rgba(12, 11, 16, 0.7);
        border-radius: 12px;
        padding: 8px;
      }
    '';

    extraConfigFiles."some-plugin.ron".text = ''
      Config(
        // for any other plugin
        // this file will be put in ~/.config/anyrun/some-plugin.ron
        // refer to docs of xdg.configFile for available options
        prefix: ":def", // for dictionary
      )
    '';
  };
}