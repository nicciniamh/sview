#!/bin/bash
we=$(basename $0)
function abort() {
	echo $@ >&1
	echo "Aborting."
	exit 1
}
modules="gi pystemd"
policy_path="/usr/share/polkit-1/actions"
rules_path="/usr/share/polkit-1/rules"
policy="com.ducksfeet.sview.policy"
rules="10-systemctl-polkit.rules"
desktop="sview.desktop"
binloc="/usr/bin"
cat << EOF
This script installs sview - the Linux Systemd Unit Viewer.
Locations:
Policy: ${policy_path}/${policy}
rules: ${rules_path}/${rules}
Program: ${binloc}
EOF

if [[ "$UID" != "0" ]] ; then
	echo "$we: error: this script must be run as root" >&1
	exit 1
fi
echo "Checking for required modules: ${modules}"
for module in $modules ; do
	./testmod ${module} || abort "Cannot import ${module} - this is required for installation"
done
echo "Modules are ok, installing files"
if [[ -f "${policy_path}/${policy}" ]] ; then
	while true ; do
		read -p ""${policy_path}/${policy}" exists, overwrite? (it will be backed up) [Yes/no]: " answer
		answer=${answer:=yes}
		if [[ "$answer" == "no" ]] ; then
			echo "${policy_path}/${policy} not overwritten, this might not work"
			break
		elif [[ "$answer" == "Yes" ]] || [[ "$answer" == "yes" ]] ; then
			install --backup -m 644 ${policy} ${policy_path}/${policy} || abort "Error installing policy"
			break
		fi
		echo "You must answer yes or no"
	done
fi
install --backup -D -m 644 ${rules} ${rules_path}/${rules} || abort "Error installing rules"
install --backup -m 755 sview ${binloc}/sview || abort "Error installing program"
xdg-desktop-menu install --novendor ${desktop}
