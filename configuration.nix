# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ pkgs,lib,   ... }:
let
  	stable = import <nixos-stable> {config = { allowUnfree = true;};}; 
		#sources = import /home/cozy/nix/sources.nix;
		#lanzaboote = import sources.lanzaboote;
in
{
	#nixpkgs.overlays = [
	#	(final: prev: {
	#		vlc = prev.vlc.override {
	#			waylandSupport = true;
	#		};
	#	})
#
#	];





  environment = {
		variables = {
		BEMENU_OPTS="-b -p '>' --fn 16 --bdr '#FFFFFF' --ab '#000000' --af '#666666' --nb '#000000' --nf '#666666' --tb '#000000' --tf '#FFFFFF' --fb '#000000' --ff '#FFFFFF' --hb '#000000' --hf '#FFFFFF'";
		ANDROID_HOME="/home/cozy/Android/Sdk";
		PATH="/home/cozy/.cargo/bin:/home/cozy/.local/bin:/home/cozy/.deno/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH";
    GSETTINGS_SCHEMA_DIR="${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas";
	  #LD_LIBRARY_PATH = lib.mkForce"$NIX_LD_LIBRARY_PATH:$LD_LIBRARY_PATH";	
		XDG_RUNTIME_DIR = "/run/user/$UID";
		NIXOS_OZONE_WL="1";
		#AMD_VULKAN_ICD = "RADV";
		#PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.hidapi}/lib/pkgconfig";
		#XDG_SESSION_TYPE="wayland";
		#XDG_CURRENT_DESKTOP="Hyprland";
		#MOZ_ENABLE_WAYLAND="1";
		#MOZ_WEBRENDERER="1";
		#SDL_VIDEODRIVER="x11";
		#GCM_CREDENTIAL_STORE="gpg";
		#XMODIFIERS="@im=fcitx";
		#SDL_IM_MODULE="fcitx";
		#INPUT_METHOD="fcitx";
		#GLFW_IM_MODULE="fcitx";
		#XCURSOR_SIZE="24";
		#HYPRCURSOR_SIZE="24";
		#HYPRCURSOR_THEME="HyprBibataModernClassicSVG";
		#QT_QPA_PLATFORM="wayland";
		#QT_QPA_PLATFORMTHEME="kde";
		#QT_STYLE_OVERRIDE="adwaita-dark";
		#WINEESYNC="0";
		#TMPDIR="/var/tmp";


    };

  systemPackages = with pkgs; [
		
		#tableplus
   #(pkgs.buildFHSEnv {
   #   name = "godot-fhs";
   #   targetPkgs = pkgs: with pkgs; [
	#			godot_4
  #      stdenv.cc.cc  # Adds missing runtime libraries
  #      #alsa-lib       # Fixes sound issues
  #      #libGL         # OpenGL support
  #      #libxkbcommon  # Fixes keyboard input
  #    ];
  #    #runScript = "${pkgs.godot_4}/bin/godot4";
  #    runScript = "godot4";
  #  })
		#nodePackages_latest.ts-no    
    tmux
    monero-gui
    monero-cli
    p2pool
    xmrig
    dunst
    vscode-langservers-extracted
    typescript-language-server
    basedpyright
    bash-language-server
    nixd
    nixos-anywhere
    rust-analyzer
		protonvpn-gui
		podman-compose
		sbt-with-scala-native
		gtk3
		auto-cpufreq
    ags
		radeontop
		wl-clicker
		patchelf
		bc
		rocmPackages.rocminfo
		git-credential-manager
		kdePackages.kcalc
		#kdePackages.dolphin
		#kdePackages.qtsvg
		#kdePackages.kio-fuse
		#kdePackages.kio-extras
		#conda
		conda
		ngrok
		kdePackages.filelight
    solana-cli
		swww
		pywal
		matugen
		pcmanfm
		waybar
		#new-bottles
		pavucontrol
		sbctl
		#wpsoffice
		powertop
		wf-recorder
    hyprpaper
		selectdefaultapplication
		tradingview
		github-desktop
		gitkraken
		php
		#mysql-workbench
		go
		#zed-editor
		google-chrome
		pnpm
		wvkbd
		rot8
		fd
		postman
		yarn
		brightnessctl
		swaybg
		#podman-desktop
		adwaita-icon-theme
		batsignal
		lf
		networkmanagerapplet
		#onedrivegui
		shared-mime-info
		grimblast
		rofi
		rofimoji
		qbittorrent
		nixd
		nnn
		discord
		discord-canary
		sqlitebrowser
		wireshark
		krita
		gimp3-with-plugins
		#bitwig-studio
		musescore
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
		nvtopPackages.full
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

  services = {

		
		#desktopManager.plasma6.enable = true;
		devmon.enable = true;
		gvfs.enable = true;
		udisks2.enable = true;
		#blueman.enable = true;
		gnome.gnome-keyring.enable = true;
		#dbus.implementation = "broker";
    envfs.enable = true;
    flatpak.enable = true;
    #onedrive.enable = true;
		tlp = {
			enable = true;
			settings = {
				TLP_ENABLE=1;
				TLP_MSG_COLORS="91 93 1 92";
       # TLP_DEFAULT_MODE="BAT";
			  TLP_PERSISTENT_DEFAULT=0;
			  NMI_WATCHDOG=0; #kernel logging
			  SOUND_POWER_SAVE_ON_AC=0;
			  SOUND_POWER_SAVE_ON_BAT=1;
			  SOUND_POWER_SAVE_CONTROLLER="Y";
				#MEM_SLEEP_ON_AC="s2idle";
				#MEM_SLEEP_ON_BAT="s2idle";

				#RUNTIME_PM_DRIVER_DENYLIST="mei_me";

			  RUNTIME_PM_ON_AC="on";
			  RUNTIME_PM_ON_BAT="auto";
			  PCIE_ASPM_ON_AC="default";
			  PCIE_ASPM_ON_BAT="powersupersave";
			  WIFI_PWR_ON_AC="off";
			  WIFI_PWR_ON_BAT="off"; #no powersave for wifi
			  WOL_DISABLE="Y";
			  USB_AUTOSUSPEND=0;

			  START_CHARGE_THRESH_BAT0=80;
			  STOP_CHARGE_THRESH_BAT0=90;
			  START_CHARGE_THRESH_BAT1=80;
			  STOP_CHARGE_THRESH_BAT1=90;
			  PLATFORM_PROFILE_ON_AC="performance";
			  PLATFORM_PROFILE_ON_BAT="quiet";
			  RADEON_DPM_PERF_LEVEL_ON_AC="auto"; #this shit nerfs my suspend on high
			  RADEON_DPM_PERF_LEVEL_ON_BAT="low";
			  RADEON_DPM_STATE_ON_AC="performance"; 
			  RADEON_DPM_STATE_ON_BAT="battery";
			  RADEON_POWER_PROFILE_ON_AC="high";
			  RADEON_POWER_PROFILE_ON_BAT="low";
			  AMDGPU_ABM_LEVEL_ON_AC=0; 
	 		  AMDGPU_ABM_LEVEL_ON_BAT=3; #setting to 3 makes my screen look ugly as fuck
			  CPU_SCALING_GOVERNOR_ON_AC="performance";
			  CPU_SCALING_GOVERNOR_ON_BAT="powersave";
			  CPU_SCALING_MAX_FREQ_ON_BAT=1400000;
			  CPU_ENERGY_PERF_POLICY_ON_AC="performance";
			  CPU_ENERGY_PERF_POLICY_ON_BAT="power";
			  CPU_DRIVER_OPMODE_ON_AC="active";
			  CPU_DRIVER_OPMODE_ON_BAT="active";
			  CPU_BOOST_ON_AC=1;
			  CPU_BOOST_ON_BAT=0;

#intel exclusive below

				#CPU_SCALING_MIN_FREQ_ON_AC=0;
				#CPU_SCALING_MAX_FREQ_ON_AC=9999999;
				#CPU_SCALING_MIN_FREQ_ON_BAT=0;
				#INTEL_GPU_MIN_FREQ_ON_AC=0;
				#INTEL_GPU_MIN_FREQ_ON_BAT=0;
				#INTEL_GPU_MAX_FREQ_ON_AC=0;
				#INTEL_GPU_MAX_FREQ_ON_BAT=0;
				#INTEL_GPU_BOOST_FREQ_ON_AC=0;
				#INTEL_GPU_BOOST_FREQ_ON_BAT=0;
				#CPU_HWP_DYN_BOOST_ON_AC=1; 
				#CPU_HWP_DYN_BOOST_ON_BAT=0; 
				#CPU_MIN_PERF_ON_AC=0; 
				#CPU_MAX_PERF_ON_AC=100; 
				#CPU_MIN_PERF_ON_BAT=0; 
				#CPU_MAX_PERF_ON_BAT=30; 


			};
		};

    displayManager = {
		#sddm = {
		#	 enable = true;
		#	 theme="catppuccin-mocha";
			 
		#	 package = pkgs.kdePackages.sddm;
		#	 wayland.enable = true;
		#	 wayland.compositor = "kwin";
			 #enableHidpi = false;
		#};
		 ly = {
       enable = true;
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
	file-roller.enable = true;
	dconf.enable = true;
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
	hyprland = {
		enable = true;
		#withUWSM = true;
		#systemd.setPath.enable = true;
		#package = stable.hyprland;
		#portalPackage = stable.xdg-desktop-portal-hyprland;
	};
	#waybar = {
	#	enable = true;
	#};

    
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



}


