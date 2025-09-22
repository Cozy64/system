  {
		openssh = {
			enable = true;
			ports = [ 6969 ];
			settings = {
				PasswordAuthentication = true;
				#AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
				#UseDns = true;
				#X11Forwarding = false;
				PermitRootLogin = "prohibit-password";
			};

		};

  }
