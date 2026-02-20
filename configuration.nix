{ config, pkgs, ... }: {

  imports = [
        #spicetify-nix.nixosModules.spicetify
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_testing;
  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];

  networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  hardware.amdgpu.opencl.enable = true;
  hardware.amdgpu.initrd.enable = true;
  #spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};

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

    services.xserver.videoDrivers = ["amdgpu"];
    services.actkbd.enable = true;
    services.lact.enable = true;
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    security.polkit.enable = true;
    services.flatpak.enable = true;


    console.keyMap = "sv-latin1";
    programs.gamemode.enable = true;
    services.pulseaudio.enable = false;
    services.printing.enable = true;
    security.rtkit.enable = true;

    services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true;
  };

      fileSystems."/mnt/HDD_4TB" = {
          device = "/dev/disk/by-uuid/a7eaa1d6-8402-4093-91f6-a62e7567d418";
          fsType = "ext4";
          options = [ "nofail" "x-systemd.automount" "x-systemd.idle-timeout=600" ];
        };

      fileSystems."/mnt/m.2_2TB" = {
          device = "/dev/disk/by-uuid/4898eb4e-0a06-482b-9224-4736f35d8138";
          fsType = "btrfs";
          options = [ "nofail" "x-systemd.automount" "x-systemd.idle-timeout=600" ];
        };

      fileSystems."/mnt/m.2_1TB" = {
          device = "/dev/disk/by-uuid/37a32573-ff88-40c6-8940-debee2da7692";
          fsType = "btrfs";
          options = [ "nofail" "x-systemd.automount" "x-systemd.idle-timeout=600" ];
        };


       programs.dconf.profiles.user.databases = [
         {
          settings."org/gnome/desktop/interface" = {
            gtk-theme = "nerdfonts";
            icon-theme = "nerdfonts";
            font-name = "nerdfonts";
            document-font-name = "nerdfonts";
            monospace-font-name = "nerdfonts";
           };
          }
       ];

       hardware.graphics = {
       enable = true;
       enable32Bit = true;
       extraPackages = with pkgs; [ mangohud ];
       extraPackages32 = with pkgs; [ mangohud ];
       };

    #programs.spicetify-nix = {
    # enable = false;
     #enabledExtensions = with spicePkgs.extensions; [
     #  adblockify
     #  hidePodcasts
     #  shuffle # shuffle+ (special characters are sanitized out of extension names)
     #];
    #};

        programs.steam = {
        enable = true;
        gamescopeSession.enable = true; # Enables Gamescope for Steam Deck-like experience
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
      };

       programs.git = {
        enable = true;
        settings = {
          user = {
          name  = "Furryovo";
          email = "krantzextra@proton.me";
        };
        init.defaultBranch = "master";
      };
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
        };

       fonts.packages = with pkgs; [
       pkgs.nerdfetch
       pkgs.fira-sans
       pkgs.fira-code
       pkgs.roboto
       pkgs.font-awesome
     ];


  #   programs.nix-ld = {
  #     enable = true;
  #     libraries = with pkgs; [
  #        webkitgtk_4_1
  #        gst_all_1.gstreamer
  #        gst_all_1.gst-plugins-base
  #        gst_all_1.gst-plugins-good
  #        gst_all_1.gst-plugins-bad
  #        gst_all_1.gst-plugins-ugly
  #        gst_all_1.gst-libav
  #        fuse
  #        vulkan-loader
  #        libxkbcommon
  #        wayland
  #        gtk3
  #        glib
  #        gdk-pixbuf
  #        openssl
  #        libsoup_3
  #        freetype
  #  ];
  #};


    programs.fish.enable = true;
    fonts.fontconfig.enable = true;
    programs.hyprland.enable = true;
    services.hypridle.enable = true;
    programs.hyprlock.enable = true;
    programs.hyprland.xwayland.enable = true;
    services.udisks2.enable = true;
    services.gvfs.enable = true;
    hardware.bluetooth.enable = true;
    hardware.amdgpu.overdrive.enable = true;
    nixpkgs.config.allowUnfree = true;
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    pkgs.qpwgraph
    pkgs.pika-backup
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
    pkgs.copyq
    pkgs.steam
    pkgs.yazi
    pkgs.wofi
    pkgs.wpa_supplicant
    pkgs.mako
    pkgs.hyprland
    pkgs.linux
    pkgs.swww
    pkgs.heroic
    pkgs.kitty
    pkgs.libnotify
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-hyprland
    pkgs.hyprpolkitagent
    pkgs.xwayland
    pkgs.swaybg
    pkgs.meson
    pkgs.cairo
    pkgs.lact
    pkgs.mesa
    pkgs.playerctl
    pkgs.pavucontrol
    pkgs.pulseaudioFull
    pkgs.pipewire
    pkgs.openlinkhub
    pkgs.prismlauncher
    pkgs.grim
    pkgs.slurp
    pkgs.satty
    pkgs.wl-clipboard
    pkgs.wob
    pkgs.eza
    pkgs.bat
    pkgs.fishPlugins.done
    pkgs.obs-studio
    pkgs.mangohud
    pkgs.jdk
    pkgs.btop-rocm
    pkgs.webkitgtk_4_1
    pkgs.gst_all_1.gst-plugins-good
    #pkgs.spotify
    pkgs.impala
    pkgs.iwd
    pkgs.thunar
    pkgs.rPackages.edge
    pkgs.neovim
    #pkgs.spicetify-nix

  ];
}
