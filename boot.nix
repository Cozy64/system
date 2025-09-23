{pkgs, ...}:
{
          boot = {
            supportedFilesystems = [ "ntfs" ];
            kernelPackages = pkgs.linuxPackages_zen;
            loader = {
              efi.canTouchEfiVariables = true;
              systemd-boot.enable = true;
            };
          };

}
