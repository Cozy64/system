{pkgs, ...}:
{
  home-manager.users.cozy = {


    programs = {
      fuzzel = {
        enable = true;
        settings = {
            main = {
              font = "monospace:size=10";
              prompt = ">  ";
              icon-theme = "hicolor";
              lines = 15;
              width = 25;
              line-height = 16;
              # Left empty parameters commented out as Nix requires explicit values
              # horizontal-pad = 0;
              # vertical-pad = 0;
              # inner-pad = 0;
            };

            colors = {
              input = "ddddddff";
              text = "ddddddff";
              match = "888888ff";
              prompt = "ddddddff";
              selection-text = "ddddddff";
              selection-match = "444444ff";
              selection = "aaaaaadd";
              border = "aaaaaaff";
              background = "000000dd";
            };

            border = {
              width = 0;
              radius = 0;
            };

        };
      };

    };
		
		services = {

    ssh-agent.enable = true;
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
              #icon_path = "/usr/share/icons/gnome/16x16/status/:/usr/share/icons/gnome/16x16/devices/";

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


    dconf = {
      enable = true;
      settings."org/gnome/desktop/interface" = {
        #gtk-theme = "Graphite-Dark";
        color-scheme = "prefer-dark";
      };
    };
    home = { 
      pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
        size = 24;
      };
  	};

	};

}
