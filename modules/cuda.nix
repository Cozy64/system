{ pkgs,... }:
{
  hardware = {
		amdgpu = {
			opencl.enable = true;
			initrd.enable = true;
		};

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
      	#rocmPackages.clr.icd
        #vaapiVdpau
        #libvdpau-va-gl
      ];
			extraPackages32 = with pkgs.driversi686Linux; [
      	#rocmPackages.clr.icd
      	#libvdpau-va-gl

			];
    };

  };

  nixpkgs.config.rocmSupport = true;

}
