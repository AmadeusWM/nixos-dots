{
  description = "A very basic flake";

  outputs = { self, nixpkgs }: {
    themes = ./themes;
    terminal = ./terminal;
    graphical = ./graphical;
    all = ./default.nix;
  };
}
