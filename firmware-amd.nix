{ pkgs,lib,... }:
{


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
			  RADEON_DPM_PERF_LEVEL_ON_AC="auto"; #this shit nerfs my suspend on high
			  RADEON_DPM_PERF_LEVEL_ON_BAT="low";
			  RADEON_DPM_STATE_ON_AC="performance"; 
			  RADEON_DPM_STATE_ON_BAT="battery";
			  RADEON_POWER_PROFILE_ON_AC="high";
			  RADEON_POWER_PROFILE_ON_BAT="low";
			  AMDGPU_ABM_LEVEL_ON_AC=0; 
	 		  AMDGPU_ABM_LEVEL_ON_BAT=3; #setting to 3 makes my screen look ugly as fuck
			  CPU_SCALING_GOVERNOR_ON_AC="performance";
			  CPU_SCALING_GOVERNOR_ON_BAT="powersave";
			  CPU_SCALING_MAX_FREQ_ON_BAT=1400000;
			  CPU_ENERGY_PERF_POLICY_ON_AC="performance";
			  CPU_ENERGY_PERF_POLICY_ON_BAT="power";
			  CPU_DRIVER_OPMODE_ON_AC="active";
			  CPU_DRIVER_OPMODE_ON_BAT="active";
			  CPU_BOOST_ON_AC=1;
			  CPU_BOOST_ON_BAT=0;
			};
		};
  };




}


