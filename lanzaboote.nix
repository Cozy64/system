{pkgs, ...}:
{
          boot = {
            initrd.systemd.enable = true;
            supportedFilesystems = [ "ntfs" ];
            kernelPackages = pkgs.linuxPackages_zen;
          lanzaboote = {
            enable = true;
            pkiBundle = "/var/lib/sbctl";
          };
            loader = {
              efi.canTouchEfiVariables = true;
              systemd-boot.enable = false;
            };
          };

}
