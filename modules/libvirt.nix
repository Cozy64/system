{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
  ];


  programs = {
    virt-manager.enable = true;

  };
  services = {
    #qemuGuest.enable = true;
    #spice-vdagentd.enable = true;

  };
  virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
          runAsRoot = true;
          vhostUserPackages = with pkgs; [
            virtiofsd

          ];

        };
      };
	};
}

