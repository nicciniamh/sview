# sview - The Linux Systemd Unit Viewer

## Description
This program loads a list of systemd services and displays them with check boxes for "Active" and "Running". Toggling these checkboxes will trigger systemd commands to enable or disable the unit, or start or stop the unit 

## Warning
I wrotet this yesterday, while watching TV. This should be considered ALPHA code, and should be treated as such. 

## Installation
To use sview, the follwing python modules are required: 

|Module   |Installation Candidate|
|---------|----------------------|
|    gi   | pygobject, cairo     |
| pystemd | python3-pystemd      |


If these modules are not installed, check your distributions installation instructions.

### setup.sh
The script, setup.sh, must be run as root. It will install the program, policy file, polkit helper and the desktop menu file. 

## Bugs 
probably a lot. 

## Documentation
This is it, sadly.
