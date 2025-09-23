{pkgs, ...}:
{
          boot = {
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
