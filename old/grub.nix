{pkgs, lib, ...}:
{

          boot = {
            supportedFilesystems = [ "ntfs" ];
            kernelParams = ["fbcon=font:VGA8x16" "b43.allhwsupport=1"];
            kernelPackages = pkgs.linuxPackages_6_12;
            loader = {
              #efi.canTouchEfiVariables = true;
              grub = {
                enable = true;
                useOSProber = true;
                device = lib.mkForce "/dev/sda";
                #splashImage = "/home/cozy/wallpapers/hello.png";
                efiSupport = true;
                backgroundColor = "#000000";

              };
            };
          };

}
