{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
    oxwm.url = "github:tonybanters/oxwm";
    oxwm.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      flake-parts,
      nixpkgs,
      home-manager,
      mango,
      nvf,
      oxwm,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      debug = true;
      systems = [ "x86_64-linux" ];

      flake = {
        packages."x86_64-linux".default =
          (nvf.lib.neovimConfiguration {
            pkgs = nixpkgs.legacyPackages."x86_64-linux";
            modules = [ ./nvf-configuration.nix ];
          }).neovim;

        nixosConfigurations.tey = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./nixos/configuration.nix
            nvf.nixosModules.default
            home-manager.nixosModules.home-manager
            mango.nixosModules.mango
            oxwm.nixosModules.default
            { programs.mango.enable = true; }
            {
              home-manager.users.tey = {
                imports = [
                  ./home/home.nix
                  mango.hmModules.mango
                  (
                    { ... }:
                    {
                      wayland.windowManager.mango = {
                        enable = true;
                        settings = ''
                          ;
                                                autostart_sh = '';
                      };
                    }
                  )
                ];

              };
            }
          ];
        };
      };
    };
}
