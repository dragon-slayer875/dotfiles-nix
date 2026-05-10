{
  description = "Main computer config flake";

  inputs = {
    # NixOS official package source, using the nixos-25.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        main-comp =
          let
            username = "rudraksht";
          in
          nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; };
            modules = [
              ./configuration.nix

              # make home-manager as a module of nixos
              # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`

              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = {
                  inherit inputs;
                  inherit username;
                };
                home-manager.users.${username} = import ./home.nix;
              }
            ];
          };

        # home-server =
        #         let
        #           username = "rudraksht";
        #         in
        #         nixpkgs.lib.nixosSystem {
        #           specialArgs = { inherit inputs; };
        #           modules = [
        #             ./configuration.nix
        #
        #             # make home-manager as a module of nixos
        #             # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
        #
        #             home-manager.nixosModules.home-manager
        #             {
        #               home-manager.useGlobalPkgs = true;
        #               home-manager.useUserPackages = true;
        #               home-manager.extraSpecialArgs = {
        #                 inherit inputs;
        #                 inherit username;
        #               };
        #               home-manager.users.${username} = import ./home.nix;
        #             }
        #           ];
        #         };
      };
    };
}
