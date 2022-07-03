{ config, lib, pkgs, user, ... }:

{
  imports =
    (import ../modules/services) ++
    (import ../modules/shell);

  home = {
    stateVersion = "22.05";

    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      # Terminal
      git
      ranger
      terminator
      ani-cli
      betterdiscordctl
      thefuck

      # Audio/Video
      feh
      mpv
      vlc

      #Dependencies
      ripgrep
      coreutils
      fd

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
      appimage-run

      # File Management
      unzip
      unrar
    ];

    pointerCursor = {
      name = "Dracula-cursors";
      package = pkgs.dracula-theme;
      size = 16;
    };

    file.".config/wallpapers".source = config.lib.file.mkOutOfStoreSymlink ../modules/themes/wallpapers;
  };

  programs = {
    home-manager.enable = true;
  };

  xsession = {
    enable = true;
    numlock.enable = true;
  };

  #gtk = {
  #  enable = true;
  #  theme = {
  #   name = "Dracula";
  #    package = pkgs.dracula-theme;
  #  };
  #
  #  iconTheme = {
  #    name = "Papirus-Dark";
  #    package = pkgs.papirus-icon-theme;
  #  };
  #
  #  font = {
  #    name = "FiraCode Nerd Font Mono Medium";
  #  };
  #};
}
