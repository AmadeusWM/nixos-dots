{ pkgs, config, ... }:
{
  programs.starship = {
    enable = true;
    # enableZshIntegration = true;

    settings = {
      add_newline = false;
      scan_timeout = 3;

      character = {
        error_symbol = "[❯](bold red)";
        success_symbol = "[❯](bold green)";
        vicmd_symbol = "[](bold yellow)";
        format = "$symbol(bold bright-black) ";
      };

      git_commit = {commit_hash_length = 5;};
      line_break.disabled = true;

      lua.symbol = "[](blue) ";
      python.symbol = "[](blue) ";
      nix_shell.symbol = "[](blue) ";
      rust.symbol = "[](red) ";
      package.symbol = "📦  ";

      hostname = {
        ssh_only = true;
        format = "@[$hostname](bold blue) ";
        disabled = false;
      };
    };
  };
}