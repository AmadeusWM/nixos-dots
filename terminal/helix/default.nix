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
    nodePackages_latest.typescript
    nodePackages_latest.typescript-language-server
    # python
    python311Packages.python-lsp-server
    nodePackages_latest.pyright
    python311Packages.debugpy # debugger
    black # formatter
    # java
    # jdt-language-server # outdated
    # markdown
    marksman
    # formatter
    nodePackages.prettier
  ];

  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_espresso";
      editor = {
        line-number = "relative";
      };
      keys.normal = {
        "C-/" = "toggle_comments";
        "C-C" = "yank_joined_to_clipboard";
        "C-S-v" = ":clipboard-paste-after";
      };
      keys.insert = let s = [ "commit_undo_checkpoint" ]; in {
        # selection and movement
        "C-right" =    [ "move_next_word_end" ];
        "C-left" =     [ "move_prev_word_start" ];
        "C-up" =       [ "move_line_up" ];
        "C-down" =     [ "move_line_down" ];
        "C-backspace" =[ "delete_word_backward" ] ++ s;
        "C-del" =      [ "delete_word_forward" ] ++ s;
        # new lines
        "C-S-ret" =    [ "add_newline_above" "move_line_up" ] ++ s;
        "C-ret" =      [ "add_newline_below" "move_line_down" ] ++ s;
        "S-ret" =      [ "goto_definition" ];
        # tabbing
        "C-[" =        [ "unindent" ] ++ s;
        "C-]" =        [ "indent" ] ++ s;
        # state manipulation
        "C-s" =        [ ":write" ] ++ s;
        "C-z" =        [ "undo" ];
        "C-Z" =      [ "redo" ];
        # multiple cursors
        "C-S-up" =     [ "copy_selection_on_prev_line" ];
        "C-S-down" =   [ "copy_selection_on_next_line" ];
        "C-," =        [ "keep_primary_selection" ];
        "C-/" =        [ "toggle_comments" ] ++ s;
        # copy/paste
        "C-S-v" =      [ ":clipboard-paste-after" ] ++ s;
      };
    };
    languages = {
      language-servers = [
          {
              name = "javascript-langserver";
              command = "typescript-language-server";
              args = ["--stdio"];
              language-id = "javascript";
          }
      ];
      language = [
        {
          name = "java";
        }
        {
          name = "markdown";
          soft-wrap.enable = true;
          formatter = { command = "prettier"; args = ["--parser" "markdown"]; };
          auto-format = true;
        }
        {
          name = "cpp";
        }
        {
          name = "javascript";
          language-servers = [ "typescript-language-server" ];
        }
        {
          name = "nix";
        }
        {
          name = "python"; 
          auto-format = true;
          scope = "source.python";
          shebangs = ["python"];
          roots = ["setup.py" "setup.cfg" "pyproject.toml"];
          formatter = { command = "black"; args = ["--quiet" "-"]; };
          language-servers = [ "pyright" ];
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

#  _____________ 
# < wsup brotha >
#  ------------- 
#         \   ^__^
#          \  (--)\_______
#             (__)\       )\/\
#                 ||----w |
#                 ||     ||
