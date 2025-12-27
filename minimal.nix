# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ pkgs,lib,   ... }:
{

  environment = {
		variables = {
		ANDROID_HOME="/home/cozy/Android/Sdk";
		PATH="/home/cozy/.cargo/bin:/home/cozy/.local/bin:/home/cozy/.deno/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH";
    GSETTINGS_SCHEMA_DIR="${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas";
	  #LD_LIBRARY_PATH = lib.mkForce"$NIX_LD_LIBRARY_PATH:$LD_LIBRARY_PATH";	
		XDG_RUNTIME_DIR = "/run/user/$UID";
		NIXOS_OZONE_WL="1";

    };

  systemPackages = with pkgs; [
		
    dmidecode
    lshw
    tmux
		patchelf
		bc
		rocmPackages.rocminfo
		powertop
		php
		go
		pnpm
		wvkbd
		rot8
		fd
		lf
		nixd
		nnn
		yt-dlp
		cava
		fastfetch
		nmap
		imv
		btop
		niv
		fzf
		lua
		ripgrep
		iw
		unar
		vulkan-tools
    mesa-demos
		p7zip
		mangohud
		nix-index
		killall
		zip
		unzip
		deno
		wtype
		wget
		file
		pamixer
		wl-clipboard
		libwebp
		ncdu
		clinfo
		gcc
    typescript
  ];

    interactiveShellInit = ''
	PS1="\[$(tput setaf 7)\]\u@\h \W> \[$(tput sgr0)\]"

	l () {
	    # `command` is needed in case `lfcd` is aliased to `lf`
	    cd "$(command lf -print-last-dir "$@")"
	}

	n ()
	{
	    [ "''${NNNLVL:-0}" -eq 0 ] || {
		echo "nnn is already running"
		return
	    }

	    export NNN_TMPFILE="''${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"


	    command nnn "$@"

	    [ ! -f "$NNN_TMPFILE" ] || {
		. "$NNN_TMPFILE"
		rm -f "$NNN_TMPFILE" > /dev/null
	    }
}
	
		
    '';

  };

  nixpkgs.config.allowUnfree = true; 
	nixpkgs.config.allowUnsupportedSystem = true;




  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
	networking = {
  	firewall.enable = false;
    #interfaces.wlan0.mtu = 1450;
    #nameservers = [ "2001:4860:4860::8888" "2001:4860:4860::8844" "8.8.8.8" "8.8.4.4" ];
		#dhcpcd.enable = false;
    networkmanager = {
      enable = true;
      insertNameservers = [ "8.8.8.8" "8.8.4.4" "2001:4860:4860::8888" "2001:4860:4860::8844" ];
      #insertNameservers = [ "1.1.1.1" "1.0.0.1" ];
      wifi = { 
        backend = "iwd";
        powersave = false;
      };

    };
  };
  # Set your time zone.
  time = {
    timeZone = "Asia/Kuala_Lumpur";
    hardwareClockInLocalTime = true;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
    #useXkbConfig = true; # use xkbOptions in tty.
  };




  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam.loginLimits = [
      {domain = "*";type = "-";item = "memlock";value = "infinity";}
      {domain = "*";type = "-";item = "nofile";value = "1048576";}
    ];
  };

	#powerManagement = {
	#	enable = true;
	#	#powertop.enable = true;
	#	cpuFreqGovernor = "powersave";
	#};


  services = {
    envfs.enable = true;
    upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 15;
      percentageAction = 10;
      timeAction = 0;
      criticalPowerAction = "Suspend";
			allowRiskyCriticalPowerAction = true;
    };
    logind.settings.Login = {
			HandleLidSwitch="ignore";
			HandleLidSwitchExternalPower="ignore";
			HandleSuspendKey="suspend";
			HandlePowerKey="suspend";
    };



	};


  programs = {
  
    git = {
      enable = true;
      package = pkgs.gitFull;

    };
    dconf.enable = true;
    nix-ld = {
			enable = true;
			libraries = with pkgs; [
				#stdenv.cc.cc.lib
				#stdenv.cc.cc
        hwloc
        libuv
        openssl
				pkg-config
				gcc
				gnumake
				glibc
				glib
				xorg.libXtst
    		xorg.libXxf86vm
				xorg.libX11
				xorg.libXcursor
				xorg.libXrandr
				xorg.libXinerama
				xorg.libXext
				xorg.libXrender
				xorg.libXi
				xorg.libxcb
				libxkbcommon
				wayland
				mesa
				gtk3
				alsa-lib
				libpulseaudio
				zlib
				dbus
				libGL
				vulkan-loader
				vulkan-tools
				fontconfig
				libdecor
				speechd
				

			];
		};

      neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
	#configure = {
	#	customRC = ''
	#	set number
	#	set tabstop=2 
	#	set shiftwidth=2 
	#	set noswapfile
	#	set clipboard+=unnamedplus
	#	'';

	#};


      };


    
  };


  system.stateVersion = "25.05"; # Did you read the comment?
  nix.settings.experimental-features = [ "nix-command" "flakes"];
	#nix.package = pkgs.lix;

  users.extraGroups.vboxusers.members = [ "cozy" ];
  users.users.cozy = {
    isNormalUser = true;
    extraGroups = [ "podman" "wheel" "adbusers" "kvm" "wireshark" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [];
  };

  home-manager.users.cozy = {
    home = { 
      stateVersion = "25.11";
  	};
	};


}


