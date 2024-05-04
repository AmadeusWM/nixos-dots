{ inputs, pkgs, config, lib, ... }:
let
  chromePath = "${config.home.homeDirectory}/nixos/modules/home-manager-modules/graphical/apps/firefox/themes/minimal";
  # chromePath = "${config.home.homeDirectory}/nixos/modules/home-manager-modules/graphical/apps/firefox/themes/apatheia";
in
{
  # Example config source: https://discourse.nixos.org/t/help-setting-up-firefox-with-home-manager/23333
  programs.firefox = {
    enable = true;
    # package = inputs.firefox.packages.${pkgs.system}.firefox-nightly-bin;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
        CaptivePortal = false;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisableFirefoxAccounts = false;
        NoDefaultBookmarks = true;
        FirefoxHome = {
          Search = true;
          Pocket = false;
          Snippets = false;
          TopSites = false;
          Highlights = false;
        };
      };
    };
    profiles = {
      default = {
        id = 0;
        name = "amadeus";
        settings = {
          "general.smoothScroll" = true;
          # source: https://github.com/PrettyCoffee/fluidity#usage
          "browser.startup.homepage" = "${config.home.homeDirectory}/nixos/modules/home-manager-modules/graphical/apps/firefox/startpages/dawn/index.html";
        };
        extraConfig = ''
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          user_pref("svg.context-properties.content.enabled", true);
          user_pref("browser.display.background_color.dark", "#11111B");
        '';
        # userChrome = ''
        #   @import "${chromePath}/config.css";
        #   @import "${chromePath}/variables.css";
        #   @import "${chromePath}/icons/icons.css";
        #   @import "${chromePath}/urlbar/urlbar.css";
        #   @import "${chromePath}/navbar/navbar.css";
        #   @import "${chromePath}/popup/popup.css";
        #   @import "${chromePath}/interface/interface.css";
        #   @import "${chromePath}/userChrome-tabline.css";
        #   @import "${chromePath}/content/inner-rounded.css";
        # '';
        userChrome = ''
          @import "${chromePath}/userContent.css";
          @import "${chromePath}/userChrome.css";
        '';
        
        # containers = {
        #   personal = {
        #     color = "blue";
        #     icon = "fingerprint";
        #     id = 1;
        #   };
        #   work = {
        #     color = "yellow";
        #     icon = "briefcase";
        #     id = 2;
        #   };
        #   banking = {
        #     color = "green";
        #     icon = "dollar";
        #     id = 3;
        #   };
        #   shopping = {
        #     color = "pink";
        #     icon = "cart";
        #     id = 4;
        #   };
        #   dangerous = {
        #     color = "red";
        #     icon = "fruit";
        #     id = 5;
        #   };
        # };
      };
    };
  };
}
