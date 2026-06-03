# ~/.bashrc: executed by bash(1) for non-login shells. see /usr/share/doc/bash/examples/startup-files (in the
# package bash-doc) for examples

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
#
# -------------Samba-Server-----------------
# Disk-Tools (sicherer Datenträger-Manager)
#                (DE)
#              Juni 2026
#   Version 3.3 von Mario Ammerschuber
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
GREEN='\033[0;32m' # grün Schrift
YELLOW='\033[0;33m' # gelbe Schrift
RESET='\033[0m'  # farbige Schrift - Ende

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

getdevices() {
    checksudo || return 1

    # Das Systemlaufwerk ermitteln
    local root_drive=$(lsblk -no PKNAME $(findmnt -nvo SOURCE /) | tr -d '[:space:]')
    [[ -z "$root_drive" ]] && root_drive=$(lsblk -no NAME $(findmnt -nvo SOURCE /) | tr -d '[:space:]' | sed 's/[0-9]*$//')

    printf "\n"
    printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    printf "📊  LAUFWERKS-ANALYSE ( ${RED}ROT = System${RESET} | ${GREEN}GRÜN = Samba Option${RESET} | ${YELLOW}GELB = Virtuell${RESET} )\n"
    printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

    sudo lsblk -f | while read -r line; do
        [[ -z "$line" ]] && continue

        # Kopfzeile immer normal anzeigen
        if [[ "$line" =~ ^NAME ]]; then
            printf "%s\n" "$line"
            continue
        fi

        # 1. PRÜFUNG: Virtuelle Geräte/Swap (loop, zram) -> GELB
        # Wir prüfen, ob die Zeile mit loop oder zram BEGINNT (^)
        if [[ "$line" =~ ^loop ]] || [[ "$line" =~ ^zram ]]; then
            echo -e "${YELLOW}${line}${RESET}"
            continue
        fi

        # 2. PRÜFUNG: Systemlaufwerk -> ROT
        if [[ "$line" == *"$root_drive"* ]]; then
            echo -e "${RED}${line}${RESET}"
        else
            # 3. PRÜFUNG: Alles andere -> GRÜN
            echo -e "${GREEN}${line}${RESET}"
        fi
    done
    printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n"
}

bootconfig() {
    # Prüfen ob "sudo" installiert ist
    checksudo || return 1

    printf "\n🚀 Optimiere Boot-Konfiguration für USB-Modus...\n"
    
    local boot_conf="/boot/firmware/config.txt"
    # Fallback für ältere OS-Versionen
    [ ! -f "$boot_conf" ] && boot_conf="/boot/config.txt"

    # PRÜFUNG: Ist der Eintrag schon vorhanden?
    if grep -q "program_usb_boot_mode=1" "$boot_conf"; then
        printf "\nℹ️ Die Boot-Parameter sind bereits in %s konfiguriert.\n\n" "$boot_conf"
        return 0
    else
        printf "\n➕ Füge Boot-Parameter hinzu...\n\n"
    if sudo bash -c "cat >> $boot_conf" <<-EOF > /dev/null 2>&1
# --- USB Boot & Power Tuning ---
# WLAN deativieren, da Server nicht über WLAN laufen sollten !!!
dtoverlay=disable-wifi
# Bluetooth deaktivieren
dtoverlay=disable-bt
# Booten auch von USB
program_usb_boot_mode=1
# mehr Power für USB-Ports
max_usb_current=1
# Startverzögerung von 15 Sekunden.
boot_delay=15 
program_usb_boot_timeout=1
EOF
    then
    printf "\n✅ Die Boot-Parameter wurden erfolgreich hinzugefügt.\n\n"
    return 1
     else
     printf "\n❌ Fehler: Die Boot-Parameter konnten nicht gespeichert werden !\n\n"
     return 2 # FEHLER: Schreiben fehlgeschlagen!
    fi
  fi
}

smbcheckosversion() {
     # 1. Die reine Versionsnummer extrahieren (z.B. 11 oder 12 u.s.w)
    # tr -d '"' entfernt eventuelle Anführungszeichen um die Zahl
    local os_ver os_id
    os_id=$(grep "^ID=" /etc/os-release | cut -d= -f2 | tr -d '"' | xargs)
    os_ver=$(grep "^VERSION_ID=" /etc/os-release | cut -d= -f2 | tr -d '"')

    printf "\n🔍 Prüfe Betiebssystem Version...\n"

    # Falls die Variable leer ist (Sicherheitscheck)
    if [[ -z "$os_ver" ]]; then
        printf "\n❌ Fehler: Die OS-Version konnte nicht ermittelt werden. - Abbruch!\n\n\n"
        return 1
    fi

    # Sicherheitscheck: Ist es überhaupt Debian?
    if [[ "$os_id" != "debian" ]]; then
        printf "\n❌ Fehler: Dieses Skript ist nur für 'Debian' Linux geeignet! - Abbruch!\n\n\n"
        return 1
    fi

    # 2. Vergleich: muss Version 13 (Trixi) oder höher sein
    if [ "$os_ver" -ge 13 ] 2>/dev/null; then
        printf "\n✅ Systemversion %s erkannt (OK).\n\n" "$os_ver" 
        # ========================================================
        local_lang_de # Sprache auf Deutsch einstellen
        local lang_changed=$?
        bootconfig # zusätzliche Bootparameter eintragen
        local boot_changed=$?
          # Neustart wenn nötig
          if [ $lang_changed -ne 0 ] || [ $boot_changed -ne 0 ]; then
          printf "\n🚀 Das System muss neu gestartet werden um die Änderungen zu aktivieren.\n\n"
          printf "\n🔄 Der Neustart erfolgt in 5 Sekunden (Abbruch mit Strg+C)...\n\n"
          sleep 5
          sudo reboot
          return 1
          fi
       return 0
    else
        printf "\n❌ Fehler: Diese Funktionssammlung benötigt mindestens Version 13 (Trixi) des Betriebssystems.\n\n"
        printf "\n⚠️ Die aktuelle Version ist: %s\n\n" "$os_ver"
        printf "\n🚫 Leider müssen wir an dieser Stelle abbrechen.\n\n"
        return 1
    fi
}

