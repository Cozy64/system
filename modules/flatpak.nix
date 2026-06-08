{ lib, ... }: {

  # Add a new remote. Keep the default one (flathub)
  #services.flatpak.remotes = lib.mkOptionDefault [{
  #  name = "flathub-beta";
  #  location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
  #}];

  services.flatpak.update.auto.enable = false;
  services.flatpak.uninstallUnmanaged = false;
  services.flatpak.enable = true;

  # Add here the flatpaks you want to install
  services.flatpak.packages = [
    #"com.visualstudio.code"
    "com.jetbrains.IntelliJ-IDEA-Ultimate"
    "org.apache.netbeans"
    "org.godotengine.Godot"
    "org.kde.kdenlive"
    #"io.github.shiftey.Desktop"

  ];

}
