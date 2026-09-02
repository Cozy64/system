{pkgs, ...}:
{
	environment.systemPackages = with pkgs; [
  polkit_gnome
		

	];
  services.hypridle.enable = true;


  programs = {
    hyprland = {
      enable = true;
      withUWSM = false;
      #systemd.setPath.enable = true;
    #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    #portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;    
    };
  };

  services = {
  };

  home-manager.users.cozy = {
    services = {
      hypridle = {
        enable = true;
        settings = {
          general = {
            after_sleep_cmd = "hyprctl dispatch dpms on";
          };

          listener = [
            #{
            #  timeout = 60;
            #  on-timeout = "systemd-ac-power || brightnessctl -s set 1";
            #  on-resume = "brightnessctl -r";
            #}
            {
              timeout = 60;
              on-timeout = ''[ "$(powerprofilesctl get)" = "power-saver" ] && hyprctl dispatch dpms off'';
              on-resume = "hyprctl dispatch dpms on";
            }
            {
              timeout = 240; 
              on-timeout = ''[ "$(powerprofilesctl get)" = "power-saver" ] && systemctl suspend-then-hibernate'';
            }
          ];
        };

      };

    };



  };
}
