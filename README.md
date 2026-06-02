# Samba-Server Tools for easy Management a "Raspberry Pi" --- Simple NAS
  
  The following commands can be executed:<br>
  1.  smbusermanager  (Interactive creation or deletion of a user for Linux and SAMBA)
  2.  smbconfig   (Interactive configuration of the Samba-Server)
  3.  format /dev/sdb or sdb  (sdb is an example) <br>
  4.  samba-config  (Displays the current contents of the "smb.conf" file)
  5.  getfstab  (Displays the current contents of the fstab file)
  6.  setfstab /dev/sdb or sdb  (sdb is an example) <br>
  7.  smbmount /dev/sdb or sdb (sdb is an example) <br>
  8.  smbdismount /dev/sdb or sdb (sdb is an example - only dismount partition 1) <br>
  9.  smballpartdismount /dev/sdb or sdb (sdb is an example - dismounts all partitions) <br>
 10.  smbcontrol start (allowed parameters start, stop, restart) <br>
 11.  autoupdate -c | -d  (Parameter [-c] = create autoupdate - [-d] = delete autoupdate <br>
 12.  smbsetstaticip (interactively switch to a static IP address) <br>
 13.  webmininstall (interactive Installation of the graphical user Interface "Webmin") <br>
  <br>
  Many more simplified commands can be found in the aliases of the .bashrc file. <br>
  <br>
---
  The tools will of course need to be customized for the main user. <br>
  In my case, I simply named the user "samba". <br>
  You can then create multiple users who, for example, are only allowed <br>
  to connect to a single share but are not allowed to log in via SSH or <br>
  directly to the Raspberry Pi. <br>
  <br>
