{pkgs, ...}:
{
  # xdg.configFile."zathura/catppuccin-mocha".source = pkgs.fetchurl {
  #   url = "https://raw.githubusercontent.com/catppuccin/zathura/main/src/catppuccin-mocha";
  #   hash = "sha256-POxMpm77Pd0qywy/jYzZBXF/uAKHSQ0hwtXD4wl8S2Q=";
  # };
  programs.zathura = {
    enable = true;
    # extraConfig = ''
    #   # include catppuccin-moche
    #   set default-fg                rgba(205,214,244,1)
    #   set default-bg 			          rgba(15,15,23,1)

    #   set completion-bg		          rgba(49,50,68,1)
    #   set completion-fg		          rgba(205,214,244,1)
    #   set completion-highlight-bg	  rgba(87,82,104,1)
    #   set completion-highlight-fg	  rgba(205,214,244,1)
    #   set completion-group-bg		    rgba(49,50,68,1)
    #   set completion-group-fg		    rgba(137,180,250,1)

    #   set statusbar-fg		          rgba(205,214,244,1)
    #   set statusbar-bg		          rgba(49,50,68,1)

    #   set notification-bg		        rgba(49,50,68,1)
    #   set notification-fg		        rgba(205,214,244,1)
    #   set notification-error-bg	    rgba(49,50,68,1)
    #   set notification-error-fg	    rgba(243,139,168,1)
    #   set notification-warning-bg	  rgba(49,50,68,1)
    #   set notification-warning-fg	  rgba(250,227,176,1)

    #   set inputbar-fg			          rgba(205,214,244,1)
    #   set inputbar-bg 		          rgba(49,50,68,1)

    #   set recolor                   "true"
    #   set recolor-lightcolor		    rgba(15,15,23,1)
    #   set recolor-darkcolor		      rgba(205,214,244,1)

    #   set index-fg			            rgba(205,214,244,1)
    #   set index-bg			            rgba(30,30,46,1)
    #   set index-active-fg		        rgba(205,214,244,1)
    #   set index-active-bg		        rgba(49,50,68,1)

    #   set render-loading-bg		      rgba(30,30,46,1)
    #   set render-loading-fg		      rgba(205,214,244,1)

    #   set highlight-color		        rgba(87,82,104,0.5)
    #   set highlight-fg              rgba(245,194,231,0.5)
    #   set highlight-active-color	  rgba(245,194,231,0.5)
    # '';
  };
}
