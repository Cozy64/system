{pkgs, ...}:
{
  home-manager.users.cozy = {
    programs = {
		bash = {
			enable = true;
			bashrcExtra='' 
			if [[ "$CONTAINER_ID" == *"arch"* ]]; then 
			echo $CONTAINER_ID
			PS1="\[$(tput setaf 4)\]\u@arch \W> \[$(tput sgr0)\]"
			elif [[ "$CONTAINER_ID" == *"ubuntu"* ]]; then 
			echo $CONTAINER_ID
			PS1="\[$(tput setaf 1)\]\u@ubuntu \W> \[$(tput sgr0)\]"
			else 
			PS1=$PS1 
			fi
				#alias boot="sudo nixos-rebuild boot"
				alias boot="sudo nixos-rebuild boot --flake /home/cozy/system#miner"
				alias test="sudo nixos-rebuild test --flake /home/cozy/system#miner"
				alias fhs="export PS1='\[$(tput setaf 1)\]\u@\h \W> \[$(tput sgr0)\]' export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH:$LD_LIBRARY_PATH"
				alias list="sudo nixos-rebuild list-generations"
				alias hibernate="systemctl hibernate"
				alias switch="sudo nixos-rebuild switch --flake /home/cozy/system#miner"
				alias update="nix flake update"
				alias metadata="nix flake metadata /home/cozy/system"
				alias garbage="sudo nix-collect-garbage -d"
				alias rollback="sudo nix-channel --rollback"
        alias cdnix="cd /home/cozy/system"
				alias vinix="nvim /home/cozy/system/base.nix"
				alias vihome="nvim /home/cozy/system/home-manager.nix"
				alias viflake="nvim /home/cozy/system/flake.nix"
				alias viware="nvim /home/cozy/system/disk-amd.nix"
				alias vihypr="nvim /home/cozy/.config/hypr/hyprland.conf"
				alias VI="sudo -E nvim"
				alias NVIM="sudo -E nvim"
				alias NNN="sudo -E nnn"
				#alias installarch="distrobox create --root --init -n arch -i archlinux:latest"
				alias installarch="distrobox create --root --init -n arch -i quay.io/toolbx/arch-toolbox:latest"
				alias installubuntu="distrobox create --root --init -n ubuntu -i quay.io/toolbx/ubuntu-toolbox:latest"
				#alias installarch="distrobox create --root -n arch -i quay.io/toolbx/arch-toolbox:latest"
				alias deletearch="distrobox rm --root arch"
				alias deleteubuntu="distrobox rm --root ubuntu"
				alias arch="distrobox enter --root arch"
				alias ubuntu="distrobox enter --root ubuntu"
				alias stoparch="distrobox stop --root arch"
				alias stopubuntu="distrobox stop --root ubuntu"
				alias xampp="/opt/lampp/xampp"
				alias venv="source /home/cozy/pythonenv/bin/activate"
			'';
		};
    };
	};

}
