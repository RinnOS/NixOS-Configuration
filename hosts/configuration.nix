# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, user, home-manager, ... }:

{
  #imports = [];

  networking.hostName = "RinnOS";
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_US.utf8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.utf8";
    LC_IDENTIFICATION = "sv_SE.utf8";
    LC_MEASUREMENT = "sv_SE.utf8";
    LC_MONETARY = "sv_SE.utf8";
    LC_NAME = "sv_SE.utf8";
    LC_NUMERIC = "sv_SE.utf8";
    LC_PAPER = "sv_SE.utf8";
    LC_TELEPHONE = "sv_SE.utf8";
    LC_TIME = "sv_SE.utf8";
  };
  console.keyMap = "sv-latin1";
  
  services = {
    xserver = {
      libinput.enable = true;
      layout = "se";
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    flatpak.enable = true;

    emacs.enable = true;
    blueman.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  fonts.fonts = with pkgs; [
    source-code-pro
    font-awesome
    corefonts
    noto-fonts-emoji
    (nerdfonts.override {
      fonts = [
        "FiraCode"
      ];
    })
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "docker" ];
    shell = pkgs.zsh;
    password = "password"; # Obviously change password once you're done with the installation.
  };


  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERMINAL = "terminator";
    };

    systemPackages = with pkgs; [
      vim
      wget
      docker
      docker-compose
      killall
      btop
      xterm
      xdotool
      calc
      jdk8
      imwheel
      nodejs
      nodePackages.npm
      yarn
      gnome.gnome-disk-utility
      bluez
      blueman
      xclip
      bat
      aspell
      aspellDicts.en
      aspellDicts.sv
      mono
      yt-dlp
      nitrogen
      picom
      proton-caller
      protontricks
      protonup
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools
    ];
  };
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";

    settings.auto-optimise-store = true;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  system = {
      autoUpgrade = {
        enable = true;
        channel = "https://nixos.org/channels/nixos-22.05";
      };
      stateVersion = "22.05";
  };
}

