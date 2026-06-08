{pkgs, ...}:
{
  services = {
    envfs.enable = true;

  };
  programs = {
    nix-ld = {
			enable = true;
			libraries = with pkgs; [
				#stdenv.cc.cc.lib
				#stdenv.cc.cc
        openssl
				gcc
        cmake
				gnumake
				glibc
				glib
				libXtst
    		libXxf86vm
				libX11
				libXcursor
				libXrandr
				libXinerama
				libXext
				libXrender
				libXi
				libxcb
				libxkbcommon
				wayland
				mesa
				gtk3
				alsa-lib
				libpulseaudio
				zlib
				dbus
				libGL
				vulkan-loader
				vulkan-tools
				fontconfig
				libdecor
				speechd
				

			];
		};


  };

}

