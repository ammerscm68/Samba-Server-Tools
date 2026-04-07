# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
# ******************** Eigene Alias ********************
alias packlist='echo sudo dpkg -l Pipe grep " xxx "'
alias apt-orders='echo apt search --names-only xxx && echo apt show xxx && echo apt install xxx'
alias update='sudo dpkg --configure -a && sudo apt update && sudo apt --assume-yes upgrade && sudo apt --assume-yes dist-upgrade &&  sudo apt --assume-yes autoremove && sudo apt autoclean'
alias pimc='sudo mc'
alias neustart='echo && echo Reboot System && sudo reboot'
alias cpu-temp='clear && vcgencmd measure_temp'
alias cpu-volt='clear && vcgencmd measure_volts'
alias cpu-takt='clear && vcgencmd measure_clock arm'
alias cpu-com='clear && vcgencmd commands'
alias herunterfahren='echo && echo Shutdown System && sudo shutdown -h 0'
alias piconfig='sudo raspi-config'
alias cls='clear'
alias swap-off='sudo swapoff -a'
alias swap-on='sudo swapon -a'
alias swap-disable='sudo service dphys-swapfile stop && free && sudo systemctl disable dphys-swapfile && sudo apt-get purge dphys-swapfile'
alias swap-enable='sudo systemctl enable dphys-swapfile && sudo systemctl enable dphys-swapfile'
alias datum='date'
alias uhrzeit='date'
alias autoupdate-log='sudo cat /var/log/unattended-upgrades/unattended-upgrades.log'
alias pi-uptime='uptime -p'
alias xdir='ls -la'
alias setting-ipv6='./ipv6.sh'
alias setipv6='./ipv6.sh'
alias getipv6='ip a ls |grep inet6'
alias config-bash='sudo nano /home/pi/.bashrc'
alias speicher='df -h'
alias usbpower='echo max_usb_current = 1 | sudo tee -a /boot/config.txt'
alias btdisable='echo dtoverlay=pi3-disable-bt | sudo tee -a /boot/config.txt && sudo systemctl disable hciuart'
alias devices='clear && echo && sudo lsblk -f && echo ----------------------------------------------------------------------------------------- && sudo lsblk -o name,label,partuuid'
alias btscan='sudo hcitool -i hci0 lescan'
alias firmware-version='sudo rpi-eeprom-update'
alias bootloader-update='sudo nano /etc/default/rpi-eeprom-update && cd /lib/firmware/raspberrypi/bootloader/stable/ && ls -l && echo sudo rpi-eeprom-update -d -f pieeprom-[Aktuelles Datum].bin'
alias bootloader-version='vcgencmd bootloader_version'
alias bootloader-config='vcgencmd bootloader_config'
alias osversion='lsb_release -dr'
alias fail2ban-log='clear && echo ***fail2ban log*** && echo && sudo tail -f /var/log/fail2ban.log'
alias fail2ban-ssh='clear && echo ***fail2ban ssh*** && echo && sudo fail2ban-client status sshd'
alias fail2ban-webmin='clear && echo ***fail2ban webmin*** && echo && sudo fail2ban-client status webmin-auth'
alias fail2ban-status='clear && echo ***fail2ban status*** && echo && sudo fail2ban-client status'
alias fail2ban-service='clear && echo ***fail2ban restart*** && echo && sudo systemctl status fail2ban'
alias fail2ban-unban='clear && echo ***fail2ban all unban*** && sudo fail2ban-client unban --all'
alias portscan='clear && echo && echo ***PortScan*** Please wait ... && sudo nmap -p- 192.168.178.212 -sU -sN && echo && echo done'
alias networkmanager='sudo nmtui'
alias getfstab='sudo nano /etc/fstab'
alias firmware-update='sudo wget https://raw.github.com/Hexxeh/rpi-update/master/rpi-update -O /usr/bin/rpi-update && sudo chmod +x /usr/bin/rpi-update && sudo rpi-update && echo Reboot System && sudo reboot'
alias samba-config='sudo nano /etc/samba/smb.conf'
alias samba-restart='clear && echo && echo ***Restart Samba-Server*** && sudo systemctl daemon-reload && sleep 3 && sudo systemctl restart smbd; sleep 5; systemctl status smbd'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#  ************* eigene Funktionen ***************
#
# -------------Samba-Server-----------------
# Disk-Tools (sicherer Datenträger-Manager)
#
#            April 2026
#   Version 1.0 von Mario Ammerschuber
#
# WARNNG: Kann Daten unwiderruflich löschen!
# ------------------------------------------

