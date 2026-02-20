{
  inputs = {
    # https://github.com/NixOS/nixpkgs/tree/nixos-unstable
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };


    # https://github.com/Gerg-L/spicetify-nix
    spicetify-nix = {
      type = "github";
      owner = "Gerg-l";
      repo = "spicetify-nix";
      ref = "master";
    };


    # https://github.com/kamack38/sddm-greenleaf
    sddm-greenleaf = {
      type = "github";
      owner = "kamack38";
      repo = "sddm-greenleaf";
      ref = "main";
      flake = false;
    };
   };


  outputs = { self, nixpkgs, sddm-greenleaf, spicetify-nix }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        { nix.settings.experimental-features = [ "nix-command" "flakes" ]; }
        ./configuration.nix
      ];
    };
  };
 }


