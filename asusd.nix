{pkgs, ...}:
{
  services = {
    
    asusd = {
      enable = true;
			#package = oldPkgs.asusctl;
      enableUserService = true;
#      asusdConfig = 
#''
#'';
		animeConfig.text = ''
(
		system: [],
		boot: [
				ImageAnimation(
					file: "/home/cozy/matrix/cat3.gif",
					scale: 1.0,
					angle: 0.0,
					translation: (2.0, 3.0),
					time: Fade((
							fade_in: (secs: 2, nanos: 0),
							show_for: Some((secs: 2, nanos: 0)),
							fade_out: (secs: 2, nanos: 0),
					)),
					brightness: 1.0,
				),
		],
		wake: [
				ImageAnimation(
					file: "/home/cozy/matrix/cat3.gif",
					scale: 1.0,
					angle: 0.0,
					translation: (2.0, 3.0),
					time: Fade((
							fade_in: (secs: 2, nanos: 0),
							show_for: Some((secs: 2, nanos: 0)),
							fade_out: (secs: 2, nanos: 0),
					)),
					brightness: 1.0,
				),
		],
		shutdown: [
				ImageAnimation(
					file: "/home/cozy/matrix/cat3.gif",
					scale: 1.0,
					angle: 0.0,
					translation: (2.0, 3.0),
					time: Fade((
							fade_in: (secs: 2, nanos: 0),
							show_for: Some((secs: 2, nanos: 0)),
							fade_out: (secs: 2, nanos: 0),
					)),
					brightness: 1.0,
				),
		],
		display_enabled: true,
		display_brightness: Med,
		builtin_anims_enabled: false,
		off_when_unplugged: false,
		off_when_suspended: false,
		off_when_lid_closed: false,
		brightness_on_battery: Low,
		builtin_anims: (
				boot: GlitchConstruction,
				awake: BinaryBannerScroll,
				sleep: BannerSwipe,
				shutdown: GlitchOut,
		),
)
		'';
		};
  };
}
