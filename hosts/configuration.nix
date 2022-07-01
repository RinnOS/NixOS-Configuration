#  
#  
#  flake.nix
#   └─ ./hosts
#       ├─ default.nix
#       └─ configuration.nix  *
#

{ config, pkgs, user, home-manager, ... }:

{
  #imports = [];

  networking.hostName = "Tera"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
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

  services = {
    xserver = {
      libinput = {
        enable = true;
      };

      layout = "se";
#      xlnVariant = "";
    };
    
    #openssh = {
    #  enable = true;
    #  allowSFTP = true;
    #};

    flatpak.enable = true;

    emacs.enable = true;
    blueman.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  fonts.fonts = with pkgs; [
    source-code-pro
    font-awesome
    corefonts
    (nerdfonts.override {
      fonts = [
        "FiraCode"
      ];
    })
  ];
 
  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "docker" ];
    shell = pkgs.zsh;
  };

  environment = {
    variables = {
      EDITOR = "nvim";
      TERMINAL = "terminator";
      VISUAL = "nvim";
    };
    
    systemPackages = with pkgs; [
      vim
      wget
      docker
      docker-compose
      git
      killall
      xterm
      calc
      flameshot
      jdk8
      imwheel
      nodejs
      nodePackages.npm
      yarn
#     noto-fonts
      noto-fonts-emoji
      gnome.gnome-disk-utility
      bluez
      blueman
      xclip
      bat
#     fira-code
      aspell
      aspellDicts.en
      aspellDicts.sv
      mono
      yt-dlp
#     zsh
    ];
  };

  programs.zsh = {
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "bira";
    };

    shellAliases = {
      ls = "ls --color=auto";
      ll = "ls -lav --ignore=..";
      l = "ls -lav --ignore=.?*";
      la = "ls -A";
      
#     .. = "cd ..";
      
      mv = "mv -i";
      rm = "rm -i";
      
      nv = "nvim";
    };
  };

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
