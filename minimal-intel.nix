# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ pkgs,lib,   ... }:
let
  	stable = import <nixos-stable> {config = { allowUnfree = true;};}; 
in
{




  environment = {
		variables = {
		BEMENU_OPTS="-b -p '>' --fn 16 --bdr '#FFFFFF' --ab '#000000' --af '#666666' --nb '#000000' --nf '#666666' --tb '#000000' --tf '#FFFFFF' --fb '#000000' --ff '#FFFFFF' --hb '#000000' --hf '#FFFFFF'";
		ANDROID_HOME="/home/cozy/Android/Sdk";
		PATH="/home/cozy/.cargo/bin:/home/cozy/.local/bin:/home/cozy/.deno/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH";
    GSETTINGS_SCHEMA_DIR="${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas";
	  #LD_LIBRARY_PATH = lib.mkForce"$NIX_LD_LIBRARY_PATH:$LD_LIBRARY_PATH";	
		XDG_RUNTIME_DIR = "/run/user/$UID";
		NIXOS_OZONE_WL="1";

    };

  systemPackages = with pkgs; [
		
    monero-cli
    tmux
    p2pool
    xmrig
    dunst
    vscode-langservers-extracted
    typescript-language-server
    basedpyright
    bash-language-server
    nixd
    rust-analyzer
		protonvpn-gui
		podman-compose
		sbt-with-scala-native
		gtk3
		auto-cpufreq
    ags
		wl-clicker
		patchelf
		bc
		rocmPackages.rocminfo
		git-credential-manager
		conda
		ngrok
		kdePackages.filelight
    solana-cli
		swww
		pywal
		matugen
		pcmanfm
		#new-bottles
		pavucontrol
		sbctl
		#wpsoffice
		powertop
		wf-recorder
		selectdefaultapplication
		tradingview
		gitkraken
		php
		go
		pnpm
		wvkbd
		rot8
		fd
		postman
		yarn
		swaybg
		adwaita-icon-theme
		lf
		networkmanagerapplet
		shared-mime-info
		grimblast
		rofi
		rofimoji
		qbittorrent
		nixd
		nnn
		krita
		gimp3-with-plugins
		#bitwig-studio
		mpv
		yt-dlp
		cava
		fastfetch
		#libreoffice-fresh
		zoxide
		wineWowPackages.waylandFull
		#wineWowPackages.stagingFull
		nmap
		pulsemixer
		telegram-desktop
		imv
		#feh
		#sxiv
		nvtopPackages.intel
		btop
		helvum
		#aseprite
		gparted
		bluetuith
		vscode-fhs
		niv
		fzf
		xorg.xeyes
		wayland-utils
		libnotify
		lua
		xorg.xev
		xorg.xhost
		ripgrep
		rustup
		appimage-run
		iw
		waypipe
		unar
		vulkan-tools
		glxinfo
		bluez-tools
		p7zip
		winetricks
		mangohud
		ffmpeg_6-full
		nix-index
		distrobox
		killall
		zip
		unzip
		#lmms
		deno
		wtype
		wget
		file
		pamixer
		nodejs_20
		bemenu
		bemoji
		wl-clipboard
		libwebp
		imagemagickBig
		ncdu
		clinfo
		gcc
    typescript
		python312
		#(python311.withPackages(ps: with ps; [torch torchvision setuptools srt openai-whisper]))
		python313Packages.gpustat
		#python313Packages.pyautogui
		#python313Packages.pip
		mangohud
		#(catppuccin-sddm.override {
		#	flavor = "mocha";
		#	font  = "Noto Sans";
		#	#fontSize = "20";
		#	background = "${/home/cozy/wallpapers/energy.png}";
		#	loginBackground = true;
  	#})
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
	#plasma6.excludePackages = with pkgs.kdePackages; [
		#konsole
	#];

  };
	xdg.mime = {
		enable = true;
		defaultApplications = {
			"inode/directory" = "pcmanfm.desktop";
		};
	};

  nixpkgs.config.allowUnfree = true; 
	nixpkgs.config.allowUnsupportedSystem = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-29.4.6"
		"ventoy-gtk3-1.1.05"
	];

  virtualisation = {
    #waydroid.enable = true;
		kvmgt.enable = true;
		spiceUSBRedirection.enable = true;
      #libvirtd.enable = true;
      #virtualbox = {
			#	host.enable = true;
			#	host.enableExtensionPack = true;
			#	host.enableKvm = true;
				#host.enableHardening = false;
			#	host.addNetworkInterface = false;
			#	guest = {
			#		enable = true;
			#		dragAndDrop = true;
					#vboxsf = true;
			#	};
      #};
      #vmware = {
      #  host.enable = true;
        #guest.enable = true;
      #};
    podman = { 
			enable = true;
			dockerCompat = true;
			defaultNetwork.settings.dns_enabled = true;
			dockerSocket.enable = true;
  	};
      #docker.enable = true;
	};



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
		soteria.enable = true;
    polkit.enable = true;
    rtkit.enable = true;
    pam.loginLimits = [
      {domain = "*";type = "-";item = "memlock";value = "infinity";}
      {domain = "*";type = "-";item = "nofile";value = "1048576";}
    ];
  };

  zramSwap.enable = true;
    swapDevices = [{
    device = "/swapfile";
    size = 4 * 1024; # 16GB
  }];
	#powerManagement = {
	#	enable = true;
	#	#powertop.enable = true;
	#	cpuFreqGovernor = "powersave";
	#};


  services = {

		
		#desktopManager.plasma6.enable = true;
		devmon.enable = true;
		gvfs.enable = true;
		udisks2.enable = true;
		#blueman.enable = true;
		gnome.gnome-keyring.enable = true;
		#dbus.implementation = "broker";
    envfs.enable = true;
    #onedrive.enable = true;
		openssh = {
			enable = true;
			ports = [ 6969 ];
			settings = {
				PasswordAuthentication = true;
				#AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
				#UseDns = true;
				#X11Forwarding = false;
				PermitRootLogin = "prohibit-password";
			};

		};
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

    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };


	};


  programs = {
	seahorse.enable = true;
	git = {
		enable = true;
		package = pkgs.gitFull;

	};
	#uwsm = {
	#enable = true;
	#	waylandCompositors = {
	#		hyprland = {
	#		prettyName = "Hyprland";
	#		comment = "Hyprland compositor managed by UWSM";
	#		binPath = "/run/current-system/sw/bin/Hyprland";
	#		};
	#	};
	#};
	dconf.enable = true;
	#ssh.startAgent = true;
		foot = {
			enable = true;
			settings = {
			scrollback = {
				lines=10000;
			};
				main = {
					font = "monospace:size=12";

				};
				colors = {

					alpha=0.9;
					background="000000";
					foreground="ffffff";
					regular0="444444";
					regular1="AA0000";
					regular2="00AA00";
					regular3="AAAA00";
					regular4="0000AA";
					regular5="AA00AA";
					regular6="00AAAA";
					regular7="AAAAAA";
					bright0="000000";  
					bright1="DD0000";  
					bright2="00DD00";  
					bright3="DDDD00";  
					bright4="0000DD";  
					bright5="DD00DD";  
					bright6="00DDDD";  
					bright7="DDDDDD";  
					

				};
				key-bindings = {

					scrollback-up-page="Mod1+Shift+k";
					scrollback-up-line="Mod1+k";
					scrollback-down-page="Mod1+Shift+j";
					scrollback-down-line="Mod1+j";
				};

			};
		};
    virt-manager.enable = true;
    firefox.enable = true;
    #openvpn3.enable = true;
    adb.enable = true;
		nm-applet.enable = true;
    nix-ld = {
			enable = true;
			libraries = with pkgs; [
				#stdenv.cc.cc.lib
				#stdenv.cc.cc
				pkg-config
				openjfx24
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

    java = {
      enable = true;
			#package = 
    };

    
  };


	#qt = {
	#	enable = true;
	#	platformTheme = "gtk3";
	#	style = "adwaita-dark";
	#};
  


  system.stateVersion = "25.05"; # Did you read the comment?
  nix.settings.experimental-features = [ "nix-command" "flakes"];
	#nix.package = pkgs.lix;

  users.extraGroups.vboxusers.members = [ "cozy" ];
  users.users.cozy = {
    isNormalUser = true;
    extraGroups = [ "podman" "wheel" "adbusers" "kvm" "wireshark" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [];
  };


}


