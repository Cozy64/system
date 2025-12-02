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
    zoom-us
    xarchiver
    burpsuite
    spotify
    libuv
    hwloc 
    pkg-config
    anydesk
    dmidecode
    tmux
    android-studio
    msr-tools
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
		#protonvpn-gui
		sbt-with-scala-native
		gtk3
		auto-cpufreq
		radeontop
		wl-clicker
		patchelf
		bc
		rocmPackages.rocminfo
		git-credential-manager
		kdePackages.kcalc
		conda
		ngrok
		kdePackages.filelight
		swww
		pywal
		matugen
		pcmanfm
		waybar
    bottles
		#new-bottle
		pavucontrol
		sbctl
		#wpsoffice
		powertop
    itch
    godot_4
    jetbrains.idea-community-bin
		wf-recorder
    hyprpaper
		selectdefaultapplication
		tradingview
		github-desktop
		gitkraken
		php
    blender-hip
    prismlauncher
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
		adwaita-icon-theme
		batsignal
		lf
		networkmanagerapplet
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
		musescore
		mpv
		yt-dlp
		cava
		fastfetch
		zoxide
		wineWowPackages.waylandFull
		nmap
		pulsemixer
		telegram-desktop
		imv
    conda
    obs-studio
    teams-for-linux
		nvtopPackages.amd
		btop
		helvum
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
    mesa-demos
		bluez-tools
		p7zip
		winetricks
		mangohud
		ffmpeg_6-full
		nix-index
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
		mangohud
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

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
  description = "polkit-gnome-authentication-agent-1";
  wantedBy = [ "graphical-session.target" ];
  wants = [ "graphical-session.target" ];
  after = [ "graphical-session.target" ];
  serviceConfig = {
    Type = "simple";
    ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    Restart = "on-failure";
    RestartSec = 1;
    TimeoutStopSec = 10;
  };
};




  security = {
		#soteria.enable = true;
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

	seahorse.enable = true;
	git = {
		enable = true;
		package = pkgs.gitFull;

	};
	#file-roller.enable = true;
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
        openssl
				gcc
        cmake
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


  


  system.stateVersion = "25.11"; # Did you read the comment?
  nix.settings.experimental-features = [ "nix-command" "flakes"];
	#nix.package = pkgs.lix;

  users.extraGroups.vboxusers.members = [ "cozy" ];
  users.users.cozy = {
    isNormalUser = true;
    extraGroups = [ "podman" "wheel" "adbusers" "kvm" "docker" "wireshark" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [];
  };

  home-manager.users.cozy.home = {
      stateVersion = "26.05";
  };


}


