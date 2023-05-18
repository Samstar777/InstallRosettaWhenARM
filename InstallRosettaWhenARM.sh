#!/bin/bash

# 15/01/2021
# Creator : Salim Ukani AKA Samstar

# This script will check if Mac hardware is ARM-based (Apple Silicon, starting from M1) or Intel-based, and trigger Rosetta installation if required.

MacArchitecture=$(uname -p)

if [ "$MacArchitecture" = "arm" ];
then echo "Mac is ARM based"
	# Check Rosetta LaunchDaemon. If no LaunchDaemon is found,
	# perform a non-interactive install of Rosetta.
	if [[ ! -f "/Library/Apple/System/Library/LaunchDaemons/com.apple.oahd.plist" ]]; 
	then /usr/sbin/softwareupdate --install-rosetta --agree-to-license
		
		if [[ $? -eq 0 ]]; then
			echo "Rosetta has been successfully installed."
		else
			echo "Rosetta installation failed!"
			exitcode=1
		fi
	else
		echo "Rosetta is already installed. Nothing to do."
	fi
else echo "Mac is not ARM-based"
fi

exit $exitcode