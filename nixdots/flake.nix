
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nvf.url = "github:notashelf/nvf";

    oxwm = {
      url = "github:tonybanters/oxwm/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Используем Gerg-L, как указано вами
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "github:outfoxxed/quickshell/0.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };
  };

  outputs =
    inputs@{
      self,
      flake-parts,
      nixpkgs,
      home-manager,
      mango,
      spicetify-nix, # <--- Объявлен здесь
      nvf,
      oxwm,
      noctalia,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      debug = true;
      systems = [ "x86_64-linux" ];

      flake = {
        # Neovim package
        packages."x86_64-linux".default =
          (nvf.lib.neovimConfiguration {
            pkgs = nixpkgs.legacyPackages."x86_64-linux";
            modules = [ ./nvf-configuration.nix ];
          }).neovim;

        # NixOS configuration
        nixosConfigurations.tey = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          # ИСПРАВЛЕНИЕ: Теперь spicetify-nix передается
          specialArgs = { inherit inputs spicetify-nix; }; 
          modules = [
            # System configuration
            ./nixos/configuration.nix

            # NixOS modules
            nvf.nixosModules.default
            home-manager.nixosModules.home-manager
            mango.nixosModules.mango
            oxwm.nixosModules.default
            
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs spicetify-nix; }; # <--- Добавлено для Home Manager
              
              home-manager.users.tey = {
                imports = [
                  # Main home configuration
                  ./home/home.nix

                  # Home Manager modules
                  mango.hmModules.mango
                  spicetify-nix.homeManagerModules.spicetify
                  inputs.noctalia.homeModules.default
                ];
              };
            }
          ];
        };
      };
    };
}
