# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{ pkgs, gitPkgs, stablePkgs, unstablePkgs, lib,   ... }:
let
		#sources = import /home/cozy/nix/sources.nix;
		#lanzaboote = import sources.lanzaboote;
in
{





  environment = {
    systemPackages = with pkgs; [
      #(ciscoPacketTracer9.overrideAttrs (old: { src = /home/cozy/system/packettracer/CiscoPacketTracer_900_Ubuntu_64bit.deb; }))
      trash-cli
      cliphist
      claude-code
      file-roller
      lxqt.lxqt-policykit 
      warehouse
      github-desktop
      flutter
      wechat
      fuzzel
      quickshell
      usbutils
      crosspipe
      tor-browser
      #osu-lazer-bin
      vlc
      lshw
      xarchiver
      burpsuite
      spotify
      libuv
      hwloc 
      pkg-config
      dmidecode
      tmux
      android-studio
      android-tools
      msr-tools
      p2pool
      xmrig
      dunst
      vscode-langservers-extracted
      #vscode-fhs
      typescript-language-server
      astro-language-server
      basedpyright
      bash-language-server
      nixd
      nixos-anywhere
      rust-analyzer
      proton-vpn
      sbt-with-scala-native
      gtk3
      auto-cpufreq
      radeontop
      wl-clicker
      patchelf
      bc
      rocmPackages.rocminfo
      kdePackages.kcalc
      #kdePackages.kdenlive
      conda
      ngrok
      kdePackages.filelight
      awww
      pywal
      matugen
      pcmanfm
      waybar
      #bottles
      #new-bottle
      pavucontrol
      sbctl
      #wpsoffice
      powertop
      itch
      #godot_4
      #jetbrains.idea-community-bin
      wf-recorder
      hyprpaper
      selectdefaultapplication
      tradingview
      gitkraken
      php
      blender
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
      lxmenu-data
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
      yt-dlp
      cava
      fastfetch
      zoxide
      wineWow64Packages.waylandFull
      nmap
      pulsemixer
      telegram-desktop
      imv
      conda
      obs-studio
      teams-for-linux
      btop
      gparted
      bluetuith
      niv
      fzf
      xeyes
      wayland-utils
      libnotify
      lua
      xev
      xhost
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
      nodejs
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
		variables = {
		BEMENU_OPTS="-b -p '>' --fn 16 --bdr '#FFFFFF' --ab '#000000' --af '#666666' --nb '#000000' --nf '#666666' --tb '#000000' --tf '#FFFFFF' --fb '#000000' --ff '#FFFFFF' --hb '#000000dd' --hf '#FFFFFF'";
		ANDROID_HOME="/home/cozy/Android/Sdk";
		PATH="/home/cozy/.cargo/bin:/home/cozy/.local/bin:/home/cozy/.deno/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH";
    #GSETTINGS_SCHEMA_DIR="${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas";
	  #LD_LIBRARY_PATH = lib.mkForce"$NIX_LD_LIBRARY_PATH:$LD_LIBRARY_PATH";	
		XDG_RUNTIME_DIR = "/run/user/$UID";
		#NIXOS_OZONE_WL="1";
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
   etc."libinput/local-overrides.quirks".text = ''
      [Never Debounce]
      MatchUdevType=mouse
      ModelBouncingKeys=1
   '';


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
      export NNN_TRASH=1


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

#powerManagement.powerDownCommands = ''
#  ${pkgs.kmod}/bin/modprobe -r rtw89_8851be
#'';
#
#powerManagement.resumeCommands = ''
#  echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove
#  echo 1 > /sys/bus/pci/rescan
#  ${pkgs.kmod}/bin/modprobe rtw89_8851be
#'';


#powerManagement = {
#  enable = true;
#  powerDownCommands = ''
#    ${pkgs.kmod}/bin/modprobe -rv rtw89_8851be
#  '';
#
#  resumeCommands = ''
#    ${pkgs.kmod}/bin/modprobe -v rtw89_8851be
#  '';
#};
  #${pkgs.networkmanager}/bin/nmcli radio wifi off
   # ${pkgs.kmod}/bin/modprobe -rv rtw89_8851be
   # ${pkgs.kmod}/bin/modprobe -rv rtw89_pci
   # ${pkgs.kmod}/bin/modprobe -rv rtw89_core
   # ${pkgs.kmod}/bin/modprobe -rv btusb
   # ${pkgs.kmod}/bin/modprobe -rv btrtl
	xdg = {
    mime = {
      enable = true;
      defaultApplications = {
          "x-scheme-handler/http" = ["google-chrome.desktop"];
          "x-scheme-handler/https" = ["google-chrome.desktop"];
          "x-scheme-handler/about" = ["google-chrome.desktop"];
          "x-scheme-handler/unknown" = ["google-chrome.desktop"];
          "x-scheme-handler/x-github-client" = ["github-desktop.desktop"];
          "x-scheme-handler/x-github-desktop-dev-auth" = ["github-desktop.desktop"];
          "x-scheme-handler/gitkraken" = ["gitkraken.desktop"];
          "x-scheme-handler/claude-cli" = ["claude-code-url-handler.desktop"];
          "image/png" = ["imv.desktop"];
          "image/jpg" = ["imv.desktop"];
          "image/webp" = ["imv.desktop"];
          "image/svg+xml" = ["imv.desktop"];
          "image/jpeg" = ["imv.desktop"];
          "application/zip" = "org.gnome.FileRoller.desktop";
          "application/x-tar" = "org.gnome.FileRoller.desktop";
          "application/x-gzip" = "org.gnome.FileRoller.desktop";
          "application/x-bzip2" = "org.gnome.FileRoller.desktop";
          "application/x-7z-compressed" = "org.gnome.FileRoller.desktop";
          "inode/directory" = "pcmanfm.desktop";
          "text/html"=["google-chrome.desktop"];
      };
    };
  };

  nixpkgs.config = {
    allowUnfree = true; 
    allowInsecure = true; 
    #allowBroken = true; 
	  #allowUnsupportedSystem = true;
  };




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
    #hardwareClockInLocalTime = true;
  };


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
    earlySetup = true;
    packages =  with pkgs; [terminus_font];
    #useXkbConfig = true; # use xkbOptions in tty.
  };

systemd.sleep.settings.Sleep = {
  HibernateDelaySec="1h"; 
};

#systemd = {
#  tmpfiles.rules = [
#  "w /sys/bus/pci/devices/0000:01:00.0/power/control - - - - on"
#
#  ];
#};

  


  security = {
    pam.services.login.enableGnomeKeyring = true; 
		#soteria.enable = true;
    polkit.enable = true;
  };

  services = {

		
		devmon.enable = true;
		gvfs.enable = true;
		udisks2.enable = true;
		#blueman.enable = true;
		gnome.gnome-keyring.enable = true;
		#dbus.implementation = "broker";
    #onedrive.enable = true;
    #libinput = {
    #  mouse = {
    #    additionalOptions = ''
    #      [Never Debounce]
    #      MatchUdevType=mouse
    #      ModelBouncingKeys=1
    #    
#
#        '';
#
#      };
#
#    };
    upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 15;
      percentageAction = 10;
      timeAction = 0;
      criticalPowerAction = "Hibernate";
			allowRiskyCriticalPowerAction = true;
    };
    logind.settings.Login = {
			HandleLidSwitch="suspend-then-hibernate";
			HandleLidSwitchExternalPower="suspend-then-hibernate";
			HandleSuspendKey="suspend-then-hibernate";
			HandlePowerKey="suspend-then-hibernate";
    };



	};


  programs = {

  firefox.enable = true;
	seahorse.enable = true; #displays gnome keystring data
  #gnupg.agent = {
  #  enable = true;
  #  enableSSHSupport = true;

  #};
	git = {
		enable = true;
		package = pkgs.gitFull;


	};
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
				colors-dark = {

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
		nm-applet.enable = true;

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

  


  nix.settings.experimental-features = [ "nix-command" "flakes"];
	#nix.package = pkgs.lix;

  users.extraGroups.vboxusers.members = [ "cozy" ];
  users.users.cozy = {
    isNormalUser = true;
    extraGroups = [ "podman" "input" "wheel" "adbusers" "kvm" "docker" "wireshark" "libvirtd" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [];
  };



}


