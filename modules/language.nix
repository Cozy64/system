{pkgs, ...}: {
  i18n.inputMethod = {
	enable = true;
	type = "fcitx5";
    fcitx5 = {
			#plasma6Support = true;
    	waylandFrontend = true;
    	addons = with pkgs; [
      #fcitx5-gtk
      qt6Packages.fcitx5-chinese-addons
      #qt6Packages.fcitx5-qt
    	];
	};
  };
}
