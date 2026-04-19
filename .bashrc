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
alias devices='clear && echo && sudo lsblk -f && echo -------------------------------------------------------------------------------------------- && sudo lsblk -o name,label,partuuid'
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
#              April 2026
#   Version 2.3 von Mario Ammerschuber
#
# WARNNG: Kann Daten unwiderruflich löschen!
# ------------------------------------------

# ****** Globale Variablen deklaration ******
# SAMBA-Server Hauptbenutzer
SAMBAMAINUSER=${SAMBAMAINUSER:-$USER}

# 2. Benutzer für Netzlaufwerkverbindungen
EXTRAUSER=""

# Arrays global am Anfang definieren
declare -A SAMBA_SHARES
declare -a SHARE_ORDER
export CONFIG_FILE="/etc/samba/smb.conf"

RED='\033[0;31m' # rote Schrift
RESET='\033[0m'  # rote Schrift - Ende

# Die Variable für das Ergebnis (leer)
MOUNTPOINT=""

checksudo() {
# Prüfen ob "Sudo" installiert ist
    if ! command -v sudo &> /dev/null; then
    printf "\n❌ Fehler: 'sudo' ist nicht installiert.\n\n"
    printf "\n📍 Bitte melden Sie sich als 'Root' an und installieren es mit: > apt update && apt upgrade && apt install sudo\n\n"
    return 1
  fi
}

