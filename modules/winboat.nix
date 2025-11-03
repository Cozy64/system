{pkgs, inputs, ...}:
{
    environment.systemPackages = with pkgs; [
      inputs.winboat.packages.${pkgs.system}.winboat
  ];

}
