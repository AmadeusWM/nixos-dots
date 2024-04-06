{ pkgs, config, inputs, ... }:
{
  home.packages = with pkgs; [
    inputs.dev-templates-nix.packages.${pkgs.system}.default
    rm-improved
    fzf
  ];
  
  programs.zsh.shellAliases = {
    joepie = "echo 'joepiee!!'";
    la = "exa -la --icons";
    ls = "exa --icons";
    rm = "rip";
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd"
      "cd"
    ];
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # https://nixos.wiki/wiki/Zsh
  programs.zsh = {
    enable = true;
    # autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # # "^[OA" and "^[OB" fix up and down not working... (source: https://www.reddit.com/r/zsh/comments/kae8yg/plugin_zshhistorysubstringsearch_not_working/)
    historySubstringSearch.enable = true;
    historySubstringSearch.searchUpKey = [ "^[[A" "^[OA" ];
    historySubstringSearch.searchDownKey = [ "^[[B" "^[OB" ];
    
    # use `cat -v` for keys
    initExtra = ''
# == Keybinds ==
# ctrl + remove
bindkey '^H' backward-kill-word # ctrl + backspace
bindkey '^[[3;5~' kill-word # ctrl + delete

# ctrl + arrows
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# # == direnv (nix shells) ==
# eval "$(direnv hook zsh)" # load nix shell when in directory with `.envrc` file that contasins `use_nix`
  '';
  };
}

    # don't use this garbage, it makes my zsh lag for some reason
    # oh-my-zsh = {
    #   enable = true;
    #   plugins = [ 
    #     "direnv" # https://direnv.net/docs/hook.html
    #    ];
    # };

    # plugins = [
    #   {
    #     name = "zsh-nix-shell";
    #     file = "nix-shell.plugin.zsh";
    #     src = pkgs.fetchFromGitHub {
    #       owner = "chisui";
    #       repo = "zsh-nix-shell";
    #       rev = "v0.5.0";
    #       sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
    #     };
    #   }
    # ];
# Other ZSH settings
  
    # https://github.com/zplug/zplug
    # zplug = {
    #   enable = true;
    #   plugins = [
    #     { name = "zsh-users/zsh-autosuggestions"; }
    #     { name = "zsh-users/zsh-syntax-highlighting"; }
    #     { name = "zsh-users/zsh-history-substring-search"; }
    #     # { name = "dracula/zsh"; tags = [ as:theme ]; }
    #     # { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
    #   ];
    # };

    # oh-my-zsh = {
    #   enable = true;
    #   plugins = [ "git" ];
    #   # theme = "robbyrussell";
    # };

    # Raw plugins 
    # plugins = [{
    #   name = "zsh-history-substring-search";
    #   file = "zsh-history-substring-search.zsh";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "zsh-users";
    #     repo = "zsh-history-substring-search";
    #     rev = "v1.0.2";
    #     sha256 = "0y8va5kc2ram38hbk2cibkk64ffrabfv1sh4xm7pjspsba9n5p1y";
    #   };
    # }];

    # extra configurations
    # initExtra = ''
    #   bindkey '^[[A' history-substring-search-up
    #   bindkey '^[[B' history-substring-search-down
    # '';

    # zplug = {
    #   enable = true;
    #   plugins = [
    #     { name = "MichaelAquilina/zsh-auto-notify"; }
    #     # { name = "zsh-users/zsh-autosuggestions"; }
    #     # { name = "zsh-users/zsh-syntax-highlighting"; }
    #     # { name = "zsh-users/zsh-history-substring-search"; }
    #     # { name = "dracula/zsh"; tags = [ as:theme ]; }
    #     # { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
    #   ];
    # };

    # fuck this one is already included by default yikes
    # plugins = [{
    #   name = "zsh-auto-notify";
    #   file = "zsh-auto-notify.zsh";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "MichaelAquilina";
    #     repo = "zsh-auto-notify";
    #     rev = "v0.8.1";
    #     # get with nix-prefetch-url https://github.com/MichaelAquilina/zsh-auto-notify
    #     sha256 = "1i9sjkc2y6z5zq0vrq1mnbd57g24clxmshfpr05j7fm5yb469a3q";
    #   };
    # }];
    # initExtra = ''
    #   # MichaelAquilina/zsh-auto-notify configuration
    #   # export AUTO_NOTIFY_THRESHOLD=10 # Notify only if commands take longer than 10 seconds
    # '';
