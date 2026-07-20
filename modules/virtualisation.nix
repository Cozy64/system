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
		kvmgt.enable = true;
		spiceUSBRedirection.enable = true;
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
      #virtualbox = {
			#	host.enable = true;
			#	host.enableExtensionPack = true;
			#	host.enableKvm = true;
				#host.enableHardening = false;
			#	host.addNetworkInterface = false;
			#	guest = {
			#		enable = true;
			#		dragAndDrop = true;
					#vboxsf = true;
			#	};
      #};
      #vmware = {
      #  host.enable = true;
        #guest.enable = true;
      #};
    #podman = { 
		#	enable = true;
		#	dockerCompat = true;
		#	defaultNetwork.settings.dns_enabled = true;
		#	dockerSocket.enable = true;
  	#};
	};
}
