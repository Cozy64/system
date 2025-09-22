{pkgs, ...}:
{
  home-manager.users.cozy = {

		
		services = {
			hyprpaper = {
				enable = true;
				settings = {
					preload = ["/home/cozy/wallpapers/phoenix.jpg"];
					wallpaper = [", /home/cozy/wallpapers/phoenix.jpg"];
					
				};
      };

			dunst = {
				enable = true;
          settings = {
            global = {
              ### Display ###
              monitor = 0;
              follow = "none";

              ### Geometry ###
              width = 300;
              height = "(0, 300)";
              origin = "top-right";
              offset = "(10, 50)";
              scale = 0;
              notification_limit = 20;

              ### Progress bar ###
              progress_bar = true;
              progress_bar_height = 10;
              progress_bar_frame_width = 1;
              progress_bar_min_width = 150;
              progress_bar_max_width = 300;
              progress_bar_corner_radius = 0;
              progress_bar_corners = "all";
              icon_corner_radius = 0;
              icon_corners = "all";

              ### Misc layout ###
              indicate_hidden = "yes";
              transparency = 0;
              separator_height = 2;
              padding = 12;
              horizontal_padding = 12;
              text_icon_padding = 0;
              frame_width = 1;
              frame_color = "#000000";
              gap_size = 0;
              separator_color = "frame";
              sort = "yes";

              ### Text ###
              font = "Monospace 10";
              line_height = 0;
              markup = "full";
              format = "<b>%s</b>\\n%b";
              alignment = "left";
              vertical_alignment = "center";
              show_age_threshold = 60;
              ellipsize = "middle";
              ignore_newline = "no";
              stack_duplicates = "true";
              hide_duplicate_count = "false";
              show_indicators = "yes";

              ### Icons ###
              enable_recursive_icon_lookup = true;
              icon_theme = "Adwaita";
              icon_position = "left";
              min_icon_size = 32;
              max_icon_size = 128;
              icon_path = "/usr/share/icons/gnome/16x16/status/:/usr/share/icons/gnome/16x16/devices/";

              ### History ###
              sticky_history = true;
              history_length = 20;

              ### Misc/Advanced ###
              dmenu = "/usr/bin/dmenu -p dunst:";
              browser = "/usr/bin/xdg-open";
              always_run_script = true;
              title = "Dunst";
              class = "Dunst";
              corner_radius = 0;
              corners = "all";
              ignore_dbusclose = false;
              force_xwayland = false;
              force_xinerama = false;

              ### Mouse ###
              mouse_left_click = "close_current";
              mouse_middle_click = "do_action, close_current";
              mouse_right_click = "close_all";
            };

            experimental = {
              per_monitor_dpi = false;
            };

            urgency_low = {
              background = "#000000";
              foreground = "#dddddd";
              timeout = 10;
              default_icon = "dialog-information";
            };

            urgency_normal = {
              background = "#000000";
              foreground = "#dddddd";
              timeout = 10;
              override_pause_level = 30;
              default_icon = "dialog-information";
            };

            urgency_critical = {
              background = "#000000";
              foreground = "#dd0000";
              frame_color = "#dd0000";
              timeout = 0;
              override_pause_level = 60;
              default_icon = "dialog-warning";
            };
          };
        };

		};

    programs = {
		hyprlock.enable = true;
		bash = {
			enable = true;
			bashrcExtra='' 
			if [[ "$CONTAINER_ID" == *"arch"* ]]; then 
			echo $CONTAINER_ID
			PS1="\[$(tput setaf 4)\]\u@arch \W> \[$(tput sgr0)\]"
			elif [[ "$CONTAINER_ID" == *"ubuntu"* ]]; then 
			echo $CONTAINER_ID
			PS1="\[$(tput setaf 1)\]\u@ubuntu \W> \[$(tput sgr0)\]"
			else 
			PS1=$PS1 
			fi
				#alias boot="sudo nixos-rebuild boot"
				alias boot="sudo nixos-rebuild boot --flake /home/cozy/system#rust"
				alias fhs="export PS1='\[$(tput setaf 1)\]\u@\h \W> \[$(tput sgr0)\]' export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH:$LD_LIBRARY_PATH"
				alias list="sudo nixos-rebuild list-generations"
				alias hibernate="systemctl hibernate"
				alias switch="sudo nixos-rebuild switch --flake /home/cozy/system#rust"
				alias update="nix flake update"
				alias metadata="nix flake metadata /home/cozy/system"
				alias garbage="sudo nix-collect-garbage -d"
				alias rollback="sudo nix-channel --rollback"
        alias cdnix="cd /home/cozy/system"
				alias vinix="nvim /home/cozy/system/configuration.nix"
				alias vihome="nvim /home/cozy/system/home-manager.nix"
				alias viflake="nvim /home/cozy/system/flake.nix"
				alias viware="nvim /home/cozy/system/hardware-amd.nix"
				alias vihypr="nvim /home/cozy/.config/hypr/hyprland.conf"
				alias VI="sudo -E nvim"
				alias NVIM="sudo -E nvim"
				alias NNN="sudo -E nnn"
				#alias installarch="distrobox create --root --init -n arch -i archlinux:latest"
				alias installarch="distrobox create --root --init -n arch -i quay.io/toolbx/arch-toolbox:latest"
				alias installubuntu="distrobox create --root --init -n ubuntu -i quay.io/toolbx/ubuntu-toolbox:latest"
				#alias installarch="distrobox create --root -n arch -i quay.io/toolbx/arch-toolbox:latest"
				alias deletearch="distrobox rm --root arch"
				alias deleteubuntu="distrobox rm --root ubuntu"
				alias arch="distrobox enter --root arch"
				alias ubuntu="distrobox enter --root ubuntu"
				alias stoparch="distrobox stop --root arch"
				alias stopubuntu="distrobox stop --root ubuntu"
				alias xampp="/opt/lampp/xampp"
				alias venv="source /home/cozy/pythonenv/bin/activate"
			'';
		};
    };
	qt = {
		enable = true;
		platformTheme.name = "gtk3";
	#		#style = {
	#			#name = "breeze";
	#			#package = pkgs.graphite-kde-theme;
	#		#};
	};

    gtk = {
      enable = true;
			#theme = {
			#	name = "Flat-Remix-GTK-Red-Darkest";
			#	package= pkgs.flat-remix-gtk;
			#	};
			theme = {
				name = "Graphite-Dark";
				package= pkgs.graphite-gtk-theme.override {
					tweaks = ["black"];
					themeVariants = ["default"];
					colorVariants = ["dark"];
				};
			};
      #cursorTheme = {
      # name = "Bibata-Modern-Classic";
      # package = pkgs.bibata-cursors;
      # size = 24;
 			#};
			iconTheme = {
				name = "Tela-black-dark";
				package = pkgs.tela-icon-theme;
				#name = "Papirus-Dark";
				#package = pkgs.papirus-icon-theme;
      };
    };


    dconf.settings."org/gnome/desktop/interface" = {
      #gtk-theme = "Graphite-Dark";
      color-scheme = "prefer-dark";
    };
    home = { 
      stateVersion = "25.11";
      pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
        size = 24;
      };
		#	packages = with pkgs; [
		#	];
  	};

#	stylix.targets.rofi.enable = true;
#	stylix.enable = true;
	
#  };
#	stylix = {
#		enable = true;
#		polarity = "dark";
		#base16Scheme = {
		#	base00 = "000000";
		#	base01 = "222222";
		#	base02 = "dd0000";
		#	base03 = "dd0000";
		#	base04 = "dd0000";
		#	base05 = "dddddd"; #general text
		#	base06 = "dd0000"; 
		#	base07 = "dd0000"; 
		#	base08 = "ff0000";
		#	base09 = "ff0000";
		#	base0A = "ffff00";
		#	base0B = "60ff00";
		#	base0C = "00ffff";
		#	base0D = "dd0000";
		#	base0E = "ff00ff";
		#	base0F = "dd0000";
		#};
		#image = /home/cozy/wallpapers/loneflame.png;
		#cursor = {
		#	package = pkgs.bibata-cursors;
    #  name = "Bibata-Modern-Classic";
		#	size = 24;
#
#		};
	};

}