# Globale Variablen deklaration
SAMBAMAINUSER="samba"

# Freigabenamen und dazugehöriger Mountpoint (Name frei wählbar)
# Achtung:  Die Mountpoints vorher anlegen ! (Rechte werden automatisch vergeben)
declare -A SAMBA_SHARES
SAMBA_SHARES=(
  ["Gewamed"]="/home/samba/shared1"
  ["Freigabe2"]="/home/samba/shared2"
  ["Freigabe3"]="/home/samba/shared3"
)
# Reihenfolge der Anzeige im Auswahlmenu
SHARE_ORDER=("Gewamed" "Freigabe2" "Freigabe3")

# Die Variable für das Ergebnis (leer)
MOUNTPOINT=""

select_mountpoint() {
  local share_names=("${!SAMBA_SHARES[@]}")

  printf "\n✅--- Verfügbare Samba-Freigaben ---✅\n"

  # Die Eingabeaufforderung für 'select'
  local PS3
  printf -v PS3 "\nBitte Freigabenamen wählen: (1-%s oder %s) > " "${#SHARE_ORDER[@]}" "$(( ${#SHARE_ORDER[@]} + 1 ))"


  # 'select' erzeugt automatisch das Menü aus den Namen
  select name in "${SHARE_ORDER[@]}" "Abbrechen"; do
    if [ "$name" = "Abbrechen" ]; then
      printf "\n⚠️ Vorgang durch Benutzer abgebrochen.\n\n"
      return 1
    elif [ -n "$name" ]; then
      # Hier passiert die Zuweisung: Der Pfad zum Namen wird in MOUNTPOINT gespeichert
      MOUNTPOINT="${SAMBA_SHARES[$name]}"
      printf "\n✅ Folgende Freigabe wurde gewählt: %s\n" "$name"
      printf "📍 Zielpfad (Mountpoint): %s\n\n" "$MOUNTPOINT"
      # Warten bis eine Taste gedrückt wird 
      printf "\n⌨️ Weiter mit beliebiger Taste...\n"
      # -n 1 (ein Zeichen), -s (stumm), -r (keine Backslash-Interpretation)
      read -n 1 -s -r

      return 0
    else
      printf "\n❌ Ungültige Wahl. Bitte eine Nummer aus der Liste eingeben.\n\n"
    fi
  done
}

