# Samba-Server Tools for easy Management a "Raspberry Pi" --- Simple NAS
  
  The following commands can be executed:<br>
  1.  smbusermanager  (Interactive creation or deletion of a user for Linux and SAMBA)
  2.  smbconfig   (Interactive configuration of the Samba-Server)
  3.  format /dev/sdb or sdb  (sdb is an example) <br>
  4.  setfstab (/dev/sdb or sdb  (sdb is an example) <br>
  5.  smbmount /dev/sdb or sdb (sdb is an example) <br>
  6.  smbdismount /dev/sdb or sdb (sdb is an example - only dismount partition 1) <br>
  7.  smballpartdismount /dev/sdb or sdb (sdb is an example - dismounts all partitions) <br>
  8.  smbcontrol start (allowed parameters start, stop, restart) <br>
  <br>
  Many more simplified commands can be found in the aliases of the .bashrc file. <br>
  <br>
  *************************************************************************<br>
  Version 2.1 - Interactive User Manager added. <br>
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++<br>
  Version 2.0 has been completely redesigned. Samba server configuration is <<< now entirely interactive >>>. <br>
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++<br>
  Version 1.1 included some improvements to the logic and a bug fix. <br>
  On Version 1.1 allows the management of a maximum of 3 shares. <br>
  ***************************************************************************<br>
  <br>
  Simply copy the aliases and functions into the [.bashrc] file of the mainuser, restart the <br>
  Raspberry Pi, and you'll have a simple NAS-Server. <br>
  <br>
  The tools will of course need to be customized for the main user. <br>
  In my case, I simply named the user "samba". <br>
  You can then create multiple users who, for example, are only allowed <br>
  to connect to a single share but are not allowed to log in via SSH or <br>
  directly to the Raspberry Pi. <br>
  <br>
