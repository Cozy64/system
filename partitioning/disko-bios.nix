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