checkparameter() {
  red='\033[0;31m'
  reset='\033[0m'

  if [ $# -eq 0 ]; then
    printf "${red}Fehler:${reset} Gerätename erforderlich (z.B. /dev/sdb)\n\n"
    return 1
  fi

  local dev="$1"

  if [[ "$dev" != /dev/* ]]; then
    dev="/dev/$dev"
  fi

  if [ ! -b "$dev" ]; then
    printf "${red}Fehler:${reset} %s ist kein Blockgerät oder existiert nicht!\n\n" "$dev"
    return 1
  fi

  if [[ ! "$dev" =~ ^/dev/sd[a-z]+$ ]]; then
    printf "${red}Fehler:${reset} Nur ganze Laufwerke wie /dev/sdb erlaubt (keine Partitionen).\n\n"
    return 1
  fi

  # Ermittle das Gerät, auf dem das Root-Dateisystem liegt (z.B. /dev/sda)
  local root_dev=$(lsblk -no PKNAME $(findmnt -nvo SOURCE /))
    # Vergleiche das eingegebene Device mit dem Root-Device
    if [[ "$dev" == *"$root_dev"* ]]; then
    printf "\n"
    printf "${red}STOPP:${reset} %s ist das Systemlaufwerk! Zugriff verweigert.\n" "$dev"
    printf "\n"
    return 1
  fi
}

format() {
  red='\033[0;31m'
  reset='\033[0m'
  clear

  local dev
  local label="DATA"
  local uuid

  dev="/dev/$(basename "$1")"

  # Expliziter Aufruf → Fehlermeldung SICHTBAR
  checkparameter "$dev" || return 1

  printf "\nℹ️ Prüfe gemountete Partitionen...\n\n"
  smballdismount "$dev" || return 1

  # HARTE SYNCHRONISATION
  printf "\nℹ️ Sync + Partitionstabelle neu laden...\n\n"
  sync
  sleep 2
  sudo blockdev --rereadpt "$dev" 2>/dev/null || sudo partprobe "$dev"
  sleep 2

  printf "\nℹ️ Laufwerk: %s\n\n" "$dev"
  lsblk "$dev"
  printf "\n"

  printf "${red}WARNUNG:${reset} Alle Daten und Partitionen auf %s werden GELÖSCHT!\n\n" "$dev"
  printf "\nNeue GPT-Tabelle → ext4-Partition\n\n"

  read -r -p "❓ Letzte Chance: Wirklich alles löschen? (ja/nein): " bestaetigung2
  printf "\n"
  if [ "$bestaetigung2" != "ja" ]; then
    printf "Abgebrochen.\n\n"
    return 1
  fi

  printf "${red}Starte Formatierung...${reset}\n\n"
  sudo wipefs -a "$dev"
  sudo parted -s "$dev" mklabel gpt
  sudo parted -s "$dev" mkpart primary ext4 1MiB 100%
  sudo partprobe "$dev"
  sleep 2

  if [ ! -b "${dev}1" ]; then
    printf "${red}FEHLER:${reset} Partition ${dev}1 nicht erstellt!\n\n"
    return 1
  fi

  # Partition erstellen
  sudo mkfs.ext4 -F -L "$label" "${dev}1"
  sleep 2

  printf "✅ Fertig: → %s (ext4)-Partition\n\n" "${dev}1"

  # Frage ob Mountpoint in fstab geschrieben werden soll (inkl. Mounten)
  read -r -p "❓ Soll gleich ein Eintrag in der fstab erstellt werden ? (ja/nein): " fstab_antwort
  printf "\n"
    if [ "$fstab_antwort" = "ja" ]; then
    clear
    setfstab "$dev" || return 1
    else
    printf "\n"
    fi
}

setfstab() {
  red='\033[0;31m'
  reset='\033[0m'
  clear

  local dev
  local part
  local uuid
  local fstype

  dev="/dev/$(basename "$1")"

  # Expliziter Aufruf → Fehlermeldung SICHTBAR
  checkparameter "$dev" || return 1

  printf "\nℹ️ Prüfe ob Partition noch gemountet ist...\n"
  smbdismount "$dev" || return 1

  # HARTE SYNCHRONISATION
  printf "\nℹ️ Sync + Partitionstabelle neu laden...\n\n"
  sync
  sleep 2
  sudo blockdev --rereadpt "$dev" 2>/dev/null || sudo partprobe "$dev"
  sleep 2

  # Partition finden
  part=$(lsblk -pnlo NAME,FSTYPE "$dev" | awk '$2!="" {print $1; exit}')
  if [ -z "$part" ]; then
    printf "\n❌ Keine Partition mit Dateisystem auf %s gefunden!\n" "$dev"
    lsblk "$dev"
    return 1
  fi

  # blkid -p (prober) erzwingt das direkte Lesen vom Gerät ohne Cache
  uuid=$(sudo blkid -p -s UUID -o value "$part")
  fstype=$(sudo blkid -p -s TYPE -o value "$part")

  if [ -z "$uuid" ] || [ -z "$fstype" ]; then
    printf "${red}Fehler:${reset} UUID oder Dateisystem konnte nicht ermittelt werden.\n\n"
    return 1
  fi

  printf "ℹ️ UUID: %s\n" "$uuid"
  printf "ℹ️ Dateisystem: %s\n" "$fstype"
  printf "ℹ️ Mountpunkt: %s\n\n" "$MOUNTPOINT"

  read -r -p "❓ fstab-Eintrag jetzt erstellen? (ja/nein): " antwort
  printf "\n"
  if [ "$antwort" != "ja" ]; then
    printf "Abgebrochen.\n\n"
    return 1
  fi

  # Existierenden Eintrag für diesen Mountpoint entfernen (egal welche UUID dort stand)
  if grep -q "[[:space:]]$MOUNTPOINT[[:space:]]" /etc/fstab; then
    printf "\nℹ️  Entferne alten fstab-Eintrag für %s...\n" "$MOUNTPOINT"
    sudo sed -i "\|[[:space:]]$MOUNTPOINT[[:space:]]|d" /etc/fstab
  fi

  # Neuen Eintrag in fstab schreiben
  echo "UUID=$uuid  $MOUNTPOINT  $fstype  defaults,noatime,nofail  0  2" | sudo tee -a /etc/fstab >/dev/null

  printf "\n✅ fstab-Eintrag erstellt.\n\n"

  # Nach dem fstab-Eintrag: Mount-Abfrage
  read -r -p "❓ Soll das Laufwerk auch gleich gemoutet werden ? ($part → $MOUNTPOINT) (ja/nein): " mount_antwort
  printf "\n"
    if [ "$mount_antwort" = "ja" ]; then
    clear
    smbmount "$dev" || return 1
    else
    printf "\n"
    fi
}

smbmount() {
  local red='\033[0;31m'
  local reset='\033[0m'

  local dev="/dev/$(basename "$1")"
  checkparameter "$dev" || return 1

  # Auswahl des Mountpoints abfragen
  select_mountpoint || return 1

  # Wir ermitteln die Partition (z.B. /dev/sdb1), falls nur /dev/sdb angegeben wurde
  local part=$(lsblk -pnlo NAME,FSTYPE "$dev" | awk '$2!="" {print $1; exit}')

  if [ -z "$part" ]; then
    printf "${red}Fehler:${reset} Keine Partition mit Dateisystem auf %s gefunden!\n" "$dev"
    return 1
  fi

  # Mount-Abfrage
  printf "\n"
  read -r -p "❓ Laufwerk jetzt mounten? ($part → $MOUNTPOINT) (ja/nein): " mount_antwort
  printf "\n"

  if [ "$mount_antwort" = "ja" ]; then
    # Prüfen, ob bereits etwas dort gemountet ist
    if mountpoint -q "$MOUNTPOINT"; then
       printf "\n⚠️ Hinweis: %s ist bereits belegt. Versuche trotzdem zu mounten...\n" "$MOUNTPOINT"
    fi

    if sudo mount "$part" "$MOUNTPOINT"; then
      # ERST wenn der Mount steht, ändern wir die Rechte auf dem EXTERNEN Medium
      printf "\n🔓 Öffne Schreibrechte für Samba-User (%s)...\n" "$SAMBAMAINUSER"

      sudo chown "$SAMBAMAINUSER":"$SAMBAMAINUSER" "$MOUNTPOINT"
      sudo chmod 775 "$MOUNTPOINT"

      # Optional: Auch Unterordner anpassen, falls vorhanden (Achtung:  dauert bei vielen Dateien sehr lange --> Geduld)
      # sudo chmod -R 775 "$MOUNTPOINT" 

      # --- NEU: Samba-Refresh ---------------------------------------------
      printf "\n🔄 Starte Samba-Dienst neu...\n"
      sudo systemctl daemon-reload && sleep 2 && sudo systemctl restart smbd
      # --------------------------------------------------------------------

      printf "\n✅ Erfolgreich: %s ist bereit für Samba.\n\n" "$MOUNTPOINT"
    else
      printf "\n❌ Mount von %s fehlgeschlagen!\n\n" "$part"
      return 1
    fi
  else
     printf "\nℹ️ Kein Mount durchgeführt. (%s bleibt im Sicherheitsmodus 555)\n\n" "$MOUNTPOINT"
  fi
}

smbdismount() {
  local dev="/dev/$(basename "$1")"

  # Parameter-Check
  checkparameter "$dev" || return 1

  # 1. Auswahl des spezifischen Mountpoints abfragen
  select_mountpoint || return 1

  # 2. Prüfen, ob GENAU dieser Pfad gerade gemountet ist
  if ! mountpoint -q "$MOUNTPOINT"; then
    printf "\nℹ️ %s ist zurzeit nicht gemountet.\n" "$MOUNTPOINT"
    sudo chmod 555 "$MOUNTPOINT" 2>/dev/null
    printf "\n🔒 Sicherheits-Modus: %s ist schreibgeschützt (555).\n\n" "$MOUNTPOINT"
    return 0
  fi

  # 3. Benutzer fragen (zeigt auch an, welches Device dort hängt)
  local current_source=$(findmnt -no SOURCE "$MOUNTPOINT")
  printf "\nℹ️ Aktiv gemountet: %s (auf %s)\n" "$MOUNTPOINT" "$current_source"
  printf "\n"
  read -r -p "❓ Diese Freigabe jetzt dismounten? (ja/nein): " confirm
  [[ "$confirm" != "ja" ]] && { printf "Abgebrochen.\n\n"; return 1; }

  # --- Stop Samba-Server ----------------------------------------------
  printf "\n🔄 Trenne Samba-Verbindungen...\n"
  sudo systemctl stop smbd
  sleep 3
  # --------------------------------------------------------------------

  # 4. Gezielter Dismount des Verzeichnisses
  printf "\nℹ️ Dismount %s → Bitte warten..." "$MOUNTPOINT"

  if sudo umount "$MOUNTPOINT" 2>/dev/null || {
       printf "\n⚠️ Dismount blockiert! Prozesse killen... ";
       sudo fuser -km "$MOUNTPOINT" 2>/dev/null;
       sleep 1; 
       sudo umount "$MOUNTPOINT"; 
     }; then
    printf "✅\n"

    # 5. FINALE SICHERHEIT: Verzeichnis sperren
    sudo chmod 555 "$MOUNTPOINT" 2>/dev/null
    printf "\n🔒 Verbindung getrennt. %s ist jetzt sicher (555).\n" "$MOUNTPOINT"
    local success=1
  else
    printf "\n❌ Dismount von %s fehlgeschlagen!\n" "$MOUNTPOINT"
    local success=0
  fi

  # --- Starte Samba-Server wieder -------------------------------------
  printf "\n🔄 Starte Samba-Dienst neu...\n"
  sudo systemctl start smbd
  sleep 3
  # --------------------------------------------------------------------

  [[ $success -eq 1 ]] && printf "\n✅ Vorgang erfolgreich abgeschlossen.\n\n"
  [[ $success -eq 0 ]] && return 1
}

smballdismount() {
  local dev="/dev/$(basename "$1")"

  # Parameter-Check: Falls kein Argument übergeben wurde
  checkparameter "$dev" || return 1

  # 1. Alle Partitionen des Laufwerks finden
  local partitions=($(lsblk -pnlo NAME "$dev" | grep -v "^$dev$"))

  # 2. Prüfen, ob überhaupt Partitionen auf der Hardware existieren
  if [ ${#partitions[@]} -eq 0 ]; then
    printf "\nℹ️ Keine Partitionen auf %s gefunden.\n" "$dev"
    sudo chmod 555 "$MOUNTPOINT" 2>/dev/null
    printf "🔒 Sicherheits-Modus: %s ist schreibgeschützt (555).\n\n" "$MOUNTPOINT"
    return 0
  fi

  # 3. Ermitteln, welche Partitionen AKTUELL gemountet sind
  local mounted_parts=()
  for part in "${partitions[@]}"; do
    if findmnt "$part" >/dev/null; then
      mounted_parts+=("$part")
    fi
  done

  # 4. Wenn bereits alles ungemountet ist
  if [ ${#mounted_parts[@]} -eq 0 ]; then
    printf "\nℹ️ Keine der Partitionen auf %s ist zurzeit gemountet.\n" "$dev"
    sudo chmod 555 "$MOUNTPOINT" 2>/dev/null
    printf "🔒 Sicherheits-Modus: %s ist schreibgeschützt (555).\n\n" "$MOUNTPOINT"
    return 0
  fi

  # 5. Benutzer fragen
  printf "\nℹ️ Aktiv gemountet: %s\n" "${mounted_parts[*]}"
  read -r -p "❓ Diese Partition(en) jetzt dismounten? (ja/nein): " confirm
  [[ "$confirm" != "ja" ]] && { printf "Abgebrochen.\n\n"; return 1; }

  # --- Stop Samba-Server ----------------------------------------------
  printf "\n🔄 Trenne Samba-Verbindungen...\n"
  sudo systemctl stop smbd  # Stoppen ist hier sicherer als Restart
  sleep 2
  # --------------------------------------------------------------------

  # 6. Schleife über alle gemounteten Partitionen
  local count=0
  for part in "${mounted_parts[@]}"; do
    printf "→ Dismount %s... " "$part"

    # Versuche Dismount (Erst Normal, dann mit fuser)
    if sudo umount "$part" 2>/dev/null || { 
         printf "\n⚠️ Dismount ist blockiert! Prozesse killen... "; 
         sudo fuser -km "$part" 2>/dev/null; 
         sleep 2; 
         sudo umount "$part"; 
       }; then
      printf "✅\n"
      ((count++))
    else
      printf "❌ Dismount fehlgeschlagen!\n"
      return 1
    fi
  done

  # 7. FINALE SICHERHEIT (Der Kern des Tricks)
  # Wenn nach der Schleife nichts mehr gemountet ist, ziehen wir die Rechte dauerhaft ein
  if ! findmnt --source "$dev" >/dev/null && ! findmnt "$MOUNTPOINT" >/dev/null; then
    sudo chmod 555 "$MOUNTPOINT" 2>/dev/null
    printf "\n🔒 Alle Partitionen dismountet. %s ist jetzt sicher (555).\n" "$MOUNTPOINT"
    local success=1
  fi

  # --- Starte Samba-Server wieder -------------------------------------
  printf "\n🔄 Starte Samba-Dienst neu...\n"
  sudo systemctl start smbd
  # --------------------------------------------------------------------

  printf "\n✅ %s/%s Partition(en) erfolgreich bearbeitet.\n\n" "$count" "${#mounted_parts[@]}"
}
