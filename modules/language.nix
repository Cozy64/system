{pkgs, ...}:
{

  i18n.inputMethod = {
	enable = true;
	type = "fcitx5";
    fcitx5 = {
			#plasma6Support = true;
    	waylandFrontend = true;
    	addons = with pkgs; [
      qt6Packages.fcitx5-chinese-addons
    	];
	};
  };
}
