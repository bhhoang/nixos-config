# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Use the systemd-boot EFI boot loader.
  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager = {
	enable = true;  # Easiest to use and most distros use this by default.
	packages = [
		pkgs.networkmanager-openvpn
	];
	wifi.powersave = true;
  };

  home-manager = {
	useGlobalPkgs = true;
	useUserPackages = true;

	extraSpecialArgs = {inherit inputs; };
	users = {
		"bhhoang" = import ./home.nix;
	};
  };

  programs.zsh.enable = true;

  boot.loader = {
     efi = {
	canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
     };

     grub = {
         efiSupport = true;
         device = "nodev";
         useOSProber = true;
         gfxmodeEfi = "1366x768";
         fontSize = 48;
     };
  
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

   i18n.inputMethod = {
     enabled = "fcitx5";
     fcitx5.waylandFrontend = true;
     fcitx5.addons = with pkgs; [
       fcitx5-gtk             # alternatively, kdePackages.fcitx5-qt
       fcitx5-bamboo  # table input method support
       fcitx5-nord            # a color theme
     ];
   };

  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  services.pipewire = {
     enable = true;
     audio.enable = true;
     pulse.enable = true;
     jack.enable = true;
     alsa = {
	enable = true;
	support32Bit = true;
     };
  };

  services.xserver = {
  	dpi = 227;
	upscaleDefaultCursor = true;
	enable = true;

	displayManager.sessionCommands = ''  
  	${pkgs.xorg.xrdb}/bin/xrdb -merge <<EOF  
  	Xft.dpi: 100  
	EOF  
	'';
  };

  services.gnome.gnome-keyring.enable = true;
  

  services.displayManager.sddm = {
    enable = true; # Enable SDDM.
    sugarCandyNix = {
        enable = true; # This set SDDM's theme to "sddm-sugar-candy-nix".
        settings = {
          # Set your configuration options here.
          # Here is a simple example:
          Background = lib.cleanSource ../../Backgrounds/Mountain.jpg;
          ScreenWidth = 1920;
          ScreenHeight = 1080;
          FormPosition = "left";
          HaveFormBackground = true;
          PartialBlur = true;
        };
      };
    };



  programs.hyprland = {
	enable = true;
	xwayland.enable = true;
  };

  #enviroment.sessionVariables.NIXOS_OZONE_WL="1";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bhhoang = {
     isNormalUser = true;
     shell = pkgs.zsh;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       firefox
       tree
       neovim
       hyprland
       kitty
       waybar
       rofi
       gtk4
       xdg-desktop-portal-hyprland
     ];
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     kitty
     pkgs.gnome.adwaita-icon-theme
     zsh
     wineWowPackages.stable
     sddm
     grim
     slurp
     wl-clipboard
     python3
     jdk17
     libnotify
     openvpn
     rofi-wayland
     #inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
   ];

   fonts = {
   	fontDir.enable = true;
	packages = with pkgs; [
		noto-fonts
		noto-fonts-emoji
		noto-fonts-cjk-sans
		hackgen-nf-font
		font-awesome
		source-han-sans
      		source-han-sans-japanese
      		source-han-serif-japanese
		liberation_ttf
  		fira-code
  		fira-code-symbols
  		mplus-outline-fonts.githubRelease
  		dina-font
  		proggyfonts
	];


   fontconfig.defaultFonts = {
      serif = [ "Noto Serif" "Source Han Serif" ];
      sansSerif = [ "Noto Sans" "Source Han Sans" ];
    };
  };


  security.polkit.enable = true;



   environment.variables = {
   	GDK_SCALE = "2";
    	GDK_DPI_SCALE = "0.5";
	QT_AUTO_SCREEN_SCALE_FACTOR=1;
    	_JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
	XCURSOR_SIZE = "24";
	XDG_CONFIG_HOME = "$HOME/.config";
    	XDG_DATA_HOME   = "$HOME/var/lib";
    	XDG_CACHE_HOME  = "$HOME/var/cache";
   };

   #environment.sessionVariables.NIXOS_OZONE_WL = "1";
   #nixpkgs.config.chromium.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
   

   environment.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";
    NIXPKGS_ALLOW_UNFREE = 1;
   };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}

