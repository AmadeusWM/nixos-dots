# How to use

```nix
{
  description = "Your Nixos Configuration"; 

  inputs = {
    # Amadeus' Nixos Dots
    dots.url = "github:AmadeusWM/nixos-dots";

    # or do this if you have the repository locally
    # dots.url = "path:/path/to/nixos-dots";
    
    # Nix Packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home-Manger
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add inputs of your choice (some are required for certain modules, such as Hyprland), e.g: 
    # Anyrun
    anyrun.url = "github:Kirottu/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";

    # Firefox nightly
    firefox.url = "github:nix-community/flake-firefox-nightly";

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hypridle.url = "github:hyprwm/hypridle";
    hyprlock.url = "github:hyprwm/hyprlock";

    # Ags widgets
    ags.url = "github:Aylur/ags";
  };
  
  outputs = {self, nixpkgs, home-manager, dots, ...} @inputs: let 
    inherit (self) outputs; 
  in {
    homeConfigurations = {
      "home-manager" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;}; 
        modules = [
          ./home-manager/home.nix # import your home.nix
          # import modules of choice from the flake
          dots.ags
          dots.anyrun
          dots.common
          dots.gnome
          dots.hyprland.hyprland
          dots.hyprland.keybindsQwerty
          dots.hyprland.monitors
          dots.hyprland.themes.minimalism
          dots.i3.i3
        ];
      };
    };
  };
}
```
