{pkgs, ...}:
{
  programs = {
    virt-manager.enable = true;

  };
  virtualisation = {
    #waydroid.enable = true;
		kvmgt.enable = true;
		spiceUSBRedirection.enable = true;
      #libvirtd.enable = true;
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
    podman = { 
			enable = true;
			dockerCompat = true;
			defaultNetwork.settings.dns_enabled = true;
			dockerSocket.enable = true;
  	};
      #docker.enable = true;
	};
}
