{pkgs, ...}:
{
	environment.systemPackages = with pkgs; ]
		rocmPackages.rocminfo
    btop-rocm
		

	];


}
