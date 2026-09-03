{ ... }:
{

  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    enableAllHardware = true;
		cpu = {
      intel = {
        updateMicrocode = true;
        npu.enable = true;
      };
      
			x86.msr.enable = true;
		};
   };





}

