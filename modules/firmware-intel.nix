{ pkgs, ... }:
{

  hardware = {
    enableAllFirmware = true;
    enableAllHardware = true;
		cpu = {
      intel.updateMicrocode = true;
			x86.msr.enable = true;
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





}

