{pkgs, ...}:
{
	environment.systemPackages = with pkgs; [
  polkit_gnome
		

	];
  services.hypridle.enable = true;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "default.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
    };
  };

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
                after_sleep_cmd = "hyprctl dispatch dpms on && brightnessctl -r";
              };

              listener = [
                {
                  timeout = 60;
                  on-timeout = "systemd-ac-power || brightnessctl -s set 1";
                  on-resume = "brightnessctl -r";
                }
                {
                  timeout = 120;
                  on-timeout = "systemd-ac-power || hyprctl dispatch dpms off";
                  on-resume = "hyprctl dispatch dpms on";
                }
                {
                  timeout = 240; 
                  on-timeout = "systemd-ac-power || systemctl suspend";
                }
              ];
          };

        

      };

    };



  };
}
