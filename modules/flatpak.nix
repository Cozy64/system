{ lib, ... }: {

  # Add a new remote. Keep the default one (flathub)
  #services.flatpak.remotes = lib.mkOptionDefault [{
  #  name = "flathub-beta";
  #  location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
  #}];

  services.flatpak.update.auto.enable = false;
  services.flatpak.uninstallUnmanaged = false;

  # Add here the flatpaks you want to install
  services.flatpak.packages = [
    "com.visualstudio.code"
    "com.jetbrains.IntelliJ-IDEA-Ultimate"
    "org.apache.netbeans"
    "org.godotengine.Godot"
    "org.kde.kdenlive"
    "org.gtk.Gtk3theme.Adwaita-dark"
    #"com.spotify.Client"
    "org.libreoffice.LibreOffice"
    "com.github.tchx84.Flatseal"
    #"org.musescore.MuseScore"
    #"com.protonvpn.www"
    #"com.anydesk.Anydesk"
    #"com.tencent.WeChat"
    #"com.github.IsmaelMartinez.teams_for_linux"
    #"io.github.shiftey.Desktop"

  ];

}
