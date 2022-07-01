#  
#  
#  flake.nix
#   └─ ./hosts
#       ├─ default.nix  *
#       └─ ./Tera
#

{ lib, inputs, system, home-manager, user, ... }:

{
  Tera = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user inputs; };
    modules = [
      ./Tera
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./Tera/home.nix)];
        };
      }
    ];
  };
}
