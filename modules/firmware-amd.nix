{ pkgs,lib,... }:
{


  hardware = {
    i2c.enable = true;
		amdgpu = {
			opencl.enable = true;
			initrd.enable = true;
		};
    enableAllFirmware = true;
    enableAllHardware = true;
		cpu = {
			x86.msr.enable = true;
			amd = {
				updateMicrocode = true;
				ryzen-smu.enable = true;
      };
		};
    bluetooth= {
      enable = true;
			powerOnBoot = false;
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


