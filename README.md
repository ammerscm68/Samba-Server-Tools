# Samba-Server Tools for easy Management a "Raspberry Pi" --- Simple NAS
  
  The following commands can be executed:<br>
  1.  smbusermanager  (Interactive creation or deletion of a user for Linux and SAMBA)
  2.  smbconfig   (Interactive configuration of the Samba-Server)
  3.  format sdb or sdb1  (sdb is an example) <br>
  4.  samba-config  (Displays the current contents of the "smb.conf" file)
  5.  getfstab  (Displays the current contents of the fstab file)
  6.  setfstab sdb (sdb is an example) <br>
  7.  smbmount sdb1 (sdb1 is an example) <br>
  8.  smbdismount sdb1 (sdb1 is an example) <br>
  9.  smballmountsdismount (dismounts all SAMBA mountet devices) <br>
 10.  smbcontrol start (allowed parameters start, stop, restart) <br>
 11.  autoupdate -c | -d  (Parameter [-c] = create autoupdate - [-d] = delete autoupdate <br>
 12.  smbsetstaticip (interactively switch to a static IP address) <br>
 13.  webmininstall (interactive Installation of the graphical user Interface "Webmin") <br>
 14.  getdevices (Displays all all available drives)
 15.  bootconfig (Boot Customizations- USB, Bluetooth and WiFi)
 16.  smbcheckosversion (Checks the current OS version)
 17.  checksmbinstall (Checks whether Samba is installed)
 18.  loadsmbconfig (Loads the Samba configuration upon login or installs Samba)
 19.  mountstatus (Shows all mounted shares)
 20.  checksmbconfig (Checks whether if the configuration is valid)
 21.  select_mountpoint (Selection of the desired mount point)
 22.  getipv4    (Displays the current IPv4 Address) 
 23.  webmininstall (Automatic Install "Webmin" for Raspberry Pi Management - [Optional])
 24.  printserverinstall (Installs a CUPS Print-Server with many Printer drivers - [Optional])
  <br>
  Many more simplified commands can be found in the aliases of the .bashrc file. <br>
  
---

<strong>Flash the image to a storage medium (USB stick or microSD card) and then ...</strong> <br>
```bash
# german language
curl -sSL https://raw.githubusercontent.com/ammerscm68/Samba-Server-Tools/main/german/sambainstall.sh | bash
```

  The tools will of course need to be customized for the main user. In my case, I simply named the user "samba". <br>
  You can then create multiple users who, for example, are only allowed <br>
  to connect to a single share but are not allowed to log in via SSH or <br>
  directly to the Raspberry Pi. <br>
  <br>
