{pkgs, gitPkgs, ...}:
{
  boot = {
    kernel.sysctl = {
      "vm.nr_hugepages" = 1024;
    };
    supportedFilesystems = [ "ntfs" ];
  	kernelParams = [
      #"vfio_pci" 
      #"vfio" 
      #"vfio_iommu_type1" 
      #"intel_iommu=on"
      "pcie_port_pm=off"
      "fbcon=font:TER8x16" 
      #"default_hugepagesz=2M" 
      #"hugepagesz=1G" 
      #"hugepages=4"
    ];
    initrd.kernelModules = [ 
      "i915"
      #"vfio_pci"
      #"vfio"
      #"vfio_iommu_type1"
      #"vfio-pci.ids=8086:b090,15b7:501e"
    ];

     # kernelModules= ["rtw89_pci disable_aspm_l1=Y disable_aspm_l1ss=Y"];
     #kernelPackages = pkgs.linuxPackages_6_18;
      #kernelPackages = pkgs.linuxPackages_latest;
      kernelPackages = pkgs.linuxPackages_latest;
      #kernelPackages = pkgs.linuxPackages_cachyos;
      #kernelPackages = pkgs.linuxPackages_7_0;
      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = true;
      };
    };

}
