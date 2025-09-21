{
  disko.devices = {
    disk.main = {
      type = "disk";
      device = "/dev/sda"; # adjust if needed
      content = {
        type = "gpt";
        partitions = {
          bios = {
            size = "10M";
            type = "EF02"; # BIOS Boot partition
          };
          esp = {
            size = "1G";
            type = "EF00"; # EFI System Partition
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          root = {
            size = "100%"; # use rest of disk except ESP
            content = {
              type = "filesystem";
              format = "ext4";   # or btrfs/xfs if you chose
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}
