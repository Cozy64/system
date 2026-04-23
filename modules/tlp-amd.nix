{ ... }:
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
			  SOUND_POWER_SAVE_ON_SAV=1;
			  SOUND_POWER_SAVE_CONTROLLER="Y";
				MEM_SLEEP_ON_AC="deep"; #s2idle is the other option
				MEM_SLEEP_ON_BAT="deep";
				MEM_SLEEP_ON_SAV="deep";


			  RUNTIME_PM_ON_AC="on";  #not really sure what those 4 do
			  RUNTIME_PM_ON_BAT="auto";
			  RUNTIME_PM_ON_SAV="auto";
			  PCIE_ASPM_ON_AC="default";
			  PCIE_ASPM_ON_BAT="powersupersave";
			  PCIE_ASPM_ON_SAV="powersupersave";

			  WIFI_PWR_ON_AC="off";
			  WIFI_PWR_ON_BAT="off"; #no powersave for wifi
			  WIFI_PWR_ON_SAV="off"; #no powersave for wifi
			  WOL_DISABLE="Y";
			  USB_AUTOSUSPEND=1;

			  START_CHARGE_THRESH_BAT0=80;
			  STOP_CHARGE_THRESH_BAT0=90;
			  START_CHARGE_THRESH_BAT1=80;
			  STOP_CHARGE_THRESH_BAT1=90;
			  PLATFORM_PROFILE_ON_AC="performance";
			  PLATFORM_PROFILE_ON_BAT="quiet";
			  PLATFORM_PROFILE_ON_SAV="quiet";
			  CPU_SCALING_GOVERNOR_ON_AC="performance";
			  CPU_SCALING_GOVERNOR_ON_BAT="powersave";
			  CPU_SCALING_GOVERNOR_ON_SAV="powersave";
			  #CPU_SCALING_MAX_FREQ_ON_BAT=1400000; #buggy when using this. Not recommended
			  CPU_ENERGY_PERF_POLICY_ON_AC="performance";
			  CPU_ENERGY_PERF_POLICY_ON_BAT="power";
			  CPU_ENERGY_PERF_POLICY_ON_SAV="power";
			  CPU_DRIVER_OPMODE_ON_AC="active";
			  CPU_DRIVER_OPMODE_ON_BAT="active";
			  CPU_DRIVER_OPMODE_ON_SAV="active";
			  CPU_BOOST_ON_AC=1;
			  CPU_BOOST_ON_BAT=0;
			  CPU_BOOST_ON_SAV=0;

			  RADEON_DPM_PERF_LEVEL_ON_AC="auto"; #this shit nerfs my suspend on high
			  RADEON_DPM_PERF_LEVEL_ON_BAT="low";
			  RADEON_DPM_PERF_LEVEL_ON_SAV="low";
			  RADEON_DPM_STATE_ON_AC="performance"; 
			  RADEON_DPM_STATE_ON_BAT="battery";
			  RADEON_DPM_STATE_ON_SAV="battery";
			  RADEON_POWER_PROFILE_ON_AC="high";
			  RADEON_POWER_PROFILE_ON_BAT="low";
			  RADEON_POWER_PROFILE_ON_SAV="low";
			  AMDGPU_ABM_LEVEL_ON_AC=0; 
	 		  AMDGPU_ABM_LEVEL_ON_BAT=3; #setting to 3 makes my screen look ugly as fuck
	 		  AMDGPU_ABM_LEVEL_ON_SAV=3; 
			};
		};
  };

}
