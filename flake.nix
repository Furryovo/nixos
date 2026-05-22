{
  inputs = {
    # https://github.com/NixOS/nixpkgs/tree/nixos-unstable
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };

      # https://github.com/nix-community/NUR
      NUR = {
      type = "github";
      owner = "nix-community";
      repo = "NUR";
      ref = "main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { self, nixpkgs, NUR, }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        { nix.settings.experimental-features = [ "nix-command" "flakes" ]; }
        NUR.modules.nixos.default       
          ./configuration.nix
      ];
    };
  };
 }