smbusermanager() {
    # Prüfen ob "sudo" installiert ist
    checksudo || return 1

    # Prüfen ob "Samba" installiert ist
    checksmbinstall || return 1

    local netuser="$1" # Erster Parameter
    local choice
    local pass1 pass2 pass3 pass4
    local MAX_LEN=75

    clear # Bildschirm leeren

    # Parameter-Modus oder Menü-Modus?
    if [[ -n "${netuser// /}" ]]; then
        # --- PARAMETER-MODUS ---
        if sudo pdbedit -L -u "$netuser" &>/dev/null; then
          return 1 # Benutzer existiert schon - Keine Meldung ausgeben
        fi
        printf "\n\n👤 Benutzer '%s' zum Samba-Server hinzufügen.\n\n\n" "$netuser"
        choice="1"
    else
        # --- MENÜ-MODUS ---
        printf "\n👤 *** SAMBA BENUTZER-VERWALTUNG ***\n"
        printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
        printf " 1) Benutzer hinzufügen\n"
        printf " 2) Benutzer löschen\n"
        printf " 3) Benutzer auflisten\n"
        printf " 4) Benutzer Kennwort ändern\n"
        printf " 5) Abbrechen\n"
        printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
        read -r -p "Bitte wählen (1-5): " choice

        if [[ ! "$choice" =~ ^[1-5]$ ]]; then
            printf "\n❌ Fehler: '%s' ist keine gültige Auswahl (1-5).\n\n" "$choice"
            return 1
        fi

        if [[ "$choice" == "3" ]]; then
            printf "\n📋 Registrierte Samba-Benutzer:\n"
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
            sudo pdbedit -L | awk -F: '{print "👤 " $1 " (UID: " $2 ")"}'
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n"
            return 0
        elif [[ "$choice" == "5" || -z "$choice" ]]; then
            printf "\n👤 Benutzerverwaltung abgebrochen.\n\n\n"
            return 1
        fi

        printf "\n\n\n"
        read -r -p "👤 Bitte Benutzernamen eingeben: " netuser
    fi

    # ==========================================================================
    # ZENTRALE VALIDIERUNG (Gilt für Parameter UND Menü)
    # ==========================================================================

    # 1. Säuberung (Muss VOR den Checks passieren!) # <--- NEU
    netuser=$(echo "$netuser" | xargs)

    # 2. Leere Eingabe prüfen
    if [[ -z "$netuser" ]]; then
        printf "\n⚠️ Achtung: Kein Benutzername eingegeben - Abbruch!\n\n"
        return 1
    fi

    # 3. Kleinschreibung erzwingen
    if [[ ! "$netuser" =~ ^[a-z0-9]+$ ]]; then
        printf "\n❌ Fehler: Nur Kleinbuchstaben und Zahlen sind erlaubt!\n\n"
        printf "👉 Die Eingabe '%s' ist ungültig.\n\n" "$netuser"
        return 1
    fi

    # 4. Check auf maximale Länge
    if [[ ${#netuser} -gt "$MAX_LEN" ]]; then
        printf "\n❌ Fehler: Der Benutzername ist mit %s Zeichen zu lang (max. %s).\n\n" "${#netuser}" "$MAX_LEN"
        return 1
    fi

    # 5. Mindestens 3 Zeichen füe Benutzername erforderlich
    if [[ ! "$netuser" =~ ^.{3,}$ ]]; then
        printf "\n❌ Fehler: Es sind mindestens 3 Zeichen erforderlich. - Abbuch!\n\n"
        return 1
    fi

    # ==========================================================================

    case "$choice" in
        1) # --- BENUTZER HINZUFÜGEN ---
           # Hinweis: netuser ist bereits gesäubert durch zentrale Validierung #

            # Wir prüfen zuerst, ob er schon in Samba ist
            if sudo pdbedit -L -u "$netuser" &>/dev/null; then
                printf "\n⚠️ Der Benutzer '%s' ist bereits ein Samba-Benutzer!\n\n" "$netuser"
                printf "ℹ️ Nutze Punkt 4, um sein Passwort zu ändern.\n\n"
                return 1
            fi

            # --- Passwort-Validierungsschleife ---
            while true; do
                printf "\n🔐 Kennwort für '%s' festlegen:\n\n" "$netuser"
                read -r -s -p "🔐 Kennwort: " pass1; printf "\n"
                printf "\n"
                read -r -s -p "🔐 Kennwort bestätigen: " pass2; printf "\n"
                printf "\n"

                if [[ -z "$pass1" ]]; then
                    printf "❌ Fehler: Das Kennwort darf nicht leer sein!\n\n"
                elif [[ ${#pass1} -lt 6 ]]; then
                    printf "❌ Fehler: Kennwort zu kurz (mind. 6 Zeichen erforderlich)!\n\n"
                elif [[ "$pass1" != "$pass2" ]]; then
                    printf "❌ Fehler: Die Kennwörter stimmen nicht überein!\n\n"
                else
                    break # Passwort ist valide
                fi

                read -r -p "🔄 Jetzt erneut versuchen? (ja/nein): " retry
                [[ "$retry" != "ja" ]] && { printf "\n⚠️ Vorgang durch Benutzer abgebrochen.\n\n"; return 1; }
            done

            printf "\n⚙️ Der Benutzer wird bearbeitet - Bitte warten...\n\n"
            if id "$netuser" &>/dev/null; then
                printf "\nℹ️ Benutzer '%s' existiert bereits im System - Nur Aktivierung für Samba-Server...\n" "$netuser"
                sudo usermod -aG users "$netuser"
            else
                printf "\n⚙️ Erstelle neuen System-User '%s'...\n\n" "$netuser"
                sudo useradd -M -s /sbin/nologin "$netuser"
                sleep 2
                sudo usermod -aG users "$netuser"
            fi
            sleep 2

            # Passwort an Samba übergeben
            if ! (echo "$pass1"; echo "$pass1") | sudo smbpasswd -s -a "$netuser"; then
                printf "\n❌ Fehler: Das Samba-Kennwort konnte nicht gesetzt werden.\n\n"
                # Nur löschen, wenn er VORHER nicht existierte (Rollback) # <--- NEU (logischer Check)
                # Hier könnte man eine Variable 'is_new_user' nutzen
                printf "⚙️  Bitte prüfen Sie die Systemuser-Leichen manuell.\n"
                smbcontrol restart
                return 1
            fi
            sudo smbpasswd -e "$netuser" > /dev/null
            printf "\n✅ Der Samba-Benutzer '%s' wurde erfolgreich eingerichtet.\n\n" "$netuser"
            printf "\n🔄 Neustart Samba-Server...\n\n";
            smbcontrol restart
            ;;

        4)  # --- BENUTZER PASSWORT ÄNDERN ---
            # Säuberung: Entfernt eventuelle Leerzeichen am Anfang/Ende
            netuser=$(echo "$netuser" | xargs)

            # Erweiterte Prüfung: Existiert er in Linux ODER in Samba?
            if [[ "$(id -un "$netuser" 2>/dev/null)" != "$netuser" ]]; then
             printf "\n⚠️ Achtung: Der Benutzer '%s' existiert nicht - Abbruch!\n\n" "$netuser"
              return 1
            fi

             while true; do
             printf "\n🔐 Neues Kennwort für '%s' festlegen:\n\n" "$netuser"
             read -r -s -p "🔐 Neues Kennwort: " pass3
             printf "\n"
             read -r -s -p "🔐 Kennwort bestätigen: " pass4
             printf "\n"

             if [[ -z "$pass3" ]]; then
                  printf "❌ Fehler: Das Kennwort darf nicht leer sein!\n\n"
             elif [[ ${#pass3} -lt 6 ]]; then
                  printf "❌ Fehler: Kennwort zu kurz (mind. 6 Zeichen erforderlich)!\n\n"
             elif [[ "$pass3" != "$pass4" ]]; then
                 printf "❌ Fehler: Die Kennwörter stimmen nicht überein!\n\n"
             else
                 break # Passwort ist valide
             fi

             read -r -p "🔄 Jetzt erneut versuchen? (ja/nein): " retry
             [[ "$retry" != "ja" ]] && { printf "\n⚠️ Vorgang durch Benutzer abgebrochen.\n\n"; return 1; }
            done

            # 1. Samba-Passwort setzen
            if ! (echo "$pass3"; echo "$pass3") | sudo smbpasswd -s -a "$netuser"; then
           printf "\n❌ Fehler: Das Samba-Kennwort konnte nicht gesetzt werden.\n\n"
           return 1
           fi
           sudo smbpasswd -e "$netuser" > /dev/null  # Sambakennwort setzen

           # 2. System-Passwort synchronisieren (NUR wenn es der Hauptuser $SAMBAMAINUSER ist)
           if [[ "$netuser" == "$SAMBAMAINUSER" ]]; then
             printf "⚙️ Synchronisiere System-Kennwort für '%s'...\n" "$SAMBAMAINUSER"
             echo "$netuser:$pass3" | sudo chpasswd   # Linux-System Kennwort ändern nur bei Hauptbenutzer
           fi

           printf "\n✅ Das Kennwort für '%s' wurde erfolgreich geändert.\n" "$netuser"
         ;;

    2) # --- LÖSCHEN ---
       # Säuberung: Entfernt eventuelle Leerzeichen am Anfang/Ende
       netuser=$(echo "$netuser" | xargs)

       # Erweiterte Prüfung: Existiert er in Linux ODER in Samba?
         if [[ "$(id -un "$netuser" 2>/dev/null)" != "$netuser" ]]; then
           printf "\n⚠️ Achtung: Der Benutzer '%s' existiert nicht - Abbruch!\n\n" "$netuser"
           return 1
         fi

       # Sicherheits-Check: Ist es der aktuelle System-User?
       if [[ "$netuser" == "$USER" ]]; then
       printf "\n❌ Sicherheitssperre: Der System-Account ('%s') kann hier nicht gelöscht werden!\n\n" "$USER"
       return 1
       fi

       printf "\n⚠️ Soll '%s' wirklich komplett (System & Samba) gelöscht werden? " "$netuser"
       read -r -p "👉 (ja/nein): " delconfirm1
       if [[ "$delconfirm1" == "ja" ]]; then
       # Zweite Abfrage (in einer Zeile)
       printf "\n"
       read -r -p "❓ Sind Sie absolut sicher? (ja/nein): " delconfirm2
       if [[ "$delconfirm2" == "ja" ]]; then
        printf "\n⚙️  Löschvorgang läuft - Bitte warten...\n\n"
        # Zuerst aus Samba löschen, dann aus dem System
        sudo smbpasswd -x "$netuser" &>/dev/null
        sleep 2
        sudo pdbedit -x -u "$netuser" &>/dev/null
        sleep 2
        sudo userdel "$netuser" 2>/dev/null
        printf "\n✅ Der Benutzer '%s' wurde vollständig aus dem gesamten System entfernt.\n\n" "$netuser"
        # --- Starte Samba-Server neu ---------------------------
        printf "\n🔄 Neustart Samba-Server...\n\n";
        smbcontrol restart # Restart Samba-Server
        # -------------------------------------------------------
       else
        # Antwort auf die ZWEITE Frage war nein
        printf "\n👤 Der Benutzer '%s' wird *** nicht *** vollständig aus dem gesamten System entfernt.\n\n" "$netuser"
      fi
      else
        # Antwort auf die ERSTE Frage war nein
        printf "\n👤 Der Benutzer '%s' wird *** nicht *** vollständig aus dem gesamten System entfernt.\n\n" "$netuser"
      fi
      ;;

    *) printf "\n⚠️ Ungültige Auswahl - Abbruch!\n\n"; return 1 ;;
  esac
}

checksmbinstall() {
  local smb_conf="/etc/samba/smb.conf"

  # 1. Existiert die Datei? Falls nein -> Installation anbieten
  if [[ ! -f "$smb_conf" ]]; then
    printf "\n⚠️ Achtung: Der Samba-Server ist scheinbar nicht installiert!\n\n\n"
    read -r -p "❓ Soll Samba jetzt automatisch installiert werden? (ja/nein): " inst_answer

    if [[ "$inst_answer" == "ja" ]]; then
      clear # Bildschirm löschen

      # --- Systemsprache auf Deutsch umstellen -------------------------------------------
      if ! local_lang_de; then
          printf "\n🚀 Das System muss neu starten, um die Spracheinstellungen zu laden.\n\n"
          printf "\n🔄 Der Neustart erfolgt in 15 Sekunden (Abbruch mit Strg+C)...\n\n"
          sleep 15
          sudo reboot
          return 1
      fi
      # -----------------------------------------------------------------------------------

      printf "\n⚙️ Starte Installation von 'Samba' - Bitte warten...\n\n\n"
      # Vor der Installation das Systen aktualisieren
      sudo dpkg --configure -a && sudo apt update && sudo apt --assume-yes upgrade && sudo apt --assume-yes dist-upgrade &&  sudo apt --assume-yes autoremove && sudo apt autoclean
      sleep 5
      # Diese Umgebungsvariable unterdrückt alle interaktiven Dialoge (Achtung:  Nur für DEBIAN-Linux !!!)
      sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" samba samba-common-bin
      sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" mc # Midnight Commander

      # Nach Installation erneut prüfen
      if [[ -f "$smb_conf" ]]; then
        printf "\n\n✅ Samba wurde erfolgreich installiert.\n\n"
        printf "\n⌨️ Weiter mit beliebiger Taste...\n\n\n"
        read -n 1 -s -r
        # automatisches System-Update einrichten ?
        clear # Bildschirm leeren
        printf "\n\n\n"
        read -r -p "❓ Soll ein automatisches System-Update eingerichtet werden ? (ja/nein): " au_antwort
        printf "\n"
        if [ "$au_antwort" = "ja" ]; then
        autoupdate -c
        fi
        printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
        read -n 1 -s -r
        smbusermanager "$SAMBAMAINUSER" # Benutzermanager starten
        return 0
      else
        printf "\n❌ Installation fehlgeschlagen. - Abbruch!\n\n"
        return 1
      fi
    else
      printf "\n💾 Abbruch: Ohne Samba können diese Funktionen nicht genutzt werden.\n\n"
      return 1
    fi
  fi

  # 2. Ist die Datei leer? (Größe 0)
  if [[ ! -s "$smb_conf" ]]; then
    printf "\n⚠️ WARNUNG: Die Datei %s ist leer!\n" "$smb_conf"
    printf "\n♻️ Es wird versucht die Konfiguration zu reparieren...\n\n"
    # Vor der Installation das Systen aktualisieren
    sudo dpkg --configure -a && sudo apt update && sudo apt --assume-yes upgrade && sudo apt --assume-yes dist-upgrade &&  sudo apt --assume-yes autoremove && sudo apt autoclean
    sleep 5
    # Hier wird SAMBA neu installiert (Achtung:  Nur für DEBIAN-Linux !!!)
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --reinstall -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" samba samba-common-bin
    return 1
  fi
}

loadsmbconfig() {
    # Prüfen ob "sudo" installiert ist
    checksudo || return 1

    # Prüfen ob "Samba" installiert ist
    checksmbinstall || return 1

    # Falls die Datei gar nicht existiert, direkt zur Prüfung/Erstellung springen
    [ ! -f "$CONFIG_FILE" ] && { checksmbconfig; return; }

    SAMBA_SHARES=()
    SHARE_ORDER=()
    local missing_paths=()

    # 1. Namen der Freigaben auslesen (bereinigt Duplikate durch 'sort -u')
    local names=$(grep -Po '^\[\K[^\]]+' "$CONFIG_FILE" | grep -Ev '^(global|homes|printers|print\$)')

    for name in $names; do
        # Pfad extrahieren: Wir nehmen mit 'head -n1' nur den ersten Treffer,
        # falls ein Name doppelt in der Datei stehen sollte.
        local path=$(sed -n "/\[$name\]/,/^\[/p" "$CONFIG_FILE" | grep "path =" | head -n1 | cut -d'=' -f2 | xargs)

        if [[ -n "$path" ]]; then
            if [ -d "$path" ]; then
                # Prüfen, ob wir diesen Namen schon im Array haben (verhindert doppelte Anzeige)
                if [[ -z "${SAMBA_SHARES[$name]}" ]]; then
                    SAMBA_SHARES["$name"]="$path"
                    SHARE_ORDER+=("$name")
                fi
            else
                missing_paths+=("Freigabe '$name': $path")
            fi
        fi
    done

    # 2. Auswertung
    if [ ${#SHARE_ORDER[@]} -gt 0 ]; then
        printf "\n✅ Samba-Konfiguration erfolgreich geladen (%s aktive Freigaben).\n\n\n" "${#SHARE_ORDER[@]}"

        if [ ${#missing_paths[@]} -gt 0 ]; then
            printf "\n⚠️  WARNUNG: Folgende Pfade sind aktuell nicht erreichbar:\n"
            printf "   - %s\n" "${missing_paths[@]}" | sort -u
            printf "   (Ist das Laufwerk korrekt gemountet?)\n\n"
        fi
        return 0
    else
        checksmbconfig
    fi
}

checksmbconfig() {
  # Prüfen ob "sudo" installiert ist
  checksudo || return 1

  # Prüfen ob "Samba" installiert ist
  checksmbinstall || return 1

  # PRÜFUNG: Ist das Array leer?
  if [ ${#SHARE_ORDER[@]} -eq 0 ]; then
    printf "\n⚠️ Achtung: Es wurden noch keine Samba-Freigaben konfiguriert.\n\n"
    printf "\n🌐 Bitte führen Sie zuerst 'smbconfig' aus.\n\n\n"

    read -r -p "❓ Möchten Sie jetzt die Samba-Konfiguration starten ? (ja/nein): " bestaetigung2
    printf "\n"
     if [ "$bestaetigung2" != "ja" ]; then
     printf "\n⚠️ Vorgang durch Benutzer abgebrochen.\n\n"
     return 1
     else
     smbconfig # SAMBA-Server Konfiguration starten
     return 1
     fi
  else
     return 0
  fi
}

smbconfig() {
    # Prüfen ob "sudo" installiert ist
    checksudo || return 1

    # Prüfen ob "Samba" installiert ist
    checksmbinstall || return 1

    local sharename1 sharename2 sharename3 share path
    local MAX_LEN=75
    local old_locale=$LC_ALL
    export LC_ALL=C

    clear  # Bildschirm leeren

    smballmountsdismount || return 1  # alles dismounten

    printf "\nℹ️ *** Geben Sie hier die gewünschten Freigabenamen an (nur A-Z, 0-9) ***\n\n"

    # --- Eingabe & Validierung Share 1 ---
    while true; do
        printf "\n🌐 Name für Freigabe 1 (Pflichtfeld): > "
        read -r sharename1
        [[ -z "$sharename1" ]] && { printf "\n❌ Fehler: Name darf nicht leer sein.\n\n"; continue; }
        [[ ! "$sharename1" =~ ^[a-zA-Z0-9]+$ ]] && { printf "\n❌ Fehler: Nur Buchstaben (A-Z) und Zahlen (0-9) erlaubt.\n\n"; continue; }
        [[ ${#sharename1} -gt $MAX_LEN ]] && { printf "\n❌ Fehler: Der Name für Freigabe 1 ist zu lang (max. $MAX_LEN).\n\n"; continue; }
        break
    done

    # --- Eingabe & Validierung Share 2 ---
    while true; do
        printf "\n🌐 Name für Freigabe 2 (Enter für 'Freigabe2'): > "
        read -r sharename2
        sharename2=${sharename2:-Freigabe2}
        [[ "$sharename2" == "$sharename1" ]] && { printf "\n❌ Fehler: Name bereits vergeben.\n\n"; continue; }
        [[ ! "$sharename2" =~ ^[a-zA-Z0-9]+$ ]] && { printf "\n❌ Fehler: Nur Buchstaben (A-Z) und Zahlen (0-9) erlaubt.\n\n"; continue; }
        [[ ${#sharename2} -gt $MAX_LEN ]] && { printf "\n❌ Fehler: Der Name für Freigabe 2 ist zu lang (max. $MAX_LEN).\n\n"; continue; }
        break
    done

    # --- Eingabe & Validierung Share 3 ---
    while true; do
        printf "\n🌐 Name für Freigabe 3 (Enter für 'Freigabe3'): > "
        read -r sharename3
        sharename3=${sharename3:-Freigabe3}
        [[ "$sharename3" == "$sharename1" || "$sharename3" == "$sharename2" ]] && { printf "\n❌ Fehler: Name bereits vergeben.\n\n"; continue; }
        [[ ! "$sharename3" =~ ^[a-zA-Z0-9]+$ ]] && { printf "\n❌ Fehler: Nur Buchstaben (A-Z) und Zahlen (0-9) erlaubt.\n\n"; continue; }
        [[ ${#sharename3} -gt $MAX_LEN ]] && { printf "\n❌ Fehler: Der Name für Freigabe 3 ist zu lang (max. $MAX_LEN).\n\n"; continue; }
        break
    done

    # --- Eingabe & Validierung Benutzer ---
    while true; do
        printf "\n"
        printf "\n🌐 Zusätzlicher Benutzer nur für Netzwerkfreigabe (Enter für 'shareuser'): > "
        read -r EXTRAUSER
        EXTRAUSER=${EXTRAUSER:-shareuser}
        [[ ! "$EXTRAUSER" =~ ^[a-z0-9]+$ ]] && { printf "\n❌ Fehler: Nur Kleinbuchstaben und Zahlen sind erlaubt!\n\n"; continue; }
        [[ ! "$EXTRAUSER" =~ ^[a-z0-9]{3,}$ ]] && { printf "\n❌ Fehler: Mindestens 3 Zeichen, und nur a-z und 0-9 erlaubt.\n\n"; continue; }
        [[ ${#EXTRAUSER} -gt $MAX_LEN ]] && { printf "\n❌ Fehler: Der Name für den zusätzlichen Benutzer ist zu lang (max. $MAX_LEN).\n\n"; continue; }
        break
    done

    # Sprache wieder zurücksetzen für den Rest der Funktion
    export LC_ALL=$old_locale
    clear # Bildschirm leeren

    # Benutzermanager starten wenn ein Extra Netzwerkuser angegeben wurde
    if [[ "$EXTRAUSER" != "shareuser" ]]; then
    smbusermanager "$EXTRAUSER"
    fi

    # 4. Globale Arrays befüllen
    SAMBA_SHARES=(
        ["$sharename1"]="/home/${SAMBAMAINUSER}/shared1"
        ["$sharename2"]="/home/${SAMBAMAINUSER}/shared2"
        ["$sharename3"]="/home/${SAMBAMAINUSER}/shared3"
    )
    SHARE_ORDER=("$sharename1" "$sharename2" "$sharename3")

    # 5. Alte Freigaben aus smb.conf entfernen
    if grep -q "# >>> SAMBA-SHARES START" "$CONFIG_FILE" 2>/dev/null; then
        printf "\n♻️ Entferne alte Freigaben aus %s...\n\n\n" "$CONFIG_FILE"
        local cmd='/^$/{N;/# >>> SAMBA-SHARES START/D;};'
        cmd+='/# >>> SAMBA-SHARES START/,/# <<< SAMBA-SHARES END/d'
        sudo sed -i "$cmd" "$CONFIG_FILE"
    fi

    echo "" | sudo tee -a "$CONFIG_FILE" > /dev/null
    cat <<EOF | sudo tee -a "$CONFIG_FILE" > /dev/null
# >>> SAMBA-SHARES START
# Letzte Aktualisierung: $(date '+%d.%m.%Y %H:%M')
EOF

    # 6. Ordner erstellen und smb.conf beschreiben
    printf "\n💾 Schreibe zusätzlichen Benutzer [%s] in Samba Konfigurationsdatei %s\n\n" "$EXTRAUSER" "$CONFIG_FILE"
    for share in "${SHARE_ORDER[@]}"; do
        path="${SAMBA_SHARES[$share]}"
        if [ ! -d "$path" ]; then
            printf "\n📂 Erstelle Ordner %s...\n" "$path"
            mkdir -p "$path"
            # --- Dateisystem-Check  ---
            # Wir prüfen den Mountpoint des Pfades
            local fs_type
            fs_type=$(findmnt -n -o FSTYPE --target "$path" 2>/dev/null)

            if [[ "$fs_type" == "exfat" || "$fs_type" == "vfat" || "$fs_type" == "ntfs" ]]; then
                printf "\nℹ️  Dateisystem %s erkannt: Überspringe chown/chmod (Rechte werden über Mount-Optionen gesteuert).\n\n" "$fs_type"
            else
                printf "\n🔓 Öffne Schreibrechte für Samba-User (%s) und (%s)\n\n" "$SAMBAMAINUSER" "$EXTRAUSER"
                sudo chown "$SAMBAMAINUSER:$SAMBAMAINUSER" "$path"
                sudo chmod 0775 "$path"
            fi
        fi
        printf "💾 Schreibe Freigabename [%s] in Samba Konfigurationsdatei %s\n\n" "$share" "$CONFIG_FILE"
        cat <<EOF | sudo tee -a "$CONFIG_FILE" > /dev/null

[$share]
   comment = Raspberry Pi Freigabe
   path = $path
   browseable = yes
   writeable = yes
   only guest = no
   create mask = 0775
   directory mask = 0775
   valid users = $SAMBAMAINUSER, $EXTRAUSER
   force user = $SAMBAMAINUSER
   public = no
EOF
    done

    echo "# <<< SAMBA-SHARES END" | sudo tee -a "$CONFIG_FILE" > /dev/null

    printf "\n✅ Samba-Konfiguration erfolgreich abgeschlossen.\n\n\n\n"

    # 7. fstab Abfrage
    read -r -p "❓ Soll gleich ein Eintrag in der fstab erstellt werden? (ja/nein): " fstab_antwort
    printf "\n"

    if [[ "$fstab_antwort" == "ja" ]]; then
        clear && echo -e "\n\n" && sudo lsblk -f
        echo -e "\n\n\n"
        read -r -p "❓ Für welches Laufwerk soll der Eintrag erstellt werden? (z.B. /dev/sdb): " devchoice
        printf "\n"

        if [[ -n "$devchoice" ]]; then
            printf "\nℹ️ Für weitere Eintragungen rufen Sie die Funktion 'setfstab' auf.\n\n"
            printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
            read -n 1 -s -r
            setfstab "$devchoice" nowfstab || return 1
        else
            printf "\n⚠️ Abbruch: Kein Laufwerk angegeben.\n\n"
            return 1
        fi
    else
        printf "\n🔄 fstab-Eintrag wird ***nicht*** erstellt.\n\n"
    fi
}

select_mountpoint() {
  # Prüfen ob "sudo" installiert ist
  checksudo || return 1

  # PRÜFUNG: Ist das Array leer?
  checksmbconfig || return 1

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
      printf "\n📍 Zielpfad (Mountpoint): %s\n\n" "$MOUNTPOINT"
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
    # Prüfen ob "sudo" installiert ist
    checksudo || return 1

    if [ "$#" -eq 0 ]; then
    printf "\n"
    printf "${RED}Fehler:${RESET} Gerätename erforderlich (z.B. /dev/sdb)\n\n"
    printf "\nℹ️ Folgende Laufwerke stehen zur Verfügung : \n\n"
    sudo lsblk -f
    printf "\n\n\n"
    return 1
  fi

  local dev="$1"

  if [[ "$dev" != /dev/* ]]; then
    dev="/dev/$dev"
  fi

  if [ ! -b "$dev" ]; then
    printf "${RED}Fehler:${RESET} %s ist kein Blockgerät oder existiert nicht!\n\n" "$dev"
    return 1
  fi

  if [[ ! "$dev" =~ ^/dev/sd[a-z]+$ ]]; then
    printf "${RED}Fehler:${RESET} Nur ganze Laufwerke wie /dev/sdb erlaubt (keine Partitionen).\n\n"
    return 1
  fi

  # Ermittle das Gerät, auf dem das Root-Dateisystem liegt (z.B. /dev/sda)
  local root_dev=$(lsblk -no PKNAME $(findmnt -nvo SOURCE /))
    # Vergleiche das eingegebene Device mit dem Root-Device
    if [[ "$dev" == *"$root_dev"* ]]; then
    printf "\n"
    printf "${RED}STOPP:${RESET} %s ist das Systemlaufwerk! Zugriff verweigert.\n" "$dev"
    printf "\n"
    return 1
  fi
}

format() {
  clear # Bildschirm leeren

  # Prüfen ob "sudo" installiert ist
  checksudo || return 1

  # PRÜFUNG: Ist das Array leer?
  checksmbconfig || return 1

  local dev
  local label="DATA"
  local fs_choice
  local fs_cmd

  # Parameter-Check
  checkparameter "$@" || return 1
  dev="/dev/$(basename "$1")"

  printf "\nℹ️ Prüfe gemountete Partitionen...\n\n"
  smballpartdismount "$dev" || return 1

  # --- Dateisystem Menü ---
  printf "\n💿 *** BITTE DATEISYSTEM WÄHLEN ***\n"
  printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
  printf " 1) ext4   (Standard Linux - Empfohlen)\n"
  printf " 2) ntfs   (Windows - Gute Kompatibilität)\n"
  printf " 3) fat32  (Universal - Max. 4GB pro Datei)\n"
  printf " 4) exfat  (Modern - Windows/Mac/Linux)\n"
  printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
  read -r -p "Bitte wählen (1-4): " fs_input

  case "$fs_input" in
    1) fs_choice="ext4";  fs_cmd="mkfs.ext4 -F -L" ;;
    2) fs_choice="ntfs";  fs_cmd="mkfs.ntfs -f -L" ;;
    3) fs_choice="vfat";  fs_cmd="mkfs.vfat -F 32 -n" ;;
    4) fs_choice="exfat"; fs_cmd="mkfs.exfat -n" ;;
    *) printf "\n⚠️ Ungültige Eingabe durch Benutzer - Abbruch!\n\n"; return 1 ;;
  esac

  # Prüfung ob das Tool installiert ist
  local tool_pkg="${fs_choice}"
  [[ "$fs_choice" == "vfat" ]] && tool_pkg="dosfstools"
  [[ "$fs_choice" == "ntfs" ]] && tool_pkg="ntfs-3g"

  if ! command -v ${fs_cmd%% *} &> /dev/null; then
    printf "\n🛠️ Das Tool für %s fehlt. Installiere %s...\n\n" "$fs_choice" "$tool_pkg"
    sudo apt update && sudo apt install -y "$tool_pkg"
  fi

  # HARTE SYNCHRONISATION
  printf "\nℹ️ Sync + Partitionstabelle neu laden...\n\n"
  sync
  sleep 1
  sudo blockdev --rereadpt "$dev" 2>/dev/null || sudo partprobe "$dev"
  sleep 1

  printf "\nℹ️ Ausgewähltes Laufwerk: %s\n" "$dev"
  printf "\nℹ️ *** Gewählte Formatierung: %s ***\n\n" "$fs_choice"
  lsblk "$dev"
  printf "\n"

  printf "${RED}WARNUNG:${RESET} Alle Daten auf %s werden gelöscht!\n\n" "$dev"
  read -r -p "❓ Letzte Chance: Wirklich alles löschen? (ja/nein): " bestaetigung2
  [[ "$bestaetigung2" != "ja" ]] && { printf "\n⚠️ Formatierung wurde abgebrochen.\n\n"; return 1; }

  printf "\n🔥 ${RED}Starte Formatierung...${RESET}\n\n"
  sudo wipefs -a "$dev"
  sudo parted -s "$dev" mklabel gpt
  sudo parted -s "$dev" mkpart primary 1MiB 100%
  sudo partprobe "$dev"
  sleep 2

  # Die eigentliche Formatierung
  sudo $fs_cmd "$label" "${dev}1"

  printf "\n✅ Fertig: %s (%s) erfolgreich erstellt.\n\n" "${dev}1" "$fs_choice"

  # fstab Frage
  read -r -p "❓ Soll gleich ein Eintrag in der fstab erstellt werden? (ja/nein): " fstab_antwort
  if [[ "$fstab_antwort" == "ja" ]]; then
    clear
    setfstab "$dev" nowfstab || return 1
  else
    printf "\n🔄 fstab-Eintrag wird ***nicht*** erstellt.\n\n"
  fi
}

setfstab() {
  clear # Bildschirm leeren

  # Prüfen ob "sudo" installiert ist
  checksudo || return 1

  # PRÜFUNG: Ist das Array leer?
  checksmbconfig || return 1

  local dev
  local part
  local uuid
  local fstype

  # Expliziter Aufruf → Fehlermeldung SICHTBAR
  checkparameter "$@" || return 1

  dev="/dev/$(basename "$1")"

  # Nur wenn vorher nicht das dev formatiert wurde
  if [ "$2" != "nowfstab" ]; then
  printf "\nℹ️ Prüfe ob Partition noch gemountet ist...\n"
  smbdismount "$dev"
  else
  select_mountpoint || return 1
  fi

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
    printf "${RED}Fehler:${RESET} UUID oder Dateisystem konnte nicht ermittelt werden.\n\n"
    return 1
  fi

  # Standard-Optionen für Linux-Dateisysteme (ext4)
  mount_options="defaults,noatime,nofail"
  # Wenn exfat, vfat (FAT32) oder ntfs erkannt wird:
  if [[ "$fstype" =~ ^(exfat|vfat|ntfs)$ ]]; then
    # Wir erzwingen uid=1000, gid=100 und volle Rechte (umask=000)
    mount_options="defaults,noatime,nofail,uid=1000,gid=100,umask=000"
    # Spezieller Zusatz für NTFS (verhindert ungültige Zeichen unter Windows)
    [[ "$fstype" == "ntfs" ]] && mount_options+=",windows_names"
  fi

  printf "ℹ️ UUID: %s\n" "$uuid"
  printf "ℹ️ Dateisystem: %s\n" "$fstype"
  printf "ℹ️ Mountpunkt: %s\n\n" "$MOUNTPOINT"

  read -r -p "❓fstab-Eintrag jetzt erstellen? (ja/nein): " antwort
  printf "\n"
  if [ "$antwort" = "ja" ]; then
  # Existierenden Eintrag für diesen Mountpoint entfernen (egal welche UUID dort stand)
  if grep -q "[[:space:]]$MOUNTPOINT[[:space:]]" /etc/fstab; then
    printf "\nℹ️  Entferne alten fstab-Eintrag für %s...\n" "$MOUNTPOINT"
    sudo sed -i "\|[[:space:]]$MOUNTPOINT[[:space:]]|d" /etc/fstab
  fi

  # Neuen Eintrag in fstab schreiben
  echo "UUID=$uuid  $MOUNTPOINT  $fstype  $mount_options  0  2" | sudo tee -a /etc/fstab >/dev/null

  printf "\n✅ fstab-Eintrag wurde erstellt.\n\n"
  else
   printf "\n🔄 fstab-Eintrag wird ***nicht*** erstellt.\n\n"
  fi

  # Nach dem fstab-Eintrag: Mount-Abfrage
  read -r -p "❓ Soll die Partition auch gleich gemoutet werden ? ($part → $MOUNTPOINT) (ja/nein): " mount_antwort
  printf "\n"
    if [ "$mount_antwort" = "ja" ]; then
    clear
    smbmount "$dev" afterfstab || return 1
    else
    printf "\n"
    fi
}

smbmount() {
  # Prüfen ob "sudo" installiert ist
  checksudo || return 1

  # PRÜFUNG: Ist das Array leer?
  checksmbconfig || return 1

  checkparameter "$@" || return 1

  local dev="/dev/$(basename "$1")"

  # Nur wenn vorher nicht das dev formatiert wurde
  if [ "$2" != "afterfstab" ]; then
  # Auswahl des Mountpoints abfragen
  select_mountpoint || return 1
  fi

  # Wir ermitteln die Partition (z.B. /dev/sdb1), falls nur /dev/sdb angegeben wurde
  local part=$(lsblk -pnlo NAME,FSTYPE "$dev" | awk '$2!="" {print $1; exit}')

  if [ -z "$part" ]; then
    printf "${RED}Fehler:${RESET} Keine Partition mit Dateisystem auf %s gefunden!\n" "$dev"
    return 1
  fi

  # Mount-Abfrage
  printf "\n"
  read -r -p "❓ Partition jetzt mounten? ($part → $MOUNTPOINT) (ja/nein): " mount_antwort
  printf "\n"

  if [ "$mount_antwort" = "ja" ]; then
    # Prüfen, ob bereits etwas dort gemountet ist
    if mountpoint -q "$MOUNTPOINT"; then
       printf "\n⚠️ Hinweis: %s ist bereits belegt. Versuche trotzdem zu mounten...\n" "$MOUNTPOINT"
    fi
      if sudo mount "$part" "$MOUNTPOINT"; then
      # --- Dateisystem-Check ---
      local current_fs
      current_fs=$(findmnt -n -o FSTYPE --target "$MOUNTPOINT")

      if [[ "$current_fs" =~ ^(exfat|vfat|ntfs)$ ]]; then # <--- NEU
        printf "\nℹ️  Das Dateisystem %s  wurde erkannt.\n\n" "$current_fs"
        printf "🔓 Rechte werden automatisch über die Mount-Optionen (fstab) gesteuert.\n\n"
      else
      # Optional: Auch Unterordner anpassen, falls vorhanden (Achtung:  dauert bei vielen Dateien sehr lange --> Geduld)
      # sudo chmod -R 775 "$MOUNTPOINT" 
        # Nur bei Linux-FS (ext4) chown/chmod ausführen
        printf "\n🔓 Öffne Schreibrechte für Samba-User (%s) und (%s)\n\n" "$SAMBAMAINUSER" "$EXTRAUSER"
        sudo chown "$SAMBAMAINUSER":"$SAMBAMAINUSER" "$MOUNTPOINT"
        sudo chmod 775 "$MOUNTPOINT"
      fi

      # --- Starte Samba-Server wieder  -----------------------
      printf "\n🔄 Neustart Samba-Server...\n\n";
      smbcontrol restart # Restart Samba-Server
      # -------------------------------------------------------
      printf "\n✅ Erfolgreich: %s ist bereit für Netzwerkverbindungen.\n\n" "$MOUNTPOINT"
    else
      printf "\n❌ Mount von %s fehlgeschlagen!\n\n" "$part"
      return 1
    fi
    else
     printf "\nℹ️ Kein Mount durchgeführt. (%s bleibt im Sicherheitsmodus 555)\n\n" "$MOUNTPOINT"
  fi
}

smbdismount() {
  # Prüfen ob "sudo" installiert ist
  checksudo || return 1

  # PRÜFUNG: Ist das Array leer?
  checksmbconfig || return 1

  # Parameter-Check
  checkparameter "$@" || return 1

  local dev="/dev/$(basename "$1")"

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
  printf "\nℹ️ Aktiv gemountet: %s (auf %s)\n\n" "$MOUNTPOINT" "$current_source"
  printf "\n"
  read -r -p "❓ Diese Freigabe jetzt dismounten? (ja/nein): " confirm
  [[ "$confirm" != "ja" ]] && { printf "\n⚠️ Vorgang durch Benutzer abgebrochen.\n\n"; return 1; }

  # --- Stop Samba-Server  -------------------------------
  printf "\n🔄 Trenne Samba-Verbindungen...\n\n";
  smbcontrol stop
  # ------------------------------------------------------

  # 4. Gezielter Dismount des Verzeichnisses
  printf "\nℹ️ Dismount %s → Bitte warten..." "$MOUNTPOINT"

  if sudo umount "$MOUNTPOINT" 2>/dev/null || {
       printf "\n⚠️ Dismount blockiert! Prozesse beenden...\n\n";
       sudo fuser -km "$MOUNTPOINT" 2>/dev/null;
       sleep 1;
       sudo umount -l "$MOUNTPOINT" 2>/dev/null;
     }; then
    printf "\n✅\n"

    # 5. FINALE SICHERHEIT: Verzeichnis sperren
    sudo chmod 555 "$MOUNTPOINT" 2>/dev/null
    printf "\n🔒 Verbindung getrennt. %s ist jetzt sicher (555).\n\n" "$MOUNTPOINT"
    local success=1
  else
    printf "❌ Dismount von %s fehlgeschlagen!\n\n" "$MOUNTPOINT"
    local success=0
  fi

  # --- Starte Samba-Server wieder  -----------------------
  printf "\n🔄 Starte Samba-Verbindungen...\n\n";
  smbcontrol start
  # -------------------------------------------------------

  [[ $success -eq 1 ]] && printf "\n✅ Vorgang erfolgreich abgeschlossen.\n\n"
  [[ $success -eq 0 ]] && return 1
}

smballpartdismount() {
  # Prüfen ob "sudo" installiert ist
  checksudo || return 1

  # PRÜFUNG: Ist das Array leer?
  checksmbconfig || return 1

  # Parameter-Check: Falls kein Argument übergeben wurde
  checkparameter "$@" || return 1

  local dev="/dev/$(basename "$1")"

  # 1. Alle Partitionen des Laufwerks finden
  local partitions=($(lsblk -pnlo NAME "$dev" | grep -v "^$dev$"))

  # 2. Prüfen, ob überhaupt Partitionen auf der Hardware existieren
  if [ ${#partitions[@]} -eq 0 ]; then
    printf "\nℹ️ Keine Partitionen auf %s gefunden.\n\n" "$dev"
    sudo chmod 555 "$MOUNTPOINT" 2>/dev/null
    printf "\n🔒 Sicherheits-Modus: %s ist schreibgeschützt (555).\n\n" "$MOUNTPOINT"
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
    printf "\nℹ️ Keine der Partitionen auf %s ist zurzeit gemountet.\n\n" "$dev"
    sudo chmod 555 "$MOUNTPOINT" 2>/dev/null
    printf "\n🔒 Sicherheits-Modus: %s ist schreibgeschützt (555).\n\n" "$MOUNTPOINT"
    return 0
  fi

  # 5. Benutzer fragen
  printf "\nℹ️ Aktiv gemountet: %s\n\n" "${mounted_parts[*]}"
  read -r -p "❓ Diese Partition(en) jetzt dismounten? (ja/nein): " confirm
  [[ "$confirm" != "ja" ]] && { printf "\n⚠️ Vorgang durch Benutzer abgebrochen.\n\n"; return 1; }

  # --- Stop Samba-Server  -------------------------------
  printf "\n🔄 Trenne Samba-Verbindungen...\n\n";
  smbcontrol stop
  # ------------------------------------------------------

  # 6. Schleife über alle gemounteten Partitionen
  local count=0
  for part in "${mounted_parts[@]}"; do
    printf "→ Dismount %s... " "$part"

    # Versuche Dismount (Erst Normal, dann mit fuser)
    if sudo umount -l "$part" 2>/dev/null || {
         printf "\n⚠️ Dismount ist blockiert - Prozesse beenden...\n\n";
         sudo fuser -km "$part" 2>/dev/null;
         sleep 2;
         sudo umount -l "$part" 2>/dev/null;
       }; then
      printf "✅\n"
      ((count++))
    else
      printf "\n❌ Dismount fehlgeschlagen!\n\n";
      return 1
    fi
  done

  # 7. FINALE SICHERHEIT (Der Kern des Tricks)
  # Wenn nach der Schleife nichts mehr gemountet ist, ziehen wir die Rechte dauerhaft ein
  if ! findmnt --source "$dev" >/dev/null && ! findmnt "$MOUNTPOINT" >/dev/null; then
    sudo chmod 555 "$MOUNTPOINT" 2>/dev/null
    printf "\n🔒 Alle Partitionen dismountet. %s ist jetzt sicher (555).\n\n" "$MOUNTPOINT"
    local success=1
  fi

  # --- Starte Samba-Server wieder  -----------------------
  printf "\n🔄 Starte Samba-Verbindungen...\n\n";
  smbcontrol start
  # -------------------------------------------------------

  printf "\n✅ %s/%s Partition(en) erfolgreich bearbeitet.\n\n" "$count" "${#mounted_parts[@]}"
}

smballmountsdismount() {
  # Prüfen ob "sudo" installiert ist
  checksudo || return 1

  # 1. Alle aktuell gemounteten Partitionen finden
  # Wir schließen jetzt explizit alle systemkritischen Mountpoints aus
  local mounted_parts=($(lsblk -pnlo NAME,MOUNTPOINT | grep -E '^/dev/(sd|nvme|mmcblk)' | \
    awk '$2!="" && $2!="/" && $2!~"^\/boot" && $2!~"^\/etc" {print $1}'))

  # Zusätzlicher Sicherheits-Check: Falls die Partition zum aktuell laufenden Root gehört
  local root_part=$(findmnt -nvo SOURCE /)

  local final_list=()
  for part in "${mounted_parts[@]}"; do
    # Überspringe die Partition, wenn sie die Root-Partition ist
    [[ "$part" == "$root_part" ]] && continue
    final_list+=("$part")
  done

  # Falls gar nichts (mehr) gemountet ist, direkt abbrechen
  if [ ${#final_list[@]} -eq 0 ]; then
    printf "\nℹ️ Keine Partitionen zum Dismounten gefunden.\n\n"
    return 0
  fi

  # --- Stop Samba-Server ---
  printf "\n🔄 Trenne Samba-Verbindungen...\n\n"
  smbcontrol stop

  # 2. Schleife über die gefilterte Liste
  local count=0
  for part in "${final_list[@]}"; do
    printf "\n → → → Dismount %s... " "$part"

    if sudo umount "$part" 2>/dev/null || {
         printf "\n⚠️ Dismount blockiert! Beende Prozesse auf %s...\n" "$part"
         sudo fuser -km "$part" 2>/dev/null;
         sleep 2
         sudo umount -l "$part" 2>/dev/null;
       }; then
      printf "✅\n"
      ((count++))
    else
      printf "\n❌ Dismount fehlgeschlagen! - Ein Neustart wird empfohlen \n\n"
    fi
  done

  # --- Starte Samba-Server wieder ---
  printf "\n🔄 Starte Samba-Verbindungen...\n\n"
  smbcontrol start

  printf "\n✅ %s von %s Partition(en) erfolgreich bearbeitet.\n\n" "$count" "${#final_list[@]}"
}

smbcontrol() {
  # Prüfen ob "sudo" installiert ist
  checksudo || return 1

  # Prüfen ob "Samba" installiert ist
  checksmbinstall || return 1

  local service=("smbd" "nmbd")
  local action="$1"

  # 1. Parameter-Prüfung (jetzt inkl. restart)
  if [[ "$action" != "start" && "$action" != "stop" && "$action" != "restart" ]]; then
    printf "\n❌ Ungültige Parameterangabe - Nutze 'start', 'stop' oder 'restart'\n\n"
    return 1
  fi

  # ------------------------- START ---------------------------------------------
  if [[ "$action" == "start" ]]; then
    if systemctl -q is-active "$service"; then
      printf "\nℹ️ Der SAMBA-Server ist bereits gestartet.\n\n"
      return 0
    fi
    printf "\nℹ️ Der Samba-Server wird gestartet - Bitte warten ....\n\n"
    sudo systemctl start "$service"

  # ------------------------- STOP ----------------------------------------------
  elif [[ "$action" == "stop" ]]; then
    if ! systemctl -q is-active "$service"; then
      printf "\nℹ️ Der SAMBA-Server ist bereits gestoppt.\n\n"
      return 0
    fi
    printf "\nℹ️ Der Samba-Server wird gestoppt - Bitte warten ....\n\n"
    sudo systemctl stop "$service"

  # ------------------------- RESTART -------------------------------------------
  elif [[ "$action" == "restart" ]]; then
    printf "\n🔄 Der Samba-Server wird neu gestartet - Bitte warten ....\n\n"
    sudo systemctl daemon-reload # zur Sicherheit daemon neu starten
    sleep 3
    sudo systemctl restart "$service"
  fi

  # Kurze Pause für die System-Initialisierung
  sleep 3

  # ------------------------- ABSCHLUSSPRÜFUNG ----------------------------------
  if [[ "$action" == "stop" ]]; then
    if ! systemctl -q is-active "$service"; then
      printf "\n✅ Erfolg: Der SAMBA-Server wurde erfolgreich gestoppt.\n\n"
      return 0
    fi
  else
    # Gilt für start und restart
    if systemctl -q is-active "$service"; then
      printf "\n✅ Erfolg: Der SAMBA-Server ist aktiv/gestartet.\n\n"
      return 0
    fi
  fi

  # Falls die Prüfung oben nicht erfolgreich war:
  printf "\n${RED}Fehler:${RESET} Die Aktion '%s' Samba-Server konnte nicht korrekt ausgeführt werden !!!\n\n" "$action"
  return 1
}

autoupdate() {
    local script_path="/home/$USER/systemupdate.sh"
    local log_path="/home/$USER/systemupdate.log"
    local cron_entry="0 2 * * 2 $script_path"
    local param="$1"

    # --- OPTION: DEAKTIVIEREN (-d) ---
    if [[ "$param" == "-d" ]]; then
        if [[ ! -f "$script_path" ]]; then
            printf "\n⚠️ Abbruch: Keine 'Autoupdate'-Datei '%s' gefunden.\n\n" "$script_path"
            return 1
        fi

        read -r -p "❓ Soll das 'Autoupdate' wirklich deaktiviert werden? (ja/nein): " auconfirm
        if [[ "$auconfirm" == "ja" ]]; then
            # Datei löschen
            rm "$script_path" > /dev/null && rm "$log_path" > /dev/null
            # Cronjob aus crontab entfernen
            (crontab -l 2>/dev/null | grep -vF "$script_path") | crontab -
            printf "\n✅ Auto-Update wurde deaktiviert.\n\n"
        else
            printf "\n🔄 Der Vorgang wurde abgebrochen.\n\n"
        fi
        return 0
    fi

    # --- OPTION: ERSTELLEN (-c) ---
    if [[ "$param" == "-c" ]]; then
        if [[ -f "$script_path" ]]; then
            read -r -p "⚠️  Das 'Autoupdate' existiert bereits. Überschreiben? (ja/nein): " overwrite
            [[ "$overwrite" != "ja" ]] && { printf "\n⚠️ Der Vorgang wurde abgebrochen.\n\n"; return 1; }
        fi

        # Datei erstellen mit Here-Doc (Nutzt $USER dynamisch)
        cat <<EOF > "$script_path"
     #!/bin/bash
rm $log_path
date >$log_path 2>&1
sudo apt-get update >>$log_path 2>&1
sudo apt-get --assume-yes upgrade >>$log_path 2>&1
sudo apt-get --assume-yes dist-upgrade >>$log_path 2>&1
sudo apt-get --assume-yes upgrade --fix-missing >>$log_path 2>&1
sudo apt-get --assume-yes autoremove >>$log_path 2>&1
sudo apt-get autoclean >>$log_path 2>&1
echo "***Neustart***" >>$log_path 2>&1
sudo reboot
EOF
        # Ausführbar machen
        chmod +x "$script_path"

        # Cronjob eintragen (verhindert Dopplungen)
        (crontab -l 2>/dev/null | grep -vF "$script_path"; echo "$cron_entry") | crontab -

        printf "\n✅ Das 'Autoupdate' '%s'  wurde erstellt.\n\n" "$script_path"
        printf "\n📅 Planung: Automatisches Systemupdate für jeden Dienstag um 02:00 Uhr wurde eingerichtet.\n\n"
        return 0
    fi

    # Falscher oder kein Parameter
    printf "\n⚠️ Ungültiger Parameter: - Nutzung von 'Autoupdate': autoupdate [-c | -d]\n\n"
    printf "🔄  -c : Erstellen & Aktivieren\n"
    printf "🔄  -d : Deaktivieren & Löschen\n\n"
}

local_lang_de() {
      # --- PRÜFUNG: Ist Deutsch schon aktiv? ---
      local current_kbd
      local kbd_check=0
      local lang_check=0

      # Prüfen ob Layout "de" in der Datei steht
      if grep -q 'XKBLAYOUT="de"' /etc/default/keyboard 2>/dev/null; then
          kbd_check=1
      fi

      # Prüfen ob LANG auf de_DE gesetzt ist
      if [[ "$LANG" == "de_DE.UTF-8" ]]; then
          lang_check=1
      fi

      # Nur umstellen, wenn etwas fehlt
      if [[ $kbd_check -eq 0 || $lang_check -eq 0 ]]; then
          printf "\n🌐 Stelle Systemsprache und Tastatur auf Deutsch um - Bitte warten...\n\n\n"
          # Hier dein cat <<EOF Block...
          cat <<EOF | sudo tee /etc/default/keyboard > /dev/null
XKBMODEL="pc105"
XKBLAYOUT="de"
XKBVARIANT=""
XKBOPTIONS=""
BACKSPACE="guess"
EOF
          # Erst alle alten de_DE Einträge löschen (verhindert Dubletten und Rauten-Probleme)
          sudo sed -i '/de_DE.UTF-8/d' /etc/locale.gen
          # Die saubere Zeile am Ende der Datei anhängen
          echo "de_DE.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen > /dev/null
          # Standard-Sprache für das System setzen
          echo "LANG=de_DE.UTF-8" | sudo tee /etc/default/locale > /dev/null
          # Generiert die Sprachunterstützung
          sudo locale-gen de_DE.UTF-8 > /dev/null 2>&1
          # Registriert die Sprache offiziell im System
          sudo update-locale LANG=de_DE.UTF-8
          # Aktiviert die Tastatur sofort
          sudo loadkeys de 2>/dev/null
          sudo setupcon > /dev/null 2>&1
          if [[ "$(cat /etc/timezone 2>/dev/null)" != "Europe/Berlin" ]]; then
	  sudo timedatectl set-timezone Europe/Berlin 2>/dev/null
          fi
          printf "\n✅ Systemsprache und Tastatur erfolgreich auf Deutsch umgestellt.\n"
          return 1
      else
          printf "\nℹ️ Systemsprache und Tastatur sind bereits auf Deutsch eingestellt.\n"
          return 0
      fi
}

# Funktion beim start der .bashrc Datei AUFRUFEN (muss ganz unten stehen)
loadsmbconfig  # existierende Freigaben laden


# Hinweis:
# Ein letzter kleiner Tipp: Wenn du das Script zum ersten Mal in der .bashrc aktiviert
# hast, lade sie einmalig mit - source ~/.bashrc - neu. Ab dann läuft alles von allein bei jedem Login.
