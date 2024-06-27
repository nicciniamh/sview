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
rules="10-systemctl-polkit.rulesr"
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
install --backup -m 644 ${policy} ${policy_path}/${policy} || abort "Error installing policy"
install --backup -D -m 644 ${rules} ${rules_path}/${rules} || abort "Error installing rules"
install --backup -m 755 sview ${binloc}/sview || abort "Error installing program"
xdg-desktop-menu install --novendor ${desktop}
