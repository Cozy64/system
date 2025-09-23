{pkgs, ...}:
{
          boot = {
            supportedFilesystems = [ "ntfs" ];
            kernelParams = ["fbcon=font:VGA8x16" "default_hugepagesz=2M" "hugepagesz=1G" "hugepages=3"];
            kernelPackages = pkgs.linuxPackages_zen;
            loader = {
              efi.canTouchEfiVariables = true;
              systemd-boot.enable = true;
            };
          };

}
