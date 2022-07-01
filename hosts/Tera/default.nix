#  
#  
#  flake.nix
#   └─ ./hosts
#       ├─ default.nix
#       ├─ ...
#       └─ ./Tera
#           ├─ ./default.nix   *
#           └─ ...
#

{ config, pkgs, user, ... }:

{
  imports = 
    [(import ./hardware-configuration.nix)];

  boot = {
    loader = {
      timeout = 4;   
   
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };

      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 5;
      };
    };
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];

    displayManager = {
      sddm.enable = true;
#      defaultSession = "none+i3";  # desktopManager+windowManager
#      sessionCommands = ''
#        !/bin/sh
#        ${pkgs.xorg.xrandr}
#     '';
    };

    desktopManager.plasma5.enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };

    serverFlagsSection = ''
      Option "BlankTime" "0"
      Option "StandbyTime" "0"
      Option "SuspendTime" "0"
      Option "OffTime" "0"
    '';

    #resolutions = [{ x = 1920; y = 1080; }];
  };

  hardware.nvidia.prime = {
    sync.enable = true;
    nvidiaBusId = "PCI:1:0:0";
    intelBusId = "PCI:0:2:0";
  };
  
  environment = {
    systemPackages = with pkgs; [
      steam
      protonvpn-gui
    ];
  };

  programs = {
    steam.enable = true;
    gamemode.enable = true;
    # Steam: Right-click game - Properties - Launch options: gamemoderun %command%
    # Lutris: General Preferences - Enable Feral GameMode
    #                             - Global options - Add Environment Variables: LD_PRELOAD=/nix/store/*-gamemode-*-lib/lib/libgamemodeauto.so
  };

  nixpkgs.overlays = [
    (self: super: {
      discord = super.discord.overrideAttrs (
        _: { src = builtins.fetchTarball {
          url = "https://discord.com/api/download?platform=linus&format=tar.gz";
          sha256 = "1bhjalv1c0yxqdra4gr22r31wirykhng0zglaasrxc41n0sjwx0m";
        }; }
      );
    })
  ];
}
