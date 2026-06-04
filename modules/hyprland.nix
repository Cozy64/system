{pkgs, ...}:
{
	environment.systemPackages = with pkgs; [
		

	];

systemd = {
  user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "hyprland-session.target" ];
    wants    = [ "hyprland-session.target" ];
    after    = [ "hyprland-session.target" ];
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
}
