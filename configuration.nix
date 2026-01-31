{ config, pkgs, ... }: 

{ 
  imports = [./hardware-configuration.nix];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];

  networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };
    
    
    
    services.lact.enable = true;
    system.autoUpgrade.runGarbageCollection = true;
    services.xserver.enable = true;    
    services.displayManager.sddm.enable = true;
    security.polkit.enable = true;

    console.keyMap = "sv-latin1";
    programs.gamemode.enable = true;
    services.pulseaudio.enable = false;
    services.printing.enable = true;
    security.rtkit.enable = true;

    services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true;
};

    fileSystems."/mnt/HDD_4TB" = {
    device = "/dev/disk/by-uuid/a7eaa1d6-8402-4093-91f6-a62e7567d418";
    fsType = "ext4"; # or ntfs, vfat, etc.
    options = [ "nofail" "x-systemd.automount" "x-systemd.idle-timeout=600" ];
  };
     fileSystems."/mnt/m.2_2TB" = {
     device = "/dev/disk/by-uuid/4898eb4e-0a06-482b-9224-4736f35d8138";
     fsType = "btrfs"; # or ntfs, vfat, etc.
     options = [ "nofail" "x-systemd.automount" "x-systemd.idle-timeout=600" ];

  };

     fileSystems."/mnt/m.2_1TB" = {
     device = "/dev/disk/by-uuid/37a32573-ff88-40c6-8940-debee2da7692";
     fsType = "btrfs"; # or ntfs, vfat, etc.
     options = [ "nofail" "x-systemd.automount" "x-systemd.idle-timeout=600" ];

  };

      
     programs.dconf.profiles.user.databases = [
      {
          settings."org/gnome/desktop/interface" = {
           gtk-theme = "Adwaita";
           icon-theme = "Flat-Remix-Red-Dark";
           font-name = "nerd-fonts";
           document-font-name = "nerd-fonts";
          monospace-font-name = "nerd-fonts";
         };
       }
     ];

       hardware.graphics = {
       enable = true;
       extraPackages = with pkgs; [ mangohud ];
       extraPackages32 = with pkgs; [ mangohud ];
       };

        programs.steam = {
        enable = true;
        gamescopeSession.enable = true; # Enables Gamescope for Steam Deck-like experience
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
      };   

          nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem  [
             "steam"
             "steam-original"
             "steam-unwrapped"
             "steam-run"
         ];

         nixpkgs.config.packageOverrides = pkgs: {
         steam = pkgs.steam.override {
         extraPkgs = pkgs: with pkgs; [ mangohud ];
          };
        };   



      users.users.dragonfurryowo = {
    isNormalUser = true;
    description = "DragonfurryOwO";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };
 
    programs.hyprland.enable = true;
    services.hypridle.enable = true;
    services.udisks2.enable = true;
    services.gvfs.enable = true;
    programs.hyprlock.enable = true;
    programs.hyprland.xwayland.enable = true;
    hardware.bluetooth.enable = true;
    hardware.amdgpu.overdrive.enable = true;
    nixpkgs.config.allowUnfree = true;
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
 
  environment.systemPackages = with pkgs; [
    pkgs.qpwgraph
    pkgs.overskride
    pkgs.gnome-disk-utility
    pkgs.floorp-bin
    pkgs.wireguard-tools
    pkgs.hyfetch
    pkgs.fastfetch
    pkgs.kdePackages.ark
    pkgs.kdePackages.kate
    pkgs.kdePackages.kio-admin
    pkgs.kdePackages.dolphin
    pkgs.vesktop
    pkgs.protonplus
    pkgs.btrfs-progs
    pkgs.waybar
    pkgs.wlogout
    pkgs.gamemode
    pkgs.protonvpn-gui
    pkgs.btop
    pkgs.htop
    pkgs.copyq
    pkgs.steam
    pkgs.yazi
    pkgs.wofi
    pkgs.wpa_supplicant
    pkgs.mako
    pkgs.hyprshot
    pkgs.hyprland
    pkgs.linux
    pkgs.swww
    pkgs.heroic
    pkgs.kitty
    pkgs.libnotify
    pkgs.atlauncher
    pkgs.linux
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-hyprland
    pkgs.hyprpolkitagent
    pkgs.xwayland
    pkgs.swaybg
    pkgs.meson
    pkgs.cairo
    pkgs.rubyPackages.gdk_pixbuf2
    pkgs.lact
    pkgs.mesa
    pkgs.pavucontrol
    pkgs.pulseaudioFull
    pkgs.pipewire
    pkgs.openlinkhub
  ];
 }
