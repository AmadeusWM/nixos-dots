{ pkgs, config, lib, ... }:
let
  chromePath = "${config.home.homeDirectory}/nixos-dotfiles/home/dots/graphical/apps/firefox/chrome";
in
{
  # Example config source: https://discourse.nixos.org/t/help-setting-up-firefox-with-home-manager/23333
  programs.firefox = {
    enable = true;
    
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
          "browser.startup.homepage" = "${config.home.homeDirectory}/nixos-dotfiles/home/dots/graphical/apps/firefox/startpage/index.html";
        };
        extraConfig = ''
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          user_pref("svg.context-properties.content.enabled", true);
        '';
        userChrome = ''
          @import "${chromePath}/config.css";
          @import "${chromePath}/variables.css";
          @import "${chromePath}/icons/icons.css";
          @import "${chromePath}/urlbar/urlbar.css";
          @import "${chromePath}/navbar/navbar.css";
          @import "${chromePath}/popup/popup.css";
          @import "${chromePath}/interface/interface.css";
          @import "${chromePath}/userChrome-tabline.css";
          @import "${chromePath}/content/inner-rounded.css";
        '';
      };
    };
  };
}