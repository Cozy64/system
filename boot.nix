{pkgs, ...}:
{
  boot = {
    supportedFilesystems = [ "ntfs" ];
  	kernelParams = ["pcie_port_pm=off""fbcon=font:VGA8x16" "default_hugepagesz=2M" "hugepagesz=1G" "hugepages=4"];
  	#kernelParams = ["fbcon=font:VGA8x16" "default_hugepagesz=2M" "hugepagesz=1G" "hugepages=4"];
  	#kernelParams = ["mem_sleep_default=deep" "fbcon=font:VGA8x16" "default_hugepagesz=2M" "hugepagesz=1G" "hugepages=4"];
    #extraModprobeConfig = ''
    #  options rtw89_pci disable_aspm_l1=y disable_aspm_l1ss=y
    #'';

     # kernelModules= ["rtw89_pci disable_aspm_l1=Y disable_aspm_l1ss=Y"];
    # kernelPackages = pkgs.linuxPackages_zen;
      kernelPackages = pkgs.linuxPackages_latest;
      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = true;
      };
    };

}
