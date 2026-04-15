# Samba-Server Tools for easy management a raspberry pi simple NAS
  
  The following commands can be executed:<br>
  1.  smbconfig
  2.  format /dev/sdb or sdb  (sdb is an example) <br>
  3.  setfstab (/dev/sdb or sdb  (sdb is an example) <br>
  4.  smbmount /dev/sdb or sdb (sdb is an example) <br>
  5.  smbdismount /dev/sdb or sdb (sdb is an example - only dismount partition 1) <br>
  6.  smballpartdismount /dev/sdb or sdb (sdb is an example - dismounts all partitions) <br>
  7.  smbcontrol start (allowed parameters start, stop, restart) <br>
  <br>
  Many more simplified commands can be found in the aliases of the .bashrc file. <br>
  <br>
  On Version 1.1 allows the management of a maximum of 3 shares. <br>
  Version 1.1 included some improvements to the logic and a bug fix. <br>
  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++<br>
  Version 2.0 has been completely redesigned. Samba server configuration is <<< now entirely interactive >>>. <br>
  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++<br>
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
  sudo useradd -M -s /sbin/nologin [netuser] <br>
  sudo usermod -aG users [netuser] <br>
  sudo smbpasswd -a [netuser]    ----> et the Samba password for <netuser> here. <br>
  sudo smbpasswd -e [netuser]    ----> User activate <br>
  <br>
  [netuser] - any username without rights on the Raspberry Pi (except on the respective share) <br>
