# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ pkgs,lib,   ... }:
{

  zramSwap.enable = true;
  hardware = {
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


