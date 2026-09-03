{...}:
{
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
              on-timeout = ''[ "$(tlpctl get)" = "power-saver" ] && hyprctl dispatch dpms off'';
              on-resume = "hyprctl dispatch dpms on";
            }
            {
              timeout = 240; 
              on-timeout = ''[ "$(tlpctl get)" = "power-saver" ] && systemctl suspend-then-hibernate'';
            }
          ];
        };

      };

    };



  };

}