smbsetstaticip() {
    # Prüfen ob "sudo" installiert ist
    checksudo || return 1

    # Wenn der Networkmanager nicht installiert ist dann noch installieren
    if ! command -v nmcli >/dev/null 2>&1; then
    printf "\n\nℹ️ Der 'Netzwerk-Manager' muss noch installiert werden - Bitte warten...\n\n"
    printf "\n🚀 Starte Systemupdate - Bitte warten...\n\n"
      sudo dpkg --configure -a && sudo apt update && sudo apt --assume-yes upgrade && sudo apt --assume-yes dist-upgrade
      sudo apt --assume-yes autoremove
      sudo apt autoclean
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" network-manager # Netzwerkmanager installieren
    printf "\n\n🚀 Das System muss neu starten um den 'Netzwerk-Manager' zu aktivieren.\n\n"
    printf "\n🔄 Der Neustart erfolgt in 15 Sekunden (Abbruch mit Strg+C)...\n\n"
    sleep 15
    sudo reboot
    return 1
    fi

    local skip_file="/home/$USER/.skip_ip_check"
    local sparam="$1"

    # --- Parameter-Check (Silent) ---
    if [[ "$1" == "-clear" ]]; then
    rm -f "$skip_file" 2>/dev/null
    fi

    # 1. Aktives Interface ermitteln (Sprachneutral)
    local interface
    interface=$(nmcli -t -f DEVICE,STATE device status | grep -E ":connected|:verbunden" | head -n 1 | cut -d: -f1)

    if [[ -z "$interface" ]]; then
        printf "\n❌ Fehler: Es wurde kein verbundenes Netzwerk-Interface gefunden! - Abbruch!\n\n"
        return 1
    fi

    # 2. Den Namen der aktiven Verbindung (Connection) finden
    local conn_name
    conn_name=$(nmcli -t -f NAME,DEVICE connection show --active | grep ":$interface" | cut -d: -f1)

    if [[ -z "$conn_name" ]]; then
        printf "\n❌ Fehler: Es wurde kein aktives Profil für %s gefunden. - Abbruch!\n\n" "$interface"
        return 1
    fi

    # 3. Methode über die CONNECTION abfragen
    local method
    method=$(nmcli -g ipv4.method connection show "$conn_name")

    # 4. Wir holen die IP auch über die CONNECTION
    local current_ip=$(nmcli -g ip4.address connection show "$conn_name" | cut -d/ -f1)

    # --- Warnung bei WLAN-Betrieb ---
    if [[ "$interface" == w* ]]; then
        printf "\n⚠️ WARNUNG: Der Samba-Server wird über WLAN (%s) betrieben!\n\n" "$interface"
        printf "Für maximale Stabilität und Geschwindigkeit wird ein LAN-Kabel empfohlen.\n\n"
        read -r -p "❓ Trotzdem fortfahren? (ja/nein): " wlan_confirm
        [[ "$wlan_confirm" != "ja" ]] && { printf "\n🔄 Abbruch durch Benutzer.\n\n"; return 1; }
    fi

    if [[ "$method" == "manual" ]]; then
        # printf "\n✅ Das Interface [%s] nutzt bereits eine STATISCHE IP-Adresse.\n\n" "$interface"
        return 0
    fi

    # Wenn die Flag-Datei existiert, überspringen wir die Abfrage
    if [[ -f "$skip_file" ]]; then
        return 0  # Benutzer hatte sich für DHCP entschieden
    fi

    # 3. Umstellung anbieten
    printf "\n🌐 Aktueller Status für [%s]: DHCP (Dynamische IP-Adresse)\n\n" "$interface"
    read -r -p "❓ Möchten Sie jetzt auf eine STATISCHE IP-Adresse umstellen? (ja/nein/nie): " sip_antwort

    if [[ "$sip_antwort" == "ja" ]]; then
        clear # Bildschirm leeren
        printf "\n\n\n--- Konfiguration der statischen IP-Adresse ---\n"
        printf "\nℹ️  Hinweis: Wählen Sie eine IP-Adresse außerhalb des DHCP-Pools.\n\n"
        printf "      (z.Bsp. FritzBox meist: .2 bis .19 oder .201 bis .253)\n\n"

        local base_ip=$(echo "$current_ip" | cut -d. -f1-3)

        # Gateway über CONNECTION abfragen, nicht über DEVICE
        local current_gw=$(nmcli -g ipv4.gateway connection show "$conn_name")

        # --- Interne Validierungs-Funktion ---
        validate_ip() {
            local ip=$1
            [[ ! "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]] && return 1
            local IFS='.'
            local oct=($ip)
            for i in {0..3}; do
                local val=$((10#${oct[$i]}))
                [[ $val -lt 0 || $val -gt 255 ]] && return 1
            done
            local last=$((10#${oct[3]}))
            [[ $last -eq 0 || $last -eq 255 ]] && return 1
            return 0
        }

        while true; do
            read -r -p "👉 statische IP-Adresse [Vorschlag: ${base_ip}.212]: " new_ip
            new_ip=${new_ip:-"${base_ip}.212"}

            if ! validate_ip "$new_ip"; then
                printf "\n❌ Fehler: '%s' ist keine gültige IP-Adresse (0-254, Ende nicht 0/255)!\n\n" "$new_ip"
                continue
            fi

            printf "\n🔍 Prüfe ob IP-Adresse %s frei ist...\n\n" "$new_ip"
            if ping -c 1 -W 1 "$new_ip" >/dev/null 2>&1; then
                printf "\n❌ BELEGT: Ein anderes Gerät nutzt bereits diese IP-Adresse!\n\n"
            else
                break
            fi
        done

        # --- GATEWAY IP-Adresse ---
        local new_gw
        local def_gw="${current_gw:-${base_ip}.1}"
        while true; do
            read -r -p "👉 Gateway IP-Adresse (Router) - [Vorschlag: $def_gw]: " new_gw
            new_gw=${new_gw:-"$def_gw"}
            # KORREKTUR: ! für "Wenn NICHT gültig", dann Fehlermeldung
            if ! validate_ip "$new_gw"; then
                printf "\n❌ Fehler: '%s' ist keine gültige Gateway IP-Adresse!\n\n" "$new_gw"
            else
                break
            fi
        done

        # --- DNS IP-Adresse ---
        local new_dns
        while true; do
            printf "\n\n"
            read -r -p "👉 DNS-Server IP-Adresse - [Vorschlag: $new_gw]: " new_dns
            new_dns=${new_dns:-$new_gw}
            # KORREKTUR: ! für "Wenn NICHT gültig", dann Fehlermeldung
            if ! validate_ip "$new_dns"; then
                printf "\n❌ Fehler: '%s' ist keine gültige DNS IP-Adresse!\n\n" "$new_dns"
            else
                break
            fi
        done

        # --- UMSETZUNG ---
        clear # Bildschirm leeren
        printf "\n\n⚙️ Einstellungen für [%s] werden angewendet...\n\n" "$conn_name"

        sudo nmcli connection modify "$conn_name" \
            ipv4.addresses "${new_ip}/24" \
            ipv4.gateway "$new_gw" \
            ipv4.dns "$new_dns" \
            ipv4.method manual

        rm -f "$skip_file" 2>/dev/null
        printf "\n✅ Statische IP-Adresse erfolgreich konfiguriert.\n\n"
        printf "\n🚀 Neustart in 5 Sekunden, um auf die neue IP-Adresse umzustellen - Bitte warten...\n\n"
        sleep 5
        sudo reboot
        exit 0

    elif [[ "$sip_antwort" == "nie" ]]; then
        printf "SAMBA-Server - Benutzer hat sich am $(date +'%d.%m.%Y um %H:%M') für eine DHCP-Adresse entschieden!" > "$skip_file"
        printf "\n✅ Die IP-Adresse des SAMBA-Server bleibt auf DHCP Konfiguration. (Aktuell: %s)\n\n" "$current_ip"
    else
        printf "\n🔄 Abbruch. Die IP-Adresse bleibt vorerst auf DHCP. (Aktuell: %s)\n\n" "$current_ip"
    fi
     printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
     read -n 1 -s -r
     clear # Bildschirm leeren
}

smbusermanager() {
    # Prüfen ob "sudo" installiert ist
    checksudo || return 1

    # Prüfen ob "Samba" installiert ist
    checksmbinstall -sum || return 1

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
        printf "\n\n##################################################\n"
        printf "👤 Benutzer '%s' zum Samba-Server hinzufügen.\n" "$netuser"
        printf "##################################################\n\n"
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
                read -r -s -p "🔐 Kennwort: " pass1; 
                printf "\n"
                read -r -s -p "🔐 Kennwort bestätigen: " pass2; 
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
                sudo usermod -aG users "$netuser" > /dev/null
            else
                printf "\n⚙️ Erstelle neuen System-User '%s'...\n\n" "$netuser"
                sudo useradd -M -s /sbin/nologin "$netuser" > /dev/null 2>&1
                sleep 2
                sudo usermod -aG users "$netuser" > /dev/null
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
   # Prüfen ob "sudo" installiert ist
   checksudo || return 1

   local param="$1"

   if [[ "$param" != "-sum" ]]; then
   # Vor der Installation Fragen ob auf eine statische IP-Adresse umgestellt werden soll wenn noch DHCP
   smbsetstaticip || return 1
   fi

   local smb_conf="/etc/samba/smb.conf" # Samba-Server Konfigurationsdatei

  # 1. Existiert die Datei? Falls nein -> Installation anbieten
  if ! dpkg -l | grep -q "^ii  samba " >/dev/null 2>&1; then
    printf "\n\n"
    read -r -p "❓ Soll Samba jetzt automatisch installiert werden? (ja/nein): " inst_answer

    if [[ "$inst_answer" == "ja" ]]; then
        clear # Bildschirm löschen
        printf "\n\n🚀 Starte Systemaktualisierung - Bitte warten...\n\n\n"
        sudo dpkg --configure -a && sudo apt update && sudo apt --assume-yes upgrade && sudo apt --assume-yes dist-upgrade
        sudo apt --assume-yes autoremove
        sudo apt autoclean
      clear # Bildschirm leeren
      printf "\n\n🚀 Starte Installation von 'Samba' - Bitte warten...\n\n\n"
      sleep 1
      # Diese Umgebungsvariable unterdrückt alle interaktiven Dialoge (Achtung:  Nur für DEBIAN-Linux !!!)
      sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" samba samba-common-bin  # Samba-Srver istallieren
      printf "\n\n"
      printf "\n\nℹ️ Hilfspakete werden installiert - Bitte warten...\n\n\n"
      printf "\n\n"
      sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" mc # Midnight Commander
      sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" fail2ban # fail2ban installieren
      sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" iptables-persistent # iptables-persistent installieren
      sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" network-manager # Netzwerkmanager installieren

      # Nach Installation erneut prüfen
      if dpkg -l | grep -q "^ii  samba " >/dev/null 2>&1; then
       printf "\n\n✅ Samba wurde erfolgreich installiert.\n\n"
       printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
       read -n 1 -s -r

     # ============ Zusätzliche Installationen ====================
     # Fragen ob "Webmin-Manager" installiert werden soll wenn noch nicht installiert
     webmininstall -install
     # ================================
     # CUPS-Printserver installieren ?
     printserverinstall -si
     # ================================
     # Fail2Ban aktivieren
     setfail2banjail
     # ================================
     setiptables # Sicherheitseinstellungen für Pi-hole, Webmin-Manager und CUPS konfigurieren
     # ===============================================================================

        # automatisches System-Update einrichten ?
        clear # Bildschirm leeren
        printf "\n\n\n"
        read -r -p "❓ Soll ein automatisches System-Update eingerichtet werden ? (ja/nein): " au_antwort
        printf "\n"
        if [ "$au_antwort" = "ja" ]; then
        autoupdate -c
        fi
        printf "\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
        printf "\n\👤 Starte *** SAMBA BENUTZER-VERWALTUNG ***\n"
        printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n"
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
    # Hier wird SAMBA neu installiert (Achtung:  Nur für DEBIAN-Linux !!!)
    # Vor der Installation das Systen aktualisieren
    printf "\n🚀 Starte Systemupdate - Bitte warten...\n\n"
    sudo dpkg --configure -a && sudo apt update && sudo apt --assume-yes upgrade && sudo apt --assume-yes dist-upgrade
    sudo apt --assume-yes autoremove
    sudo apt autoclean
    sleep 5
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --reinstall -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" samba samba-common-bin
    return 1
  fi
}

loadsmbconfig() {
    # Prüfen ob "sudo" installiert ist
    checksudo || return 1

    local param="$1"
    if [[ "$param" != "-sms" ]]; then
    printf "\n\n⚙️ SAMBA-Server Tools Version 3.3\n\n\n"
    fi

    # Prüfen ob der Samba-Server schon installiert ist    
    if dpkg -l | grep -q "^ii  samba " >/dev/null 2>&1; then
    # Falls die Datei gar nicht existiert, direkt zur Prüfung/Erstellung springen
    [ ! -f "$CONFIG_FILE" ] && { checksmbconfig; return; }

    SAMBA_SHARES=()
    SHARE_ORDER=()
    local missing_paths=()
    local mounted_shares=() # Array für aktuell gemountete Freigaben

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

                    # Prüfen ob der Pfad aktuell gemountet ist
                    if mountpoint -q "$path"; then
                        mounted_shares+=("$name")
                    fi
                fi
            else
                missing_paths+=("Freigabe '$name': $path")
            fi
        fi
    done

    # 2. Auswertung
    if [ ${#SHARE_ORDER[@]} -gt 0 ]; then
       # printf "\n✅ Samba-Konfiguration erfolgreich geladen (%s aktive Freigaben).\n\n\n" "${#SHARE_ORDER[@]}"
         if [[ "$param" != "-sms" ]]; then
         sleep 5
         fi
         clear # Bildschirm leeren

        # --- DETAILLIERTE STATUSANZEIGE FÜR GEMOUNTETE FREIGABEN ---
        if [ ${#mounted_shares[@]} -gt 0 ]; then
            local pi_ip=$(hostname -I | awk '{print $1}')
            local user_line=$(sed -n "/\[$name\]/,/^\[/p" "$CONFIG_FILE" | grep "valid users =" | head -n1)
            local EXTRAUser=$(echo "$user_line" | cut -d'=' -f2 | cut -d',' -f2 -s | xargs)
            printf "\n"
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
            printf "🌐      STATUS - AKTIVE NETZWERK-FREIGABEN\n"
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
            if [[ -n "$EXTRAUser" && "$EXTRAUser" != "shareuser" ]]; then
                printf " 👤 %-20s : %s oder %s\n" "Benutzername" "$SAMBAMAINUSER" "$EXTRAUser"
            else
                printf " 👤 %-20s : %s\n" "Benutzername" "$SAMBAMAINUSER"
            fi
                printf " 🔓 %-20s : %s\n" "Kennwort" "SAMBA-Kennwort"
            printf "*******************************************************\n"
            for m_name in "${mounted_shares[@]}"; do
                local mp="${SAMBA_SHARES[$m_name]}"
                # Partition/Laufwerk zum Mountpoint ermitteln
                local m_part=$(findmnt -n -o SOURCE --target "$mp")
                printf " 📂 %-20s : %s\n" "Freigabename" "$m_name"
                printf " 📍 %-20s : %s\n" "Mountpoint" "$mp"
                printf " 💿 %-20s : %s\n" "Laufwerk/Partition" "$m_part"
                printf " 💻 %-20s : \\\\\\\\%s\\\\%s\n" "Windows-Pfad" "$pi_ip" "$m_name"
                printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
            done
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n"
        else
            # --- MITTEILUNG: KEINE AKTIVEN MOUNTS ---
            printf "\n"
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
            printf "🌐                          STATUS - AKTIVE NETZWERK-FREIGABEN\n"
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
            printf "📍 HINWEIS: Es sind aktuell keine Netzwerk-Laufwerke gemountet.\n"
            printf "   (Prüfen Sie die physische Verbindung oder die Einträge in der Datei '/etc/fstab')\n"
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n"
        fi

        if [ ${#missing_paths[@]} -gt 0 ]; then
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
            printf "🌐           STATUS - AKTIVE NETZWERK-FREIGABEN\n"
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
            printf "\n⚠️  WARNUNG: Folgende Pfade sind aktuell nicht erreichbar:\n"
            printf "   - %s\n" "${missing_paths[@]}" | sort -u
            printf "   (Ist das Laufwerk korrekt gemountet?)\n\n"
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n"
        fi
        return 0
    else
        checksmbconfig # SAMBA Konfiguration prüfen
    fi
    return 0 # Samba-Server ist bereits installiert
   else
    #  ******************* Samba-Server noch nicht installiert ! *********************
    sleep 3
    clear # Bildschirm leeren
    getdevices # Laufwerksanalyse starten
    printf "\n\n\n⌨️ Weiter mit beliebiger Taste (Abbruch mit Strg+C)...\n\n"
    read -n 1 -s -r
    clear # Bildschirm leeren
    # Prüfen ob die Bedingung der OS-Version stimmt
    smbcheckosversion || return 1 
    # Prüfen ob "Samba" installiert ist
    checksmbinstall || return 1
    if dpkg -l | grep -q "^ii  samba " >/dev/null 2>&1; then
    printf "\n\n✅ Der Samba-Server ist bereit.\n\n"
    # PRÜFUNG: Ist das Array leer?
    checksmbconfig || return 1
    fi
   fi
}

mountstatus() {
loadsmbconfig -sms
}

checksmbconfig() {
  # Prüfen ob "sudo" installiert ist
  checksudo || return 1

  # Prüfen ob "Samba" installiert ist
  checksmbinstall -sum || return 1

  # PRÜFUNG: Ist das Array leer?
  if [ ${#SHARE_ORDER[@]} -eq 0 ]; then
    printf "\n⚠️ Achtung: Es wurden noch keine Samba-Freigaben konfiguriert.\n\n"
    printf "\n🌐 Bitte führen Sie zuerst 'smbconfig' aus.\n\n\n"

    read -r -p "❓Möchten Sie jetzt die Samba-Konfiguration starten ? (ja/nein): " bestaetigung2
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
    checksmbinstall -sum || return 1

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
        printf "\n🌐 Zusätzlicher Benutzer nur für Netzwerkfreigabe (Enter → kein zusätzlicher Benutzer): > "
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
    if [[ "$EXTRAUSER" != "shareuser" ]]; then
    printf "\n💾 Schreibe zusätzlichen Benutzer [%s] in Samba Konfigurationsdatei %s\n\n" "$EXTRAUSER" "$CONFIG_FILE"
    fi
    for share in "${SHARE_ORDER[@]}"; do
        path="${SAMBA_SHARES[$share]}"
        local valid_users_line="$SAMBAMAINUSER"
        [[ "$EXTRAUSER" != "shareuser" ]] && valid_users_line="$SAMBAMAINUSER, $EXTRAUSER"
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
                if [[ "$EXTRAUSER" != "shareuser" ]]; then
                printf "\n🔓 Öffne Schreibrechte für Samba-User (%s) und (%s)\n\n" "$SAMBAMAINUSER" "$EXTRAUSER"
                else
                printf "\n🔓 Öffne Schreibrechte für Samba-User (%s)\n\n" "$SAMBAMAINUSER"
                fi
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
   valid users = $valid_users_line
   force user = $SAMBAMAINUSER
   public = no
EOF
    done

    echo "# <<< SAMBA-SHARES END" | sudo tee -a "$CONFIG_FILE" > /dev/null

    printf "\n✅ Samba-Konfiguration erfolgreich abgeschlossen.\n\n"
    printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
    read -n 1 -s -r
    clear # Bildschirm leeren

    # 7. fstab Abfrage
    printf "\n\n\n"
    read -r -p "❓ Soll gleich ein Eintrag in der 'fstab' erstellt werden? (ja/nein): " fstab_antwort
    printf "\n"

    if [[ "$fstab_antwort" == "ja" ]]; then
        clear && echo -e "\n\n" && getdevices
        echo -e "\n\n\n"
        read -r -p "❓ Für welches Laufwerk soll der Eintrag erstellt werden? (z.B. sdb1): " devchoice
        printf "\n"

        if [[ -n "$devchoice" ]]; then
            printf "\nℹ️ Für weitere Eintragungen rufen Sie die Funktion 'setfstab <Laufwerkspartition>' auf.\n\n"
            # *********** Eingabe Prüfen **************
            checkparameter "$devchoice" || return 1
            # *****************************************
            printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
            read -n 1 -s -r
            setfstab "$devchoice" nowfstab || return 1
        else
            printf "\n⚠️ Abbruch: Kein Laufwerk angegeben.\n\n"
            return 1
        fi
    else
     printf "\n🔄 fstab-Eintrag wird ***nicht*** erstellt.\n\n"
     printf "\nℹ️ Hinweis: Führen Sie 'setfstab <dev>' oder 'smbmount <dev>' aus.\n\n"  
    fi
}

select_mountpoint() {
  # Prüfen ob "sudo" installiert ist
  checksudo || return 1

  # PRÜFUNG: Ist das Array leer?
  checksmbconfig || return 1

  local param="$1"
  if [[ "$param" != "-smp" ]]; then
  printf "\n\n❌ Ungültige Parameterangabe - Abbruch !\n\n"
  return 1
  fi

  printf "\n\n"
  printf "✅━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━✅\n"
  printf "🌐       VERFÜGBARE SAMBA-FREIGABEN\n"
  printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

  # Manuelle Anzeige des Menüs für perfekte Spaltenausrichtung
  local i=1
  for name in "${SHARE_ORDER[@]}"; do
    # %-2s = Index, %-20s = Name (linksbündig), %s = Pfad
    printf " %s) 📝 %-20s : %s\n" "$i" "$name" "${SAMBA_SHARES[$name]}"
    ((i++))
  done
  printf " %s) ❌ %-20s\n" "$i" "Abbrechen"
  printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

  # Variable für die Auswahl
  local wahl
  local max_opt=$i

  while true; do
    printf "\n👉 Bitte wählen (1-%s): > " "$max_opt"
    read -r wahl

    # Prüfung: Ist die Eingabe eine Zahl?
    if [[ "$wahl" =~ ^[0-9]+$ ]] && [ "$wahl" -ge 1 ] && [ "$wahl" -le "$max_opt" ]; then
      
      # Wahl "Abbrechen" (letzte Nummer)
      if [ "$wahl" -eq "$max_opt" ]; then
        printf "\n⚠️ Vorgang durch Benutzer abgebrochen.\n\n"
        return 1
      fi
      
      # Gültige Freigabe gewählt
      # Index berechnen (1 ist Index 0 im Array)
      local choice_name="${SHARE_ORDER[$((wahl-1))]}"
      MOUNTPOINT="${SAMBA_SHARES[$choice_name]}"
      
      printf "\n✅ Folgende Freigabe wurde gewählt: %s\n" "$choice_name"
      printf "📍 Zielpfad (Mountpoint): %s\n\n" "$MOUNTPOINT"
      
      printf "⌨️ Weiter mit beliebiger Taste...\n"
      read -n 1 -s -r
      clear
      return 0
    else
      # Ungültige Eingabe (Buchstaben oder falsche Zahl)
      printf "\n❌ Ungültige Wahl. Bitte eine Nummer von 1 bis %s eingeben.\n" "$max_opt"
    fi
  done
}

checkparameter() {
    checksudo || return 1

    if [ "$#" -eq 0 ]; then
        printf "\n${RED}Fehler:${RESET} Eine Gerätepartition ist erforderlich (z.B. sdb1)\n\n"
        getdevices # Laufwerksanalyse
        printf "\n\n"
        return 1
    fi

    local dev="$1"
    local mode="$2"

    [[ "$dev" != /dev/* ]] && dev="/dev/$dev"

    if [ ! -b "$dev" ]; then
        printf "\n\n${RED}Fehler:${RESET} %s ist kein gültiges Blockgerät oder existiert nicht!\n\n" "$dev"
        sudo lsblk -f | grep --color=always -E "$|^.*$(basename "$dev").*$"
        printf "\n\n"
        return 1
    fi

    # --- SPEZIELLE AUSGABE FÜR HAUPTGERÄTE (ohne Partition) ---
    if [[ ! "$dev" =~ [0-9]$ ]]; then
        if [[ "$mode" == "format" ]]; then
            printf "\n\n⚠️  ${YELLOW}HINWEIS:${RESET} Sie haben das Hauptgerät %s gewählt.\n" "$dev"
            printf "\n💾  Die Formatierung wird das Laufwerk komplett neu partitionieren!\n\n"
        else
            # Hat das Hauptgerät Partitionen?
            if lsblk -no NAME "$dev" | grep -q "[0-9]$"; then
                printf "\n\n\n${RED}STOPP:${RESET} %s hat Partitionen (siehe unten).\n" "$dev"
                printf "\n⚠️  Sie müssen eine spezifische Partition wählen (z.B. ${dev}1)!\n\n\n"
                sudo lsblk -f | grep --color=always -E "$|^.*$(basename "$dev").*$"
                printf "\n\n"
                return 1
            fi
            # Normalmodus 
            local fs_type
            fs_type=$(lsblk -no FSTYPE "$dev" | tr -d '[:space:]')
            if [[ -z "$fs_type" ]]; then
                printf "\n\n\n${RED}STOPP:${RESET} %s ist ein ganzes Laufwerk ohne Dateisystem.\n" "$dev"
                printf "\n⚠️ Bitte wählen Sie eine Partition aus ! (z.B. ${dev}1)\n\n\n"
                sudo lsblk -f | grep --color=always -E "$|^.*$(basename "$dev").*$"
                printf "\n\n"
                return 1
            fi
        fi
    fi

    # --- DATEISYSTEM-CHECK (Nur wenn nicht format) ---
    if [[ "$mode" != "format" ]]; then
        local fs_type
        fs_type=$(lsblk -no FSTYPE "$dev" | tr -d '[:space:]')
        if [[ -z "$fs_type" ]]; then
            printf "\n${RED}STOPP:${RESET} %s hat kein gültiges Dateisystem!\n" "$dev"
            printf "ℹ️  Das Laufwerk muss erst mit 'format' vorbereitet werden.\n\n"
            sudo lsblk -f | grep --color=always -E "$|^.*$(basename "$dev").*$"
            printf "\n\n"
            return 1
        fi
    fi

    # --- SYSTEMLAUFWERK-SCHUTZ ---
    local root_drive=$(lsblk -no PKNAME $(findmnt -nvo SOURCE /) | tr -d '[:space:]')
    [[ -z "$root_drive" ]] && root_drive=$(lsblk -no NAME $(findmnt -nvo SOURCE /) | tr -d '[:space:]' | sed 's/[0-9]*$//')

    if [[ "$dev" == *"$root_drive"* ]]; then
        printf "\n\n${RED}STOPP:${RESET} %s gehört zum Systemlaufwerk (%s)! Zugriff verweigert.\n\n" "$dev" "$root_drive"
        sudo lsblk -f | grep --color=always -E "$|^.*$(basename "$dev").*$"
        printf "\n\n"
        return 1
    fi
    return 0
}

format() {
  clear # Bildschirm leeren

  # Prüfen ob "sudo" installiert ist
  checksudo || return 1

  if [ "$#" -eq 0 ]; then
        printf "\n\n\n⚠️ ACHTUNG: Bitte wählen Sie ein Laufwerk (Partition) aus ! (z.B. → 'format sdb' oder 'format sdb1')\n\n\n"
        getdevices # Laufwerksanalyse
        printf "\n\n"
        return 1
  fi

  # PRÜFUNG: Ist das Array leer? (nur wenn SAMBA-Server installiert ist)
  if dpkg -l | grep -q "^ii  samba " >/dev/null 2>&1; then
  checksmbconfig || return 1
  fi

  local dev
  local label="DATA"
  local fs_choice
  local fs_cmd

  # Parameter-Check mit Modus-Angabe "format"
  checkparameter "$1" "format" || return 1

  dev="/dev/$(basename "$1")"

  # --- LOGIK: Handelt es sich um eine Partition (endet auf Zahl) oder ein Hauptgerät? ---
  local is_partition=false
  [[ "$dev" =~ [0-9]$ ]] && is_partition=true

  printf "\nℹ️ Prüfe auf gemountete Partitionen...\n\n"
  smballmountsdismount || return 1  # zur Sicherheit alles dismounten

  # Laufwerkskonfiguration anzeigen
  printf "\n\n"
  sudo lsblk -f | grep --color=always -E "$|^.*$(basename "$dev").*$"
  printf "\n\n"

  # --- Dateisystem Menü ---
  printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
  if [ "$is_partition" = true ]; then
  printf "🔄 ${YELLOW}Formatierung Laufwerkspartition %s${RESET} \n" "$dev"
  else
  printf "🔄 ${YELLOW}Formatierung gesamtes Laufwerk %s${RESET}\n" "$dev"
  fi
  printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
  printf "💿      *** BITTE DATEISYSTEM WÄHLEN ***\n"
  printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
  printf "💾 1) ext4   (Standard Linux - Empfohlen)\n"
  printf "💾 2) ntfs   (Windows - Gute Kompatibilität)\n"
  printf "💾 3) fat32  (Universal - Max. 4GB pro Datei)\n"
  printf "💾 4) exfat  (Modern - Windows/Mac/Linux)\n"
  printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
  printf "\n\n"
  read -r -p "Bitte wählen (1-4): " fs_input

  case "$fs_input" in
    1) fs_choice="ext4";  fs_cmd="mkfs.ext4 -F -L" ;;
    2) fs_choice="ntfs";  fs_cmd="mkfs.ntfs -f -L" ;;
    3) fs_choice="vfat";  fs_cmd="mkfs.vfat -F 32 -n" ;;
    4) fs_choice="exfat"; fs_cmd="mkfs.exfat -n" ;;
    *) printf "\n⚠️ Ungültige Eingabe durch Benutzer - Abbruch!\n\n"; return 1 ;;
  esac

  # Prüfung ob das Tool für vfat und ntfs formatierung installiert ist
  local tool_pkg="${fs_choice}"
  [[ "$fs_choice" == "vfat" ]] && tool_pkg="dosfstools"
  [[ "$fs_choice" == "ntfs" ]] && tool_pkg="ntfs-3g"

  if ! command -v ${fs_cmd%% *} &> /dev/null; then
    printf "\n🛠️ Das Tool für %s Formatierung fehlt. Installiere %s...\n\n" "$fs_choice" "$tool_pkg"
    printf "\n🚀 Starte Systemupdate - Bitte warten...\n\n"
    sudo dpkg --configure -a && sudo apt update && sudo apt --assume-yes upgrade && sudo apt --assume-yes dist-upgrade
    sudo apt --assume-yes autoremove
    sudo apt autoclean
    sleep 5
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --reinstall -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" "$tool_pkg"
  fi

  clear # Bildschirminhalt löschen

  # HARTE SYNCHRONISATION
  printf "\nℹ️ Sync + Partitionstabelle neu laden...\n\n"
  sync
  sleep 1
  sudo blockdev --rereadpt "$dev" 2>/dev/null || sudo partprobe "$dev"
  sleep 1

  printf "\nℹ️ Ausgewähltes Laufwerk: %s\n" "$dev"
  printf "\nℹ️ *** Gewählte Formatierung: %s ***\n\n" "$fs_choice"
  sudo lsblk -f | grep --color=always -E "$|^.*$(basename "$dev").*$"
  printf "\n"

  # --- DYNAMISCHE WARNUNG ---
  if [ "$is_partition" = true ]; then
      printf "\n${YELLOW}WARNUNG:${RESET} Die Partition %s wird formatiert!\n\n\n" "$dev"
      read -r -p "❓ Letzte Chance: Wirklich die Daten auf der gewählte Partition löschen? (ja/nein): " bestaetigung2
      [[ "$bestaetigung2" != "ja" ]] && { printf "\n⚠️ Formatierung wurde abgebrochen.\n\n"; return 1; }
  else
      printf "\n${YELLOW}WARNUNG:${RESET} Das GESAMTE Laufwerk %s (inklusive ALLER Partitionen) wird gelöscht!\n\n\n" "$dev"
      read -r -p "❓ Letzte Chance: Wirklich alle Daten auf dem gewählten Laufwerk löschen? (ja/nein): " bestaetigung2
      [[ "$bestaetigung2" != "ja" ]] && { printf "\n⚠️ Formatierung wurde abgebrochen.\n\n"; return 1; }
  fi

  printf "\n🔥 ${RED}Starte Formatierung...${RESET}\n\n"
  
  # --- AUSFÜHRUNG: Unterschied Platte vs. Partition ---
  local target_dev
  if [ "$is_partition" = false ]; then
      # Ganzes Laufwerk: Neue Partitionstabelle erstellen
      sudo wipefs -a "$dev"
      sudo parted -s "$dev" mklabel gpt
      sudo parted -s "$dev" mkpart primary 1MiB 100%
      sudo partprobe "$dev"
      sleep 2
      target_dev="${dev}1"
  else
      # Nur eine Partition: Nur wipefs auf diese Partition
      sudo wipefs -a "$dev"
      target_dev="$dev"
  fi

  # Die eigentliche Formatierung
  sudo $fs_cmd "$label" "$target_dev"

  clear # Bildschirminhalt löschen

  printf "\n\n\n✅ Formatierung abgeschlossen: %s (%s) erfolgreich erstellt.\n\n\n" "$target_dev" "$fs_choice"

  # Laufwerkskonfiguration anzeigen
  sudo lsblk -f | grep --color=always -E "$|^.*$(basename "$target_dev").*$"

  if dpkg -l | grep -q "^ii  samba " >/dev/null 2>&1; then
  printf "\n\n⌨️ Weiter mit beliebiger Taste...\n\n"
  read -n 1 -s -r
  clear # Bildschirm leeren
  # fstab Frage nur wenn SAMBA-Server installiert ist
  printf "\n\n\n"
  read -r -p "❓ Soll gleich ein Eintrag in der fstab erstellt werden? (ja/nein): " fstab_antwort
  if [[ "$fstab_antwort" == "ja" ]]; then
    clear
    setfstab "$target_dev" nowfstab || return 1
  else
    printf "\n🔄 fstab-Eintrag wird ***nicht*** erstellt.\n\n\n"
    # Nach dem fstab-Eintrag: Mount-Abfrage
    read -r -p "❓ Soll das Laufwerk (\"$target_dev\") gleich gemoutet werden ? (ja/nein): " mount_antwort
    printf "\n"
    if [ "$mount_antwort" = "ja" ]; then
      clear
      smbmount "$target_dev" || return 1
    else
      printf "\n"
      printf "\nℹ️ Kein Mount durchgeführt. (%s bleibt im Sicherheitsmodus 555)\n\n" "$MOUNTPOINT"
      printf "\n⚠️ Achtung: %s ist ***nicht*** bereit für Netzwerkverbindungen.\n\n" "$MOUNTPOINT"
    fi
  fi
    fi
}

setfstab() {
  clear # Bildschirm leeren

  # Prüfen ob "sudo" installiert ist
  checksudo || return 1

  if [ "$#" -eq 0 ]; then
        printf "\n\n\n⚠️ ACHTUNG: Bitte wählen Sie ein Laufwerkspartition aus ! (z.B. → 'setfstab sdb1')\n\n\n"
        getdevices # Laufwerksanalyse
        printf "\n\n"
        return 1
  fi

  # PRÜFUNG: Ist das Array leer?
  checksmbconfig || return 1

  # Expliziter Aufruf → Fehlermeldung SICHTBAR
  checkparameter "$1" || return 1

  local dev
  local part
  local uuid
  local fstype

  dev="/dev/$(basename "$1")"

  # Nur wenn vorher nicht das dev formatiert wurde
  if [ "$2" != "nowfstab" ]; then
  printf "\nℹ️ Prüfe ob Partition noch gemountet ist...\n"
  smbdismount "$dev"
  else
  select_mountpoint -smp || return 1
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
    sudo lsblk -f | grep --color=always -E "$|^.*$(basename "$dev").*$"
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

  printf "\nℹ️ Für weitere Eintragungen rufen Sie die Funktion 'setfstab <Laufwerkspartition>' auf.\n\n"
  printf "ℹ️ UUID: %s\n" "$uuid"
  printf "ℹ️ Dateisystem: %s\n" "$fstype"
  printf "ℹ️ Laufwerk/Partition: %s\n" "$dev"
  printf "ℹ️ Mountpunkt: %s\n\n" "$MOUNTPOINT"

  printf "\n\n\n"
  read -r -p "❓'fstab'-Eintrag jetzt erstellen? (ja/nein): " antwort
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
    printf "\nℹ️ Kein Mount durchgeführt. (%s bleibt im Sicherheitsmodus 555)\n\n" "$MOUNTPOINT"
    printf "\n⚠️ Achtung: %s ist ***nicht*** bereit für Netzwerkverbindungen.\n\n" "$MOUNTPOINT"
    fi
}

smbmount() {
  # Prüfen ob "sudo" installiert ist
  checksudo || return 1

  # PRÜFUNG: Ist das Array leer?
  checksmbconfig || return 1

  # 1. Prüfen ob überhaupt ein Parameter übergeben wurde
  if [[ -z "$1" ]]; then
     # Rufe checkparameter ohne Argument auf, um die Fehlermeldung/lsblk anzuzeigen
     checkparameter
     return 1
  fi

  checkparameter "$1" || return 1

  local dev="/dev/$(basename "$1")"

  # Nur wenn vorher nicht das dev formatiert wurde
  if [ "$2" != "afterfstab" ]; then
  # Auswahl des Mountpoints abfragen
  select_mountpoint -smp || return 1
  fi

  # Wir ermitteln die Partition (z.B. /dev/sdb1), falls nur /dev/sdb angegeben wurde
  local part=$(lsblk -pnlo NAME,FSTYPE "$dev" | awk '$2!="" {print $1; exit}')

  if [ -z "$part" ]; then
    printf "${RED}Fehler:${RESET} Keine Partition mit Dateisystem auf %s gefunden!\n" "$dev"
    return 1
  fi

  # Mount-Abfrage
  local param="$2"
  if [[ "$param" != "afterfstab" ]]; then
  printf "\n\n"
  read -r -p "❓ Die gewählte Partition jetzt mounten? ($part → $MOUNTPOINT) (ja/nein): " mount_antwort
  printf "\n"
  else
  mount_antwort="ja" # Gleich auf "ja" setzen
  fi

  if [ "$mount_antwort" = "ja" ]; then
    # Prüfen, ob bereits etwas dort gemountet ist
    if mountpoint -q "$MOUNTPOINT" > /dev/null 2>&1; then
       printf "\n⚠️ Hinweis: %s ist bereits belegt. Versuche trotzdem zu mounten...\n" "$MOUNTPOINT"
    fi
      if sudo mount "$part" "$MOUNTPOINT" > /dev/null 2>&1; then
      # --- Dateisystem-Check ---
      local current_fs
      current_fs=$(findmnt -n -o FSTYPE --target "$MOUNTPOINT")

      # Zusätzlichen Benutzer ermitteln wenn vorhanden
      local name=$(for n in "${SHARE_ORDER[@]}"; do [[ "${SAMBA_SHARES[$n]}" == "$MOUNTPOINT" ]] && echo "$n" && break; done)
      local user_line=$(sed -n "/\[$name\]/,/^\[/p" "$CONFIG_FILE" | grep "valid users =" | head -n1)
      local EXTRAUser=$(echo "$user_line" | cut -d'=' -f2 | cut -d',' -f2 -s | xargs)
      local display_extra="${EXTRAUser:-$EXTRAUSER}"

      if [[ "$current_fs" =~ ^(exfat|vfat|ntfs)$ ]]; then # <--- NEU
        printf "\nℹ️  Das Dateisystem %s  wurde erkannt.\n\n" "$current_fs"
        printf "🔓 Rechte werden automatisch über die Mount-Optionen (fstab) gesteuert.\n\n"
      else
      # Optional: Auch Unterordner anpassen, falls vorhanden (Achtung:  dauert bei vielen Dateien sehr lange → Geduld)
      # sudo chmod -R 775 "$MOUNTPOINT"  # Nur bei Linux-FS (ext4) chown/chmod ausführen

          if [ -z "$EXTRAUSER" ]; then
          # Sucht die Zeile "valid users" nur im Bereich der gewählten Freigabe [$name]
          # echo "$EXTRAUser"
          if [[ -n "$EXTRAUser" && "$EXTRAUser" != "shareuser" ]]; then
            printf "\n🔓 Öffne Schreibrechte für Samba-User (%s) und (%s)\n\n" "$SAMBAMAINUSER" "$EXTRAUser"
          else
            printf "\n🔓 Öffne Schreibrechte für Samba-User (%s)\n\n" "$SAMBAMAINUSER"          
          fi
        else
          if [[ -n "$EXTRAUSER" && "$EXTRAUSER" != "shareuser" ]]; then
          printf "\n🔓 Öffne Schreibrechte für Samba-User (%s) und (%s)\n\n" "$SAMBAMAINUSER" "$EXTRAUSER" 
          else
          printf "\n🔓 Öffne Schreibrechte für Samba-User (%s)\n\n" "$SAMBAMAINUSER"
          fi
        fi
        sudo chown "$SAMBAMAINUSER":"$SAMBAMAINUSER" "$MOUNTPOINT"
        sudo chmod 775 "$MOUNTPOINT"
      fi

      # --- Starte Samba-Server wieder  -----------------------
      smbcontrol restart # Restart Samba-Server
      # -------------------------------------------------------
      local pi_ip=$(hostname -I | awk '{print $1}') # IP-Adresse des Samba-Servers 
      printf "\n"
      printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
      printf "🌐      NETZWERK-FREIGABE ERFOLGREICH GESTARTET\n"
      printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
      if [[ -n "$display_extra" && "$display_extra" != "shareuser" ]]; then
      printf " 👤 %-20s : %s oder %s\n" "Benutzername" "$SAMBAMAINUSER" "$display_extra"
      else
      printf " 👤 %-20s : %s\n" "Benutzername" "$SAMBAMAINUSER"
      fi
      printf " 🔓 %-20s : %s\n" "Kennwort" "SAMBA-Kennwort"
      printf "*******************************************************\n"
      printf " 📂 %-20s : %s\n" "Freigabename" "$name"
      printf " 📍 %-20s : %s\n" "Mountpoint" "$MOUNTPOINT"
      printf " 💿 %-20s : %s\n" "Laufwerk/Partition" "$part"
      printf " 💻 %-20s : \\\\\\\\%s\\\\%s\n" "Windows-Pfad" "$pi_ip" "$name"
      printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
      printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
      printf "ℹ️  Die Freigabe ist nun im Netzwerk erreichbar.\n\n\n"
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
  checkparameter "$1" || return 1

  local dev="/dev/$(basename "$1")"

  # 1. Auswahl des spezifischen Mountpoints abfragen
  select_mountpoint -smp || return 1

  # 2. Prüfen, ob GENAU dieser Pfad gerade gemountet ist
  if ! mountpoint -q "$MOUNTPOINT"; then
    printf "\nℹ️ %s ist zurzeit nicht gemountet.\n" "$MOUNTPOINT"
    sudo chmod 555 "$MOUNTPOINT" 2>/dev/null
    printf "\n🔒 Sicherheits-Modus: %s ist schreibgeschützt (555).\n\n" "$MOUNTPOINT"
    return 0
  fi

  # 3. Benutzer fragen (zeigt auch an, welches Device dort hängt)
  local current_source=$(findmnt -no SOURCE "$MOUNTPOINT" | head -n 1)
  printf "\nℹ️ Aktiv gemountet: %s → auf %s\n\n" "$MOUNTPOINT" "$current_source"
  printf "\n"
  read -r -p "❓Diese Freigabe jetzt dismounten? (ja/nein): " confirm
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

  # --- aktuelle Samba-Server konfig laden  ---
  loadsmbconfig
  # -------------------------------------------

  [[ $success -eq 1 ]] && printf "\n✅ Vorgang erfolgreich abgeschlossen.\n\n\n"
  [[ $success -eq 0 ]] && return 1
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
      printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
      read -n 1 -s -r
      clear # Bildschirm leeren
      return 0
    fi
  else
    # Gilt für start und restart
    if systemctl -q is-active "$service"; then
      printf "\n✅ Erfolg: Der SAMBA-Server ist aktiv/gestartet.\n\n"
      printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
      read -n 1 -s -r
      clear # Bildschirm leeren
      return 0
    fi
  fi

  # Falls die Prüfung oben nicht erfolgreich war:
  printf "\n${RED}Fehler:${RESET} Die Aktion '%s' Samba-Server konnte nicht korrekt ausgeführt werden !!!\n\n" "$action"
  return 1
}

autoupdate() {
    # Prüfen ob "sudo" installiert ist
    checksudo || return 1

    local script_path="/home/$USER/systemupdate.sh"
    local log_path="/home/$USER/systemupdate.log"
    local param="$1"
    local cron_entry=$(cat <<EOF
# Edit this file to introduce tasks to be run by cron.
#
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
#
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
#
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
#
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
#
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
#
# For more information see the manual pages of crontab(5) and cron(8)
#
# m h  dom mon dow   command
0 2 * * 2 $script_path
EOF
)
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
            printf "\n\n"
            read -r -p "⚠️ Das 'Autoupdate' existiert bereits. Überschreiben? (ja/nein): " overwrite
            [[ "$overwrite" != "ja" ]] && { printf "\n⚠️ Der Vorgang wurde abgebrochen.\n\n"; return 1; }
        fi

        # Datei erstellen mit Here-Doc (Nutzt $USER dynamisch)
        cat <<EOF > "$script_path"
#!/bin/bash
rm -f "$log_path"
date > "$log_path" 2>&1
sudo apt-get update >> "$log_path" 2>&1
sudo apt-get --assume-yes upgrade >> "$log_path" 2>&1
sudo apt-get --assume-yes dist-upgrade >> "$log_path" 2>&1
sudo apt-get --assume-yes upgrade --fix-missing >> "$log_path" 2>&1
sudo apt-get --assume-yes autoremove >> "$log_path" 2>&1
sudo apt-get autoclean >> "$log_path" 2>&1
echo "***Neustart***" >> "$log_path" 2>&1
sudo reboot >> "$log_path" 2>&1
EOF
        # Ausführbar machen
        chmod +x "$script_path"

        # --- NEUE CRONTAB HIER ---
        local current_cron
        current_cron=$(crontab -l 2>/dev/null)

        if [[ -z "$current_cron" ]]; then
            # Crontab ist leer: Nur cron_entry schreiben
            echo "$cron_entry" | crontab -
        else
            # Crontab existiert: Alten Job entfernen, neuen cron_entry anhängen
            (echo "$current_cron" | grep -vF "$script_path"; echo "$cron_entry") | crontab -
        fi
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
    # Prüfen ob "sudo" installiert ist
    checksudo || return 1

    # --- PRÜFUNG: Ist Deutsch schon aktiv? ---
    local kbd_check=0
    local lang_check=0

    if grep -q 'XKBLAYOUT="de"' /etc/default/keyboard 2>/dev/null; then
        kbd_check=1
    fi

    if [[ "$LANG" == "de_DE.UTF-8" ]]; then
        lang_check=1
    fi

    if [[ $kbd_check -eq 0 || $lang_check -eq 0 ]]; then
        # Betriebssystem Version prüfen
        export LC_ALL=C.UTF-8
        export LANG=C.UTF-8
        export LANGUAGE=C.UTF-8
        printf "\n🌐 Stelle Systemsprache und Tastatur auf Deutsch um - Bitte warten...\n\n\n"

        # Tastatur-Konfiguration schreiben
        cat <<-EOF | sudo tee /etc/default/keyboard > /dev/null
XKBMODEL="pc105"
XKBLAYOUT="de"
XKBVARIANT=""
XKBOPTIONS=""
BACKSPACE="guess"
EOF
        # Alle anderen Sprachen deaktivieren
        sudo sed -i 's/^[^#]/# &/g' /etc/locale.gen

        # Deutsch hinzufügen
        echo "de_DE.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen > /dev/null
        # System-Locale Dateien schreiben (Greift nach dem Reboot)
        echo "LANG=de_DE.UTF-8" | sudo tee /etc/default/locale > /dev/null
        echo "LC_ALL=de_DE.UTF-8" | sudo tee -a /etc/default/locale > /dev/null
        # Sprache physisch generieren
        sudo locale-gen de_DE.UTF-8 > /dev/null 2>&1
        # Offiziell im System registrieren
        sudo update-locale LANG=de_DE.UTF-8 LC_ALL=de_DE.UTF-8
        # Tastatur für die aktuelle Sitzung aktivieren
        sudo loadkeys de 2>/dev/null
        # Zeitzone setzen
        if [[ "$(cat /etc/timezone 2>/dev/null)" != "Europe/Berlin" ]]; then
            sudo timedatectl set-timezone Europe/Berlin 2>/dev/null
        fi
        printf "\n✅ Systemsprache und Tastatur erfolgreich auf Deutsch umgestellt.\n\n"
        return 1
    else
        printf "\nℹ️ Systemsprache und Tastatur sind bereits auf Deutsch eingestellt.\n\n"
        return 0
    fi
}

getipv4() {
 clear # Bildschirm leeren
 # Wir holen die IPv4-Adresse
 local IPv4
 IPv4=$(hostname -I | awk '{print $1}')
 if [[ -n "$IPv4" ]]; then
 printf "\nℹ️ Die IPv4-Adresse lautet: '%s'\n\n" "$IPv4"
 else
 printf "\n⚠️ Keine IPv4-Adresse gefunden!\n\n" 
 fi 
}

webmininstall() {
    # Prüfen ob "sudo" installiert ist
    checksudo || return 1

    local param="$1"
    local spinner="/|\\-"
    local i=1

    clear
    printf "\n\n\n"
    printf "\n🔍 Prüfe Installationsstatus von grafischer Oberfläche 'Webmin-Manager'...\n\n"

    for j in {1..8}; do
        i=$(( (i % 4) + 1 ))
        printf "\b%s" "${spinner:$i-1:1}"
        sleep 0.1
    done

    local check_result=$(dpkg -l 2>/dev/null | grep "webmin")

    if [[ -n "$check_result" ]]; then
        printf "\b✅ Prüfung Installationsstatus - fertig...\n"
        printf "\n🚀 Die grafische Oberfläche 'Webmin-Manager' ist bereits installiert.\n"
        local version=$(echo "$check_result" | awk '{print $3}')
        printf "   -> Version: $version\n\n"
        printf "\n✅ Zugriff über: https://%s:10000\n\n" "$(hostname -I | awk '{print $1}')"
        printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
        read -n 1 -s -r
        clear # Bildschirm leeren
        return 0
    else
        printf "\b \b" 
    fi

    printf "\n\n"
    read -r -p "❓ Möchten Sie die grafische Oberfläche 'Webmin-Manager' jetzt installieren? (ja/nein): " wmconfirm
    
    if [[ "$wmconfirm" == "ja" ]]; then
        printf "\n\n"
        if [[ "$param" != "-install" ]]; then
            printf "\n🚀 Starte Systemupdate - Bitte warten...\n\n"
            sudo dpkg --configure -a && sudo apt update && sudo apt --assume-yes upgrade && sudo apt --assume-yes dist-upgrade
            sudo apt --assume-yes autoremove
            sudo apt autoclean
        fi
        
        # Abhängigkeiten installieren
        sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" curl gnupg2 apt-transport-https
        
        printf "\n\n🚀 Starte Webmin-Manager-Installation - Bitte warten...\n\n"
        # Repository direkt anlegen
        # echo "deb [signed-by=/usr/share/keyrings/webmin-archive-keyring.gpg] https://download.webmin.com/download/repository sarge contrib" | sudo tee /etc/apt/sources.list.d/webmin.list > /dev/null
        # Offizielles Webmin Repository-Setup-Skript laden und ausführen
        # Dies fügt automatisch den Key und die Sources hinzu
        sudo curl -o setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh
        sudo sh setup-repos.sh -f  # -f erzwingt die Ausführung ohne erneute Bestätigung
        # Webmin-Manager installieren
        sudo apt-get install -y webmin --install-recommends
        # Aufräumen
        sudo rm -f setup-repos.sh # -f erzwingt die Ausführung ohne erneute Bestätigung
        # -----------------------------------------------------------------------------
        check_result=$(dpkg -l 2>/dev/null | grep "webmin")
        if [[ -z "$check_result" ]]; then
        printf "\n❌ FEHLER: Der 'Webmin-Manager' konnte nicht installiert werden !\n\n"
        printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
        read -n 1 -s -r
        return 1
        fi

        # --- SPRACHEINSTELLUNG ---
        if [ -f "/etc/webmin/config" ]; then
            printf "\n⚙️ Stelle Webmin-Sprache auf Deutsch um...\n"
            sudo sed -i '/^lang=/d' /etc/webmin/config
            echo "lang=de" | sudo tee -a /etc/webmin/config > /dev/null
            sudo sed -i '/^lang_char/d' /etc/webmin/config
            echo "lang_char=UTF-8" | sudo tee -a /etc/webmin/config > /dev/null
            # Dienst neu starten für Sprachübernahme
            sudo systemctl restart webmin > /dev/null 2>&1
        fi

        # Fix für die /tmp RAM-Disk Meldung
        if [ -f "/etc/webmin/config" ]; then
        printf "\n⚙️ Optimiere Webmin Temp-Verzeichnis (RAM-Disk Fix)...\n\n"
        # Neuen Ordner erstellen
        sudo mkdir -p /var/webmin_tmp
        sudo chown root:root /var/webmin_tmp
        sudo chmod 777 /var/webmin_tmp
        # Webmin anweisen, diesen Ordner zu nutzen
        sudo sed -i '/^tempdir=/d' /etc/webmin/config
        echo "tempdir=/var/webmin_tmp" | sudo tee -a /etc/webmin/config > /dev/null
    
    # Dienst neu starten
    sudo systemctl restart webmin > /dev/null 2>&1
    printf "✅ Webmin Temp-Verzeichnis wurde nach /var/webmin_tmp verschoben.\n"
fi
            clear # Bildschirm leern
            printf "\n\n\n"
            printf "\n=====================================================\n"
            printf "✅ WEBMIN-MANAGER ERFOLGREICH INSTALLIERT\n"
            printf "=====================================================\n"
            printf "🌐 Web-Interface:  https://%s:10000\n" "$(hostname -I | awk '{print $1}')"
            printf "👤 Admin-User:     %s\n" "$USER"
            printf "🔐 Passwort:       Systempasswort für den Login.\n"
            printf "=====================================================\n\n"
                 
        if [[ "$param" == "-install" ]]; then
            printf "⌨️ Weiter mit beliebiger Taste...\n\n"
            read -n 1 -s -r
            clear
        else
            printf "\n\n⌨️ Weiter mit beliebiger Taste...\n\n"
            read -n 1 -s -r
            clear
            printf "\n🚀 Das System muss neu gestartet werden, um 'Webmin-Manager' zu aktivieren.\n\n"
            printf "\n🔄 Der Neustart erfolgt in 5 Sekunden (Abbruch mit Strg+C)...\n\n"
            sleep 5
            sudo reboot
        fi
    else
        printf "\n⏩ Die grafische Oberfläche 'Webmin-Manager' wird ***nicht*** installiert.\n\n"
        printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
        read -n 1 -s -r
        clear
    fi
}

setfail2banjail() {
    printf "\n🛡️ Konfiguriere Fail2Ban Schutz (dynamische Erkennung)...\n\n"
    
    local my_ip=$(hostname -I | awk '{print $1}')

    # --- Check: Was ist wirklich installiert und aktiv? ---
    local apache_active="false"
    local lighttpd_active="false"
    local webmin_active="false"
    local ssh_active="false"

    # Prüfen ob die Dienste/Verzeichnisse existieren
    command -v apache2 >/dev/null 2>&1 && apache_active="true"
    command -v lighttpd >/dev/null 2>&1 && lighttpd_active="true"
    [[ -d "/etc/webmin" ]] && webmin_active="true"
    
    # Prüfen ob SSH im System aktiv ist
    systemctl is-active --quiet ssh && ssh_active="true"

    # 1. Datei: fail2ban.local (IPv6 Support - nur wenn IPv6 aktiviert ist)
    if ip -6 addr show 2>/dev/null | grep -q "scope global"; then
      local f2b_conf="/etc/fail2ban/fail2ban.local"
      if ! grep -q "allowipv6 = auto" "$f2b_conf" 2>/dev/null; then
        printf "➕ Konfiguriere IPv6-Unterstützung...\n"
        echo -e "[DEFAULT]\nallowipv6 = auto" | sudo tee "$f2b_conf" > /dev/null
      fi
    fi

    # 2. Datei: jail.local (Zentrale Konfiguration)
    printf "➕ Erstelle Jail-Datei: 'jail.local'...\n"
    sudo cat <<-EOF | sudo tee /etc/fail2ban/jail.local > /dev/null
[DEFAULT]
ignoreip = 127.0.0.1/8 ::1 $my_ip
bantime  = 86400
maxretry = 5
backend  = systemd

[sshd]
enabled = $ssh_active
port    = ssh
filter  = sshd

[apache-auth]
enabled = $apache_active
filter  = apache-auth
port    = http,https
logpath = /var/log/apache2/error.log

[lighttpd-custom]
enabled = $lighttpd_active
port    = http,https
logpath = /var/log/lighttpd/error.log
filter  = lighttpd-custom
EOF

    # 3. Webmin-Manager Jail Logik (Nur wenn Webmin aktiv ist)
    if [[ "$webmin_active" == "true" ]]; then
        printf "➕ Erstelle Jail-Datei 'webmin.conf'...\n"
        sudo cat <<-EOF | sudo tee /etc/fail2ban/jail.d/webmin.conf > /dev/null
[webmin-auth]
enabled = $webmin_active
port    = 10000
filter  = webmin-auth
backend = systemd
EOF
    else
        sudo rm -f /etc/fail2ban/jail.d/webmin.conf 2>/dev/null
        printf "\n🧹 Die grafische Oberfläche 'Webmin-Manager' wurde nicht gefunden – Jail-Datei wird entfernt!\n"
    fi

    # Neustart und Status-Ausgabe
    printf "\n🔄 Der 'Fail2Ban' Dienst wird neu gestartet...\n\n"
    sudo systemctl restart fail2ban
    sleep 5
    if systemctl is-active --quiet fail2ban; then
        printf "\n✅ Die 'Fail2Ban' Konfiguration ist abgeschlossen:\n"
        printf "👉 - SSH:      $([[ "$ssh_active" == "true" ]] && echo "AKTIV ✅" || echo "INAKTIV ❌")\n"
        printf "👉 - Webmin:   $([[ "$webmin_active" == "true" ]] && echo "AKTIV ✅" || echo "INAKTIV ❌")\n"
        printf "👉 - Webserver: $([[ "$apache_active" == "true" || "$lighttpd_active" == "true" ]] && echo "AKTIV ✅" || echo "INAKTIV ❌")\n\n"
    else
        printf "\n❌ Fehler beim Starten von 'Fail2Ban' - Abbruch!\n\n"
    fi
 printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
 read -n 1 -s -r
 clear # Bildschirm leeren
}

setiptables() {
if command -v iptables >/dev/null 2>&1; then
     clear # Bildschirm leeren
     printf "\n\n🚀 *** Die Sicherheitseinstellungen für die installierten Programme werden eingerichtet ... ***\n\n"

     printf "\n\n➕ *** Sicherheitseinstellungen für SAMBA-Server\n"

     # --- Automatisierung für iptables-persistent (für BEIDE Fälle v4/v6) ---
     echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
     echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections

     # --- Eigene Ketten für IPv4 und IPv6 erstellen (falls nicht vorhanden) ---
     sudo iptables -N SAMBA_RULES 2>/dev/null
     sudo ip6tables -N SAMBA_RULES 2>/dev/null

     # --- Nur die eigenen Ketten leeren (fremde Regeln bleiben aktiv!) ---
     sudo iptables -F SAMBA_RULES
     sudo ip6tables -F SAMBA_RULES

     # --- Verknüpfung zur Haupt-Firewall (INPUT) herstellen, falls nötig ---
     if ! sudo iptables -C INPUT -j SAMBA_RULES 2>/dev/null; then
          sudo iptables -I INPUT 1 -j SAMBA_RULES
     fi
     if ! sudo ip6tables -C INPUT -j SAMBA_RULES 2>/dev/null; then
          sudo ip6tables -I INPUT 1 -j SAMBA_RULES
     fi

     if ip -6 addr show 2>/dev/null | grep -q "scope global"; then
     # ******** IPv4 & IPv6 ***********
     sudo iptables -A SAMBA_RULES -i lo -j ACCEPT # Loopback IPv4
     sudo iptables -A SAMBA_RULES -m state --state ESTABLISHED,RELATED -j ACCEPT # Bestehende Verbindungen IPv4
     sudo ip6tables -A SAMBA_RULES -i lo -j ACCEPT # Loopback IPv6
     sudo ip6tables -A SAMBA_RULES -m state --state ESTABLISHED,RELATED -j ACCEPT # Bestehende Verbindungen IPv6

     # 1. ZUERST: Den Zugriff auf das Web-Interface für Dich selbst erlauben (WICHTIG!)
     sudo iptables -A SAMBA_RULES -p tcp --dport 443 -j ACCEPT # für Webinterface
     sudo ip6tables -A SAMBA_RULES -p tcp --dport 443 -j ACCEPT # für Webinterface
     
     if dpkg -l | grep -q "^ii  cups "; then
          printf "\n➕ *** Sicherheitseinstellungen für CUPS Printserver\n"
          sudo iptables -A SAMBA_RULES -p tcp --dport 631 -j ACCEPT  # Für Printserver
          sudo iptables -A SAMBA_RULES -p udp --dport 631 -j ACCEPT  # Für Printserver 
          sudo ip6tables -A SAMBA_RULES -p tcp --dport 631 -j ACCEPT # Für Printserver 
          sudo ip6tables -A SAMBA_RULES -p udp --dport 631 -j ACCEPT # Für Printserver 
          sudo iptables -A SAMBA_RULES -p udp --dport 5353 -j ACCEPT # Für AirPrint/mDNS
          sudo ip6tables -A SAMBA_RULES -p udp --dport 5353 -j ACCEPT # Für AirPrint/mDNS
     fi
     
        if dpkg -l | grep -q "^ii  webmin " || [ -d "/etc/webmin" ]; then
          printf "\n➕ *** Sicherheitseinstellungen für Webmin-Manager\n"
          sudo iptables -A SAMBA_RULES -p tcp --dport 10000 -j ACCEPT # Für Webmin-Manager
          sudo ip6tables -A SAMBA_RULES -p tcp --dport 10000 -j ACCEPT # Für Webmin-Manager
        fi

     # 2. DANACH: Den restlichen "Müll" blockieren
     sudo iptables -A SAMBA_RULES -p tcp --destination-port 80 -j REJECT --reject-with tcp-reset # für Pi-hole
     sudo iptables -A SAMBA_RULES -p tcp --destination-port 8080 -j REJECT --reject-with tcp-reset # für Pi-hole
     sudo iptables -A SAMBA_RULES -p udp --destination-port 80 -j REJECT --reject-with icmp-port-unreachable # für Pi-hole
     sudo iptables -A SAMBA_RULES -p udp --destination-port 8080 -j REJECT --reject-with icmp-port-unreachable # für Pi-hole
     sudo ip6tables -A SAMBA_RULES -p tcp --destination-port 80 -j REJECT --reject-with tcp-reset # für Pi-hole
     sudo ip6tables -A SAMBA_RULES -p tcp --destination-port 8080 -j REJECT --reject-with tcp-reset # für Pi-hole
     sudo iptables -A SAMBA_RULES -p tcp --destination-port 443 -j REJECT --reject-with tcp-reset # für Webinterface
     sudo ip6tables -A SAMBA_RULES -p tcp --destination-port 443 -j REJECT --reject-with tcp-reset # für Webinterface
     
     if dpkg -l | grep -q "^ii  cups "; then
          sudo iptables -A SAMBA_RULES -p tcp --destination-port 631 -j REJECT --reject-with tcp-reset  # Für Printserver
          sudo iptables -A SAMBA_RULES -p udp --destination-port 631 -j REJECT --reject-with icmp-port-unreachable # Für Printserver
          sudo ip6tables -A SAMBA_RULES -p tcp --destination-port 631 -j REJECT --reject-with tcp-reset # Für Printserver
          sudo ip6tables -A SAMBA_RULES -p udp --destination-port 631 -j REJECT --reject-with icmp6-port-unreachable # Für Printserver
     fi
     
     if dpkg -l | grep -q "^ii  webmin " || [ -d "/etc/webmin" ]; then
          sudo iptables -A SAMBA_RULES -p tcp --destination-port 10000 -j REJECT --reject-with tcp-reset # Für Webmin-Manager
          sudo ip6tables -A SAMBA_RULES -p tcp --destination-port 10000 -j REJECT --reject-with tcp-reset # Für Webmin-Manager
     fi
     
     else
     # ******** Nur IPv4 ***********
     # 1. ZUERST: Den Zugriff auf das Web-Interface für Dich selbst erlauben (WICHTIG!)
     sudo iptables -A SAMBA_RULES -i lo -j ACCEPT # Loopback IPv4
     sudo iptables -A SAMBA_RULES -m state --state ESTABLISHED,RELATED -j ACCEPT # Bestehende Verbindungen IPv4
    
     sudo iptables -A SAMBA_RULES -p tcp --dport 80 -j ACCEPT # für Pi-hole
     sudo iptables -A SAMBA_RULES -p tcp --dport 8080 -j ACCEPT # für Pi-hole
     sudo iptables -A SAMBA_RULES -p tcp --dport 443 -j ACCEPT # für Webinterface
     
     if dpkg -l | grep -q "^ii  cups "; then
      printf "\n➕ *** Sicherheitseinstellungen für CUPS Printserver\n"
      sudo iptables -A SAMBA_RULES -p tcp --dport 631 -j ACCEPT # für Printserver
      sudo iptables -A SAMBA_RULES -p udp --dport 631 -j ACCEPT  # für Printserver
      sudo iptables -A SAMBA_RULES -p udp --dport 5353 -j ACCEPT # Für AirPrint/mDNS
     fi
     
     if dpkg -l | grep -q "^ii  webmin " || [ -d "/etc/webmin" ]; then
       printf "\n➕ *** Sicherheitseinstellungen für Webmin-Manager\n"
       sudo iptables -A SAMBA_RULES -p tcp --dport 10000 -j ACCEPT # für Webmin-Manager
     fi

     # 2. DANACH: Den restlichen "Müll" blockieren
     sudo iptables -A SAMBA_RULES -p tcp --destination-port 80 -j REJECT --reject-with tcp-reset # für Pi-hole
     sudo iptables -A SAMBA_RULES -p tcp --destination-port 8080 -j REJECT --reject-with tcp-reset # für Pi-hole
     sudo iptables -A SAMBA_RULES -p tcp --destination-port 443 -j REJECT --reject-with tcp-reset # für Webinterface
     
     if dpkg -l | grep -q "^ii  cups "; then
          sudo iptables -A SAMBA_RULES -p tcp --destination-port 631 -j REJECT --reject-with tcp-reset # Für Printserver
          sudo iptables -A SAMBA_RULES -p udp --destination-port 631 -j REJECT --reject-with icmp-port-unreachable # Für Printserver
     fi
     
     if dpkg -l | grep -q "^ii  webmin " || [ -d "/etc/webmin" ]; then
          sudo iptables -A SAMBA_RULES -p tcp --destination-port 10000 -j REJECT --reject-with tcp-reset # Für Webmin-Manager
     fi
     fi

     # IPTables speichern & Erfolgsmeldung
     sudo netfilter-persistent save > /dev/null 2>&1
     printf "\n\n🎉 *** Die Sicherheitseinstellungen für die installierten Programme wurden abgeschlossen ***\n\n"
     printf "\n\n⌨️ Weiter mit beliebiger Taste...\n\n"
     read -n 1 -s -r
else
     printf "\n\n🎉 *** Die Sicherheitseinstellungen für die installierten Programme konnten ***nicht*** abgeschlossen werden !\n\n" 
     printf "\n\n⌨️ Weiter mit beliebiger Taste...\n\n"
     read -n 1 -s -r
fi
}

printserverinstall() {
     local ip_addr=$(hostname -I | awk '{print $1}')
     local param="$1"

     # 1. PRÜFUNG: Ist CUPS schon installiert?
     if dpkg -l | grep -q "^ii  cups "; then
        printf "\n🖨️  Der 'CUPS-Printserver' ist bereits auf diesem System installiert.\n\n"            
        printf "\n=====================================================\n"
        printf "✅ CUPS PRINT-SERVER ZUGANGSDATEN\n"
        printf "=====================================================\n"
        printf "🌐 Web-Interface:  http://%s:631/admin\n" "$ip_addr"
        printf "👤 Admin-User:     %s\n" "$USER"
        printf "🔐 Passwort:       Systempasswort für den Login.\n"
        printf "=====================================================\n\n"
        return 0
    fi
    clear # Bildschirm leeren
    printf "\n\n" # Leerzeilen einfügen
    printf "==================================================\n"
    printf "============= EXTRA Optionen =====================\n"
    printf "==================================================\n\n\n"
    printf "\n❓ Möchten Sie jetzt den 'CUPS Print-Server' installieren? (ja/nein): "
    read -r cups_confirm

    if [[ "$cups_confirm" == "ja" ]]; then
    local cups_conf="/etc/cups/cupsd.conf"
        
        # 1. Systemupdate vorab
        if [[ "$param" != "-si" ]]; then
        printf "\n🚀 Starte Aktualisierung der Systempakete (Update & Upgrade)...\n\n"
        sudo dpkg --configure -a && sudo apt update && sudo apt --assume-yes upgrade && sudo apt --assume-yes dist-upgrade
        sudo apt --assume-yes autoremove
        sudo apt autoclean
        printf "\n\n🔄 Systemaktualisierung abgeschlossen\n\n"
        printf "\n\n⌨️ Weiter mit beliebiger Taste...\n\n"
        read -n 1 -s -r
        fi

        # 2. Installation von CUPS
        printf "\n\n🖨️ Die 'CUPS-Printserver' Pakete werden installiert - Bitte warten...\n\n"
        sleep 3
        if sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
            -o Dpkg::Options::="--force-confdef" \
            -o Dpkg::Options::="--force-confold" \
            cups printer-driver-gutenprint; then
            # 3. Konfiguration für Netzwerkzugriff
            clear # Bildschirm leeren
            printf "\n⚙️ CUPS: Netzwerkzugriff und Admin-Rechte werden konfiguriert - Bitte warten...\n\n"
            
            # Erlaubt Zugriff von anderen PCs im Netzwerk & Filesharing via cupsctl
            sudo cupsctl WebInterface=yes --remote-admin --remote-any --share-printers
            
            # Fügt den aktuellen User der Admin-Gruppe hinzu
            sudo usermod -aG lpadmin "$USER"

            # CUPS Weboberfläche auf Deutsch optimieren
            if [ -f "/etc/cups/cupsd.conf" ]; then
              printf "\n⚙️ Optimiere CUPS-Spracheinstellungen der Weboberfläche...\n\n"
             # Standard-Zeichensatz auf UTF-8 festlegen (wichtig für deutsche Umlaute)
             sudo sed -i '/^DefaultCharset/d' /etc/cups/cupsd.conf
             echo "DefaultCharset utf-8" | sudo tee -a /etc/cups/cupsd.conf > /dev/null
             # Standard-Sprache auf Deutsch setzen
             sudo sed -i '/^DefaultLanguage/d' /etc/cups/cupsd.conf
             echo "DefaultLanguage de" | sudo tee -a /etc/cups/cupsd.conf > /dev/null
             printf "\n✅ Die CUPS-Sprache der Weboberfläche wurde optimiert.\n\n"
           fi

            # 4. CUPS Dienst aktivieren und neu starten 
            printf "\n🖨️ Der 'CUPS-Printserver' wird aktiviert - Bitte warten...\n\n"
            sudo systemctl enable --now cups > /dev/null 2>&1
            sudo systemctl restart cups > /dev/null 2>&1
            sleep 5 

            printf "\n=====================================================\n"
            printf "✅ CUPS PRINT-SERVER ERFOLGREICH INSTALLIERT\n"
            printf "=====================================================\n"
            printf "🌐 Web-Interface:  https://%s:631/admin\n" "$ip_addr"
            printf "👤 Admin-User:     %s\n" "$USER"
            printf "🔐 Passwort:       Systempasswort für den Login.\n"
            printf "=====================================================\n\n"
            printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
            read -n 1 -s -r
            clear # Bildschirm leeren
        else
            printf "\n❌ Fehler: Die Installation von 'CUPS-Printserver' ist fehlgeschlagen.\n\n"
            return 1
        fi
    else
        printf "\n⏭️ Die 'CUPS-Printserver' Installation wird übersprungen.\n\n"
        printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
        read -n 1 -s -r
        clear # Bildschirm leeren
    fi
}

# Funktion beim start der .bashrc Datei AUFRUFEN (muss ganz unten stehen)
loadsmbconfig  # existierende Freigaben laden
