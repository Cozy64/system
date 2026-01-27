{pkgs, ...}:
{

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };
    printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
        hplipWithPlugin
        cnijfilter2
        samsung-unified-linux-driver
        splix
      ];
    };


  };



}
