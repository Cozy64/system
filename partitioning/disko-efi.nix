{
  disko.devices = {
    disk.main = {
      device = "/dev/sda"; # adjust to your actual device
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            size = "1G";
            type = "c12a7328-f81f-11d2-ba4b-00a0c93ec93b"; # EFI System Partition
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          root = {
            size = "100%";
            type = "0fc63daf-8483-4772-8e79-3d69d8477de4"; # Linux filesystem
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}
