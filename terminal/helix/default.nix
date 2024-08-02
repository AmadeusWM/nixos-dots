{ pkgs, inputs, ... }:
{
  # test if language is supported with e.g. `hx --health python`
  home.packages = with pkgs; [
    # github copilot
    inputs.helix-gpt.packages.${pkgs.system}.default
    # cpp dependencies
    clang-tools
    lldb
    # nix dependencies
    nil
    nixd
    # typescript
    nodePackages_latest.typescript
    nodePackages_latest.typescript-language-server
    ## TS Eslint
    vscode-langservers-extracted
    # python
    (python3.withPackages (ps: with ps; [ python-lsp-server ] ++ python-lsp-server.optional-dependencies.all))

    python311Packages.debugpy # debugger
    # markdown
    marksman
    # formatter
    nodePackages.prettier
    # toml
    taplo
    # lua
    lua-language-server
    # Latex
    texlab
    # java
    jdt-language-server
  ];

  programs.helix = {
    enable = true;
    package = inputs.helix.packages.${pkgs.system}.default;
    defaultEditor = true;
    settings = {
      # theme = "catppuccin_espresso";
      editor = {
        line-number = "relative";
        idle-timeout = 0;
        color-modes = true;
        soft-wrap.enable = true;
        true-color = true;
      };
      keys.normal = {
        "C-/" = "toggle_comments";
        "C-S-v" = ":clipboard-paste-after";
        "home" = "goto_first_nonwhitespace";
        "C-right" =    [ "move_next_word_end" ];
        "C-left" =     [ "move_prev_word_start" ];
        "C-up" =       [ "move_line_up" ];
        "C-down" =     [ "move_line_down" ];
      };
      keys.normal.space = {
        "f" = "file_picker_in_current_directory";
        "F" = "file_picker";
      };
      keys.insert = let s = [ "commit_undo_checkpoint" ]; in {
        # selection and movement
        "C-right" =    [ "move_next_word_end" ];
        "C-left" =     [ "move_prev_word_start" ];
        "C-up" =       [ "move_line_up" ];
        "C-down" =     [ "move_line_down" ];
        "C-backspace" =[ "delete_word_backward" ] ++ s;
        "C-del" =      [ "delete_word_forward" ] ++ s;
        "home" =       [ "goto_first_nonwhitespace" ];
        # copy/paste
        "C-S-v" =      [ ":clipboard-paste-after" ] ++ s;
      };
    };
    languages = {
      language-server = {
        ts-server = {
          command = "typescript-language-server";
          args = ["--stdio"];
          language-id = "javascript";
        };
        nixd-server = {
          command = "nixd";
          language-id = "nix";
        };
        gpt = {
          command = "helix-gpt";
        };

        # source: https://github.com/helix-editor/helix/issues/3231#issuecomment-1876996743        
        eslint = {
          args = ["--stdio"]; # should come by def with helix
          command = "vscode-eslint-language-server";
          config = {
            validate = "on"; # I assume this enabled eslit to validate the file, which now shows me counts for errors, warnings, etc in helix
            experimental = { useFlatConfig = false; }; # not sure why this is here
            rulesCustomizations = [];
            run = "onType";
            problems = { shortenToSingleLine = false; };
            nodePath = ""; # seems redundant, why do we need to override this, should get detected autom.
          };
        };
      };
      language = [
        {
          name = "rust";
          language-servers = [
            # "gpt"
            "rust-analyzer"
          ];
          auto-format = false;
        }
        {
          name = "markdown";
          soft-wrap.enable = true;
          formatter = { command = "prettier"; args = ["--parser" "markdown"]; };
        }
        {
          name = "nix";
          language-servers = [ 
            "nil"
            # "gpt"
          ];
        }
        {
          name = "javascript";
          language-servers = [ 
            "ts-server"
          ];
        }
        {
          name = "typescript";
          roots = ["package-lock.json" "tsconfig.json" ".prettierrc.json"];
          language-servers = [ 
            "ts-server"
            "eslint"
          ];
        }
        {
          name = "tsx";
          language-servers = [ 
            "ts-server"
            # "gpt"
          ];
        }
      ] ++
        map (lang: {
            name = lang;
            # language-servers = [
            #   "gpt"
            # ];
          }) [ "java" "cpp"];
    };
    themes = {
      catppuccin_espresso = {
        "inherits" = "catppuccin_mocha";
        "ui.virtual.inlay-hint" = {
          fg = "surface1";
        };
        "ui.background" = "{}"; # use terminal background
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
