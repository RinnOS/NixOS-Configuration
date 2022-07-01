#  
#  
#  flake.nix
#   └─ ./hosts
#       ├─ default.nix
#       └─ ./Tera
#           └─ ./home.nix   *
#

{ config, lib, pkgs, user, ...  }:

{

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      lutris
      freetube
      polymc
    ];
  };

  home.stateVersion = "22.05";
}
