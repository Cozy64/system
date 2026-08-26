{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
  ];


  services = {
    #qemuGuest.enable = true;
    #spice-vdagentd.enable = true;

  };
  virtualisation = {
		kvmgt.enable = true;
		spiceUSBRedirection.enable = true;
      };
}
