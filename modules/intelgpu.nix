{ pkgs, ... }:
{

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vpl-gpu-rt
        intel-media-sdk
      ];
			extraPackages32 = with pkgs.driversi686Linux; [

			];
    };
   };





}

