{ pkgs,lib,   ... }:
{
  services = {
		tlp = {
			enable = true;
			settings = {
				TLP_ENABLE=1;
				TLP_MSG_COLORS="91 93 1 92";
       # TLP_DEFAULT_MODE="BAT";
			  TLP_PERSISTENT_DEFAULT=0;
			  NMI_WATCHDOG=0; #kernel logging
			  SOUND_POWER_SAVE_ON_AC=0;
			  SOUND_POWER_SAVE_ON_BAT=1;
			  SOUND_POWER_SAVE_CONTROLLER="Y";
				#MEM_SLEEP_ON_AC="s2idle";
				#MEM_SLEEP_ON_BAT="s2idle";

				#RUNTIME_PM_DRIVER_DENYLIST="mei_me";

			  RUNTIME_PM_ON_AC="on";
			  RUNTIME_PM_ON_BAT="auto";
			  PCIE_ASPM_ON_AC="default";
			  PCIE_ASPM_ON_BAT="powersupersave";
			  WIFI_PWR_ON_AC="off";
			  WIFI_PWR_ON_BAT="off"; #no powersave for wifi
			  WOL_DISABLE="Y";
			  USB_AUTOSUSPEND=0;

			  START_CHARGE_THRESH_BAT0=80;
			  STOP_CHARGE_THRESH_BAT0=90;
			  START_CHARGE_THRESH_BAT1=80;
			  STOP_CHARGE_THRESH_BAT1=90;
			  PLATFORM_PROFILE_ON_AC="performance";
			  PLATFORM_PROFILE_ON_BAT="quiet";
			  CPU_SCALING_GOVERNOR_ON_AC="performance";
			  CPU_SCALING_GOVERNOR_ON_BAT="powersave";
			  CPU_SCALING_MAX_FREQ_ON_BAT=1400000;
			  CPU_ENERGY_PERF_POLICY_ON_AC="performance";
			  CPU_ENERGY_PERF_POLICY_ON_BAT="power";
			  CPU_DRIVER_OPMODE_ON_AC="active";
			  CPU_DRIVER_OPMODE_ON_BAT="active";
			  CPU_BOOST_ON_AC=1;
			  CPU_BOOST_ON_BAT=0;

        CPU_SCALING_MIN_FREQ_ON_AC=0;
				CPU_SCALING_MAX_FREQ_ON_AC=9999999;
				CPU_SCALING_MIN_FREQ_ON_BAT=0;
				INTEL_GPU_MIN_FREQ_ON_AC=0;
				INTEL_GPU_MIN_FREQ_ON_BAT=0;
				INTEL_GPU_MAX_FREQ_ON_AC=0;
				INTEL_GPU_MAX_FREQ_ON_BAT=0;
				INTEL_GPU_BOOST_FREQ_ON_AC=0;
				INTEL_GPU_BOOST_FREQ_ON_BAT=0;
				CPU_HWP_DYN_BOOST_ON_AC=1; 
				CPU_HWP_DYN_BOOST_ON_BAT=0; 
				CPU_MIN_PERF_ON_AC=0; 
				CPU_MAX_PERF_ON_AC=100; 
				CPU_MIN_PERF_ON_BAT=0; 
				CPU_MAX_PERF_ON_BAT=30; 

			};
		};



  };

  hardware = {
    enableAllFirmware = true;
    enableAllHardware = true;
		cpu = {
      intel.updateMicrocode = true;
			x86.msr.enable = true;
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

