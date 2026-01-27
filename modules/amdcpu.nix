{ ... }:
{

  hardware = {
    i2c.enable = true;
    enableAllFirmware = true;
    enableAllHardware = true;
		cpu = {
			x86.msr.enable = true;
			amd = {
				updateMicrocode = true;
				ryzen-smu.enable = true;
      };
		};
   };



}


