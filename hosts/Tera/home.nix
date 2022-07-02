 
{ config, lib, pkgs, user, ... }:

{
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      lutris
      freetube
      polymc
      rambox-pro
    ];

    stateVersion = "22.05";
  };
}
