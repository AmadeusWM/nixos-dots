{ pkgs, ... }:
{
  # test if language is supported with e.g. `hx --health python`
  home.packages = with pkgs; [
    # cpp dependencies
    clang-tools
    lldb
    # nix dependencies
    nil
    # typescript
    nodePackages_latest.typescript-language-server
    # python
    python311Packages.python-lsp-server
    # java
    vimPlugins.nvim-jdtls
  ];

  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_espresso";
      editor = {
        line-number = "relative";
      };
      keys.normal = {
        y = "yank_joined_to_clipboard";
      };
      keys.insert = {
        "C-right" = "move_next_word_end";
        "C-left" = "move_prev_word_start";
        "C-backspace" = "delete_word_backward";
        "C-del" = "delete_word_forward";
        "C-S-ret" = [ "add_newline_above" "move_line_up" ];
        "C-ret" = [ "add_newline_below" "move_line_down" ];
        "C-s" = ":write";
        "C-z" = "undo";
        "C-S-z" = "redo";
      };
    };
    languages = {
      language = [
        {
          name = "cpp";
        }
        {
          name = "nix";
        }
      ];
    };
    themes = {
      catppuccin_espresso = {
        "inherits" = "catppuccin_mocha";
        "ui.virtual.inlay-hint" = {
          fg = "surface1";
        };
        "ui.background" = "{}";
      };
    };
  };
}