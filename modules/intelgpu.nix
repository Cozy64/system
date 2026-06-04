{ pkgs, ... }:
{

	environment.systemPackages = with pkgs; [
    nvtopPackages.intel
		

	];
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vpl-gpu-rt
      ];
			extraPackages32 = with pkgs.driversi686Linux; [

			];
    };
   };





}

