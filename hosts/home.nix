#  
#  
#  flake.nix
#   └─ ./hosts
#       ├─ default.nix
#       └─ home.nix   *
#

{ config, lib, pkgs, user, ...  }:

{
  imports = 
    (import ../modules/services);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      # Terminal
      btop
      ranger
      terminator
      ani-cli
      betterdiscordctl
      thefuck
      
      # Audio/Video
      feh
      mpv
      vlc

      # Dependencies
      ripgrep

      # Apps
      firefox
      discord
      pcmanfm
      signal-desktop
      popsicle
      arandr
      obsidian
      vscode
      emacs
      libreoffice

      # File Management
      unzip
      unrar
    ];
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    home-manager.enable = true;
  };

  xsession = {
    enable = true;
    numlock.enable = true;

    pointerCursor = {
      name = "Dracula-cursors";
      package = pkgs.dracula-theme;
      size = 16;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "FiraCode Nerd Font Mono Medium";
    };
  };

  #home.file.".config/wallpapers".source = config.lib.file.mkOutOfStoreSymlink ../modules/themes/wallpapers;

  home.stateVersion = "22.05";
}
