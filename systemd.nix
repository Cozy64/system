{pkgs, ...}:
{
          boot = {
            supportedFilesystems = [ "ntfs" ];
            kernelParams = ["fbcon=font:VGA8x16"];
            kernelPackages = pkgs.linuxPackages_latest;
            loader = {
              efi.canTouchEfiVariables = true;
              systemd-boot.enable = true;
            };
          };

}
