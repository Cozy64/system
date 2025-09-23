{pkgs, ...}:
{

  programs = {

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      extest.enable = true;
      dedicatedServer.openFirewall = true;
			gamescopeSession.enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];

    };

  };



}
