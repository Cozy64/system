{ ... }:
{

  hardware = {
    enableAllFirmware = true;
    enableAllHardware = true;
		cpu = {
      intel.updateMicrocode = true;
			x86.msr.enable = true;
		};
   };





}

