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
alias rb='echo && echo Reboot System && sudo reboot'
alias cpu-temp='clear && vcgencmd measure_temp'
alias cpu-volt='clear && vcgencmd measure_volts'
alias cpu-takt='clear && vcgencmd measure_clock arm'
alias cpu-com='clear && vcgencmd commands'
alias sd='echo && echo Shutdown System && sudo shutdown -h 0'
alias piconfig='sudo raspi-config'
alias cls='clear'
alias swap-off='sudo swapoff -a'
alias swap-on='sudo swapon -a'
alias swap-disable='sudo service dphys-swapfile stop && free && sudo systemctl disable dphys-swapfile && sudo apt-get purge dphys-swapfile'
alias swap-enable='sudo systemctl enable dphys-swapfile && sudo systemctl enable dphys-swapfile'
alias autoupdate-log='sudo cat /var/log/unattended-upgrades/unattended-upgrades.log'
alias pi-uptime='uptime -p'
alias xdir='ls -la'
alias setting-ipv6='./ipv6.sh'
alias setipv6='./ipv6.sh'
alias getipv6='ip a ls |grep inet6'
alias config-bash='sudo nano /home/pi/.bashrc'
alias memory='df -h'
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
# Disk-Tools (Secure Data Carrier Manager)
#                (GB)
#              June 2026
#   Version 3.3 von Mario Ammerschuber
#
# WARNING: May irrevocably delete data!
# ------------------------------------------

# ****** Global Variable Declaration ******
# SAMBA-Server MainUser
SAMBAMAINUSER=${SAMBAMAINUSER:-$USER}

# 2. User for Network Drive Connections
EXTRAUSER=""

# Define arrays globally at the beginning.
declare -A SAMBA_SHARES
declare -a SHARE_ORDER
export CONFIG_FILE="/etc/samba/smb.conf"

RED='\033[0;31m' # Red text
GREEN='\033[0;32m' # green text
YELLOW='\033[0;33m' # yellow text
RESET='\033[0m'  # Colored Text – End

# The variable for the result (empty)
MOUNTPOINT=""

checksudo() {
# Check if "sudo" is installed
    if ! command -v sudo &> /dev/null; then
    printf "\n❌ Error: 'sudo' is not installed.\n\n"
    printf "\n📍 Please log in as 'root' and install it with: > apt update && apt upgrade && apt install sudo\n\n"
    return 1
  fi
}

getdevices() {
    checksudo || return 1

    # Identifying the System Drive
    local root_drive=$(lsblk -no PKNAME $(findmnt -nvo SOURCE /) | tr -d '[:space:]')
    [[ -z "$root_drive" ]] && root_drive=$(lsblk -no NAME $(findmnt -nvo SOURCE /) | tr -d '[:space:]' | sed 's/[0-9]*$//')

    printf "\n"
    printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    printf "📊  DRIVE ANALYSIS ( ${RED}ROT = System${RESET} | ${GREEN}GREEN = Samba Option${RESET} | ${YELLOW}YELLOW = Virtuell${RESET} )\n"
    printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

    sudo lsblk -f | while read -r line; do
        [[ -z "$line" ]] && continue

        # Always display header normally
        if [[ "$line" =~ ^NAME ]]; then
            printf "%s\n" "$line"
            continue
        fi

        # 1. CHECK: Virtual Devices/Swap (loop, zram) -> YELLOW
        # We check whether the line BEGINS (^) with "loop" or "zram".
        if [[ "$line" =~ ^loop ]] || [[ "$line" =~ ^zram ]]; then
            echo -e "${YELLOW}${line}${RESET}"
            continue
        fi

        # 2. CHECK: System Drive -> RED
        if [[ "$line" == *"$root_drive"* ]]; then
            echo -e "${RED}${line}${RESET}"
        else
            # 3. CHECK: Everything else -> GREEN
            echo -e "${GREEN}${line}${RESET}"
        fi
    done
    printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n"
}

bootconfig() {
    printf "\n🚀 Optimizing boot configuration for USB mode...\n"
    
    local bootconf="/boot/firmware/config.txt"
    # Fallback for older OS versions
    [ ! -f "$bootconf" ] && bootconf="/boot/config.txt"

    # CHECK: Is the entry already present?
    if grep -q "program_usb_boot_mode=1" "$bootconf"; then
        printf "\nℹ️ Boot parameters are already configured in %s.\n\n" "$bootconf"
        return 0
    else
        printf "\n➕ Adding boot parameters...\n\n"
    if sudo bash -c "cat >> $bootconf" <<-EOF > /dev/null 2>&1
# --- USB Boot & Power Tuning ---
# WLAN deativate, Server do not run over WLAN !!!
dtoverlay=disable-wifi
# Bluetooth disable
dtoverlay=disable-bt
# Boot from USB
program_usb_boot_mode=1
# more Power for USB-Ports
max_usb_current=1
# Start delay 15 Seconds
boot_delay=15 
program_usb_boot_timeout=1
EOF
    then
    printf "\n✅ Boot parameters added successfully.\n\n"
    return 1
     else
     printf "\n❌ Error: Boot parameters could not be saved!\n\n"
     return 2 # ERROR: Writing failed!
    fi
  fi
}

smbcheckosversion() {
    # 1. Extract the pure version number (e.g. 11 or 12 etc.)
    # tr -d '"' removes possible quotation marks around the number
    local os_ver os_id
    os_id=$(grep "^ID=" /etc/os-release | cut -d= -f2 | tr -d '"' | xargs)
    os_ver=$(grep "^VERSION_ID=" /etc/os-release | cut -d= -f2 | tr -d '"')

    printf "\n🔍 Checking operating system version...\n"

    # If the variable is empty (safety check)
    if [[ -z "$os_ver" ]]; then
        printf "\n❌ Error: The OS version could not be determined. - Aborting!\n\n\n"
        return 1
    fi

    # Check if the OS is Debian
    if [[ "$os_id" != "debian" ]]; then
        printf "\n❌ Error: This script is designed for 'Debian' Linux only - Aborting!\n\n\n"
        return 1
    fi

    # 2. Comparison: must be version 13 (Trixi) or higher
    if [ "$os_ver" -ge 13 ] 2>/dev/null; then
        printf "\n✅ System version %s detected (OK).\n\n" "$os_ver" 
        # ========================================================
        # ********************************************
        local_lang_gb # Set language to English (GB)
        # ********************************************
        local lang_changed=$?
        bootconfig # Add additional boot parameters
        local boot_changed=$?
          # Restart if necessary
          if [ $lang_changed -ne 0 ] || [ $boot_changed -ne 0 ]; then
          printf "\n🚀 The system must be restarted to apply the changes.\n\n"
          printf "\n🔄 Restarting in 5 seconds (Cancel with Ctrl+C)...\n\n"
          sleep 5
          sudo reboot
          return 1
          fi
       return 0
    else
        printf "\n❌ Error: This function set requires at least version 13 (Trixi) of the operating system.\n\n"
        printf "\n⚠️ The current version is: %s\n\n" "$os_ver"
        printf "\n🚫 Unfortunately, we must abort at this point.\n\n"
        return 1
    fi
}

smbsetstaticip() {
    # Check if "sudo" is installed
    checksudo || return 1

    # If NetworkManager is not installed, install it
    if ! command -v nmcli >/dev/null 2>&1; then
    printf "\n\nℹ️ The 'Network-Manager' needs to be installed - please wait...\n\n"
    printf "\n🚀 Starting system update - please wait...\n\n"
      sudo dpkg --configure -a && sudo apt update && sudo apt --assume-yes upgrade && sudo apt --assume-yes dist-upgrade
      sudo apt --assume-yes autoremove
      sudo apt autoclean
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" network-manager # Install NetworkManager
    printf "\n\n🚀 The system must restart to activate the 'Network-Manager'.\n\n"
    printf "\n🔄 Restarting in 15 seconds (Cancel with Ctrl+C)...\n\n"
    sleep 15
    sudo reboot
    return 1
    fi

    local skip_file="/home/$USER/.skip_ip_check"
    local sparam="$1"

    # --- Parameter check (Silent) ---
    if [[ "$1" == "-clear" ]]; then
    rm -f "$skip_file" 2>/dev/null
    fi

    # 1. Determine active interface (Language neutral)
    local interface
    interface=$(nmcli -t -f DEVICE,STATE device status | grep -E ":connected|:verbunden" | head -n 1 | cut -d: -f1)

    if [[ -z "$interface" ]]; then
        printf "\n❌ Error: No connected network interface found! - Aborting!\n\n"
        return 1
    fi

    # 2. Find the name of the active connection
    local conn_name
    conn_name=$(nmcli -t -f NAME,DEVICE connection show --active | grep ":$interface" | cut -d: -f1)

    if [[ -z "$conn_name" ]]; then
        printf "\n❌ Error: No active profile found for %s. - Aborting!\n\n" "$interface"
        return 1
    fi

    # 3. Query method via the CONNECTION
    local method
    method=$(nmcli -g ipv4.method connection show "$conn_name")

    # 4. We also get the IP via the CONNECTION
    local current_ip=$(nmcli -g ip4.address connection show "$conn_name" | cut -d/ -f1)

    # --- Warning for Wi-Fi operation ---
    if [[ "$interface" == w* ]]; then
        printf "\n⚠️ WARNING: The Samba server is running via Wi-Fi (%s)!\n\n" "$interface"
        printf "A LAN cable is recommended for maximum stability and speed.\n\n"
        read -r -p "❓ Continue anyway? (yes/no): " wlan_confirm
        [[ "$wlan_confirm" != "yes" ]] && { printf "\n🔄 Aborted by user.\n\n"; return 1; }
    fi

    if [[ "$method" == "manual" ]]; then
        # printf "\n✅ The interface [%s] is already using a STATIC IP address.\n\n" "$interface"
        return 0
    fi

    # If the flag file exists, we skip the prompt
    if [[ -f "$skip_file" ]]; then
        return 0  # User had opted for DHCP
    fi

    # 3. Offer conversion
    printf "\n🌐 Current status for [%s]: DHCP (Dynamic IP Address)\n\n" "$interface"
    read -r -p "❓ Would you like to switch to a STATIC IP address now? (yes/no/never): " sip_antwort

    if [[ "$sip_antwort" == "yes" ]]; then
        clear # Clear screen
        printf "\n\n\n--- Static IP Address Configuration ---\n"
        printf "\nℹ️  Note: Choose an IP address outside the DHCP pool.\n\n"
        printf "      (e.g., FritzBox usually: .2 to .19 or .201 to .253)\n\n"

        local base_ip=$(echo "$current_ip" | cut -d. -f1-3)

        # Query gateway via CONNECTION, not via DEVICE
        local current_gw=$(nmcli -g ipv4.gateway connection show "$conn_name")

        # --- Internal validation function ---
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
            read -r -p "👉 Static IP address [Suggestion: ${base_ip}.212]: " new_ip
            new_ip=${new_ip:-"${base_ip}.212"}

            if ! validate_ip "$new_ip"; then
                printf "\n❌ Error: '%s' is not a valid IP address (0-254, end cannot be 0/255)!\n\n" "$new_ip"
                continue
            fi

            printf "\n🔍 Checking if IP address %s is available...\n\n" "$new_ip"
            if ping -c 1 -W 1 "$new_ip" >/dev/null 2>&1; then
                printf "\n❌ OCCUPIED: Another device is already using this IP address!\n\n"
            else
                break
            fi
        done

        # --- GATEWAY IP address ---
        local new_gw
        local def_gw="${current_gw:-${base_ip}.1}"
        while true; do
            read -r -p "👉 Gateway IP address (Router) - [Suggestion: $def_gw]: " new_gw
            new_gw=${new_gw:-"$def_gw"}
            # CORRECTION: ! for "If NOT valid", then error message
            if ! validate_ip "$new_gw"; then
                printf "\n❌ Error: '%s' is not a valid gateway IP address!\n\n" "$new_gw"
            else
                break
            fi
        done

        # --- DNS IP address ---
        local new_dns
        while true; do
            printf "\n\n"
            read -r -p "👉 DNS Server IP address - [Suggestion: $new_gw]: " new_dns
            new_dns=${new_dns:-$new_gw}
            # CORRECTION: ! for "If NOT valid", then error message
            if ! validate_ip "$new_dns"; then
                printf "\n❌ Error: '%s' is not a valid DNS IP address!\n\n" "$new_dns"
            else
                break
            fi
        done

        # --- IMPLEMENTATION ---
        clear # Clear screen
        printf "\n\n⚙️ Applying settings for [%s]...\n\n" "$conn_name"

        sudo nmcli connection modify "$conn_name" \
            ipv4.addresses "${new_ip}/24" \
            ipv4.gateway "$new_gw" \
            ipv4.dns "$new_dns" \
            ipv4.method manual

        rm -f "$skip_file" 2>/dev/null
        printf "\n✅ Static IP address successfully configured.\n\n"
        printf "\n🚀 Restarting in 5 seconds to switch to the new IP address - please wait...\n\n"
        sleep 5
        sudo reboot
        exit 0

    elif [[ "$sip_antwort" == "never" ]]; then
        printf "SAMBA-Server - User opted for a DHCP address on $(date +'%m/%d/%Y at %H:%M')!" > "$skip_file"
        printf "\n✅ The SAMBA server IP address remains on DHCP configuration. (Current: %s)\n\n" "$current_ip"
    else
        printf "\n🔄 Aborted. The IP address remains on DHCP for now. (Current: %s)\n\n" "$current_ip"
    fi
     printf "\n⌨️ Press any key to continue...\n\n"
     read -n 1 -s -r
     clear # Clear screen
}

smbusermanager() {
    # Check if "sudo" is installed
    checksudo || return 1

    # Check if "Samba" is installed
    checksmbinstall -sum || return 1

    local netuser="$1" # First parameter
    local choice
    local pass1 pass2 pass3 pass4
    local MAX_LEN=75

    clear # Clear screen

    # Parameter mode or menu mode?
    if [[ -n "${netuser// /}" ]]; then
        # --- PARAMETER MODE ---
        if sudo pdbedit -L -u "$netuser" &>/dev/null; then
          return 1 # User already exists - output no message
        fi
        printf "\n\n##################################################\n"
        printf "👤 Adding user '%s' to Samba server.\n" "$netuser"
        printf "##################################################\n\n"
        choice="1"
    else
        # --- MENU MODE ---
        printf "\n👤 *** SAMBA USER MANAGEMENT ***\n"
        printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
        printf " 1) Add user\n"
        printf " 2) Delete user\n"
        printf " 3) List users\n"
        printf " 4) Change user password\n"
        printf " 5) Cancel\n"
        printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
        read -r -p "Please choose (1-5): " choice

        if [[ ! "$choice" =~ ^[1-5]$ ]]; then
            printf "\n❌ Error: '%s' is not a valid selection (1-5).\n\n" "$choice"
            return 1
        fi

        if [[ "$choice" == "3" ]]; then
            printf "\n📋 Registered Samba users:\n"
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
            sudo pdbedit -L | awk -F: '{print "👤 " $1 " (UID: " $2 ")"}'
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n"
            return 0
        elif [[ "$choice" == "5" || -z "$choice" ]]; then
            printf "\n👤 User management canceled.\n\n\n"
            return 1
        fi

        printf "\n\n\n"
        read -r -p "👤 Please enter username: " netuser
    fi

    # ==========================================================================
    # CENTRAL VALIDATION (Applies to both Parameter AND Menu)
    # ==========================================================================

    # 1. Cleaning (Must happen BEFORE checks!)
    netuser=$(echo "$netuser" | xargs)

    # 2. Check for empty input
    if [[ -z "$netuser" ]]; then
        printf "\n⚠️  Attention: No username entered - Aborting!\n\n"
        return 1
    fi

    # 3. Enforce lowercase
    if [[ ! "$netuser" =~ ^[a-z0-9]+$ ]]; then
        printf "\n❌ Error: Only lowercase letters and numbers are allowed!\n\n"
        printf "👉 The input '%s' is invalid.\n\n" "$netuser"
        return 1
    fi

    # 4. Check for maximum length
    if [[ ${#netuser} -gt "$MAX_LEN" ]]; then
        printf "\n❌ Error: Username is too long with %s characters (max %s).\n\n" "${#netuser}" "$MAX_LEN"
        return 1
    fi

    # 5. Minimum 3 characters required for username
    if [[ ! "$netuser" =~ ^.{3,}$ ]]; then
        printf "\n❌ Error: At least 3 characters are required. - Aborting!\n\n"
        return 1
    fi

    # ==========================================================================

    case "$choice" in
        1) # --- ADD USER ---
           # Note: netuser is already cleaned by central validation

            # First, check if already in Samba
            if sudo pdbedit -L -u "$netuser" &>/dev/null; then
                printf "\n⚠️  The user '%s' is already a Samba user!\n\n" "$netuser"
                printf "ℹ️  Use option 4 to change their password.\n\n"
                return 1
            fi

            # --- Password Validation Loop ---
            while true; do
                printf "\n🔐 Set password for '%s':\n\n" "$netuser"
                read -r -s -p "🔐 Password: " pass1; 
                printf "\n"
                read -r -s -p "🔐 Confirm password: " pass2; 
                printf "\n"

                if [[ -z "$pass1" ]]; then
                    printf "❌ Error: Password cannot be empty!\n\n"
                elif [[ ${#pass1} -lt 6 ]]; then
                    printf "❌ Error: Password too short (min. 6 characters required)!\n\n"
                elif [[ "$pass1" != "$pass2" ]]; then
                    printf "❌ Error: Passwords do not match!\n\n"
                else
                    break # Password is valid
                fi

                read -r -p "🔄 Try again now? (yes/no): " retry
                [[ "$retry" != "yes" && "$retry" != "ja" ]] && { printf "\n⚠️ Operation canceled by user.\n\n"; return 1; }
            done

            printf "\n⚙️ User is being processed - please wait...\n\n"
            if id "$netuser" &>/dev/null; then
                printf "\nℹ️ User '%s' already exists in the system - just activating for Samba server...\n" "$netuser"
                sudo usermod -aG users "$netuser" > /dev/null
            else
                printf "\n⚙️ Creating new system user '%s'...\n\n" "$netuser"
                sudo useradd -M -s /sbin/nologin "$netuser" > /dev/null 2>&1
                sleep 2
                sudo usermod -aG users "$netuser" > /dev/null
            fi
            sleep 2

            # Pass password to Samba
            if ! (echo "$pass1"; echo "$pass1") | sudo smbpasswd -s -a "$netuser"; then
                printf "\n❌ Error: Samba password could not be set.\n\n"
                printf "⚙️ Please check for system user leftovers manually.\n"
                smbcontrol restart
                return 1
            fi
            sudo smbpasswd -e "$netuser" > /dev/null
            printf "\n✅ Samba user '%s' was successfully set up.\n\n" "$netuser"
            smbcontrol restart
            ;;

        4)  # --- CHANGE USER PASSWORD ---
            netuser=$(echo "$netuser" | xargs)

            # Extended check: Does user exist in Linux OR Samba?
            if [[ "$(id -un "$netuser" 2>/dev/null)" != "$netuser" ]]; then
             printf "\n⚠️  Attention: The user '%s' does not exist - Aborting!\n\n" "$netuser"
              return 1
            fi

             while true; do
             printf "\n🔐 Set new password for '%s':\n\n" "$netuser"
             read -r -s -p "🔐 New password: " pass3
             printf "\n"
             read -r -s -p "🔐 Confirm password: " pass4
             printf "\n"

             if [[ -z "$pass3" ]]; then
                  printf "❌ Error: Password cannot be empty!\n\n"
             elif [[ ${#pass3} -lt 6 ]]; then
                  printf "❌ Error: Password too short (min. 6 characters required)!\n\n"
             elif [[ "$pass3" != "$pass4" ]]; then
                 printf "❌ Error: Passwords do not match!\n\n"
             else
                 break # Password is valid
             fi

             read -r -p "🔄 Try again now? (yes/no): " retry
             [[ "$retry" != "yes" && "$retry" != "ja" ]] && { printf "\n⚠️ Operation canceled by user.\n\n"; return 1; }
            done

            # 1. Set Samba password
            if ! (echo "$pass3"; echo "$pass3") | sudo smbpasswd -s -a "$netuser"; then
           printf "\n❌ Error: Samba password could not be set.\n\n"
           return 1
           fi
           sudo smbpasswd -e "$netuser" > /dev/null  # Set Samba password

           # 2. Sync system password (ONLY if it is the main user $SAMBAMAINUSER)
           if [[ "$netuser" == "$SAMBAMAINUSER" ]]; then
             printf "⚙️ Synchronizing system password for '%s'...\n" "$SAMBAMAINUSER"
             echo "$netuser:$pass3" | sudo chpasswd   # Change Linux system password only for main user
           fi

           printf "\n✅ Password for user '%s' has been successfully changed.\n\n" "$netuser"
           ;;

        2) # --- DELETE ---
           # Cleaning: Removes any leading/trailing spaces
           netuser=$(echo "$netuser" | xargs)

           # Extended check: Does user exist in Linux OR Samba?
           if [[ "$(id -un "$netuser" 2>/dev/null)" != "$netuser" ]]; then
               printf "\n⚠️  Attention: The user '%s' does not exist - Aborting!\n\n" "$netuser"
               return 1
           fi

           # Safety Check: Is it the current system user?
           if [[ "$netuser" == "$USER" ]]; then
               printf "\n❌ Security Lock: The system account ('%s') cannot be deleted here!\n\n" "$USER"
               return 1
           fi

           printf "\n⚠️  Should '%s' really be completely deleted (System & Samba)? " "$netuser"
           read -r -p "👉 (yes/no): " delconfirm1
           if [[ "$delconfirm1" == "yes" || "$delconfirm1" == "ja" ]]; then
               # Second prompt
               printf "\n"
               read -r -p "❓ Are you absolutely sure? (yes/no): " delconfirm2
               if [[ "$delconfirm2" == "yes" || "$delconfirm2" == "ja" ]]; then
                   printf "\n⚙️  Deletion process in progress - Please wait...\n\n"
                   # Delete from Samba first, then from the system
                   sudo smbpasswd -x "$netuser" &>/dev/null
                   sleep 2
                   sudo pdbedit -x -u "$netuser" &>/dev/null
                   sleep 2
                   sudo userdel "$netuser" 2>/dev/null
                   printf "\n✅ The user '%s' has been fully removed from the entire system.\n\n" "$netuser"
                   # --- Restart Samba server ---------------------------
                   printf "\n🔄 Restarting Samba server...\n\n";
                   smbcontrol restart # Restart Samba-Server
                   # -------------------------------------------------------
               else
                   # Answer to the SECOND question was no
                   printf "\n👤 The user '%s' will *** not *** be fully removed from the entire system.\n\n" "$netuser"
               fi
           else
               # Answer to the FIRST question was no
               printf "\n👤 The user '%s' will *** not *** be fully removed from the entire system.\n\n" "$netuser"
           fi
           ;;

        *) printf "\n⚠️  Invalid selection - Aborting!\n\n"; return 1 ;;
    esac
}

checksmbinstall() {
   # Check if "sudo" is installed
   checksudo || return 1

   local param="$1"

   if [[ "$param" != "-sum" ]]; then
   # Before installation, ask if the system should switch to a static IP if DHCP is still active
   smbsetstaticip || return 1
   fi

   local smb_conf="/etc/samba/smb.conf" # Samba server configuration file

  # 1. Does the file exist? If no -> offer installation
  if ! dpkg -l | grep -q "^ii  samba " >/dev/null 2>&1; then
    printf "\n\n"
    read -r -p "❓ Should Samba be installed automatically now? (yes/no): " inst_answer

    if [[ "$inst_answer" == "yes" || "$inst_answer" == "ja" ]]; then
        clear # Clear screen
        printf "\n\n🚀 Starting system update - Please wait...\n\n\n"
        sudo dpkg --configure -a && sudo apt update && sudo apt --assume-yes upgrade && sudo apt --assume-yes dist-upgrade
        sudo apt --assume-yes autoremove
        sudo apt autoclean
      clear # Clear screen
      printf "\n\n🚀 Starting installation of 'Samba' - Please wait...\n\n\n"
      sleep 1
      # This environment variable suppresses all interactive dialogs (Caution: Only for DEBIAN Linux !!!)
      sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" samba samba-common-bin  # Install Samba server
      printf "\n\n"
      printf "\n\nℹ️ Installing helper packages - Please wait...\n\n\n"
      printf "\n\n"
      sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" mc # Midnight Commander
      sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" fail2ban # Install fail2ban
      sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" iptables-persistent # Install iptables-persistent
      sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" network-Manager # Install NetworkManager

      # Re-check after installation
      if dpkg -l | grep -q "^ii  samba " >/dev/null 2>&1; then
       printf "\n\n✅ Samba has been successfully installed.\n\n"
       printf "\n⌨️ Press any key to continue...\n\n"
       read -n 1 -s -r

     # ============ Additional Installations ====================
     # Ask if "Webmin-Manager" should be installed if not already present
     webmininstall -install
     # ================================
     # Install CUPS print server?
     printserverinstall -si
     # ================================
     # Activate Fail2Ban
     setfail2banjail
     # ================================
     setiptables # Configure security settings for Pi-hole, Webmin-Manager, and CUPS
     # ===============================================================================

        # Set up automatic system updates?
        clear # Clear screen
        printf "\n\n\n"
        read -r -p "❓ Should automatic system updates be configured? (yes/no): " au_antwort
        printf "\n"
        if [[ "$au_antwort" == "yes" || "$au_antwort" == "ja" ]]; then
        autoupdate -c
        fi
        printf "\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
        printf "\n👤 Starting *** SAMBA USER MANAGEMENT ***\n"
        printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n"
        printf "\n⌨️ Press any key to continue...\n\n"
        read -n 1 -s -r
        smbusermanager "$SAMBAMAINUSER" # Start user manager
        return 0
      else
        printf "\n❌ Installation failed. - Aborting!\n\n"
        return 1
      fi
    else
      printf "\n💾 Abort: These functions cannot be used without Samba.\n\n"
      return 1
    fi
  fi

  # 2. Is the file empty? (Size 0)
  if [[ ! -s "$smb_conf" ]]; then
    printf "\n⚠️ WARNING: The file %s is empty!\n" "$smb_conf"
    printf "\n♻️ Attempting to repair the configuration...\n\n"
    # Here SAMBA is reinstalled (Caution: Only for DEBIAN Linux !!!)
    # Update the system before installation
    printf "\n🚀 Starting system update - Please wait...\n\n"
    sudo dpkg --configure -a && sudo apt update && sudo apt --assume-yes upgrade && sudo apt --assume-yes dist-upgrade
    sudo apt --assume-yes autoremove
    sudo apt autoclean
    sleep 5
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --reinstall -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" samba samba-common-bin
    return 1
  fi
}

loadsmbconfig() {
    # Check if "sudo" is installed
    checksudo || return 1

    local param="$1"
    if [[ "$param" != "-sms" ]]; then
    printf "\n\n⚙️ SAMBA Server Tools Version 3.3\n\n\n"
    fi

    # Check if the Samba server is already installed    
    if dpkg -l | grep -q "^ii  samba " >/dev/null 2>&1; then
    # If the file does not exist, jump directly to check/creation
    [ ! -f "$CONFIG_FILE" ] && { checksmbconfig; return; }

    SAMBA_SHARES=()
    SHARE_ORDER=()
    local missing_paths=()
    local mounted_shares=() # Array for currently mounted shares

    # 1. Read share names (duplicates cleaned by 'sort -u')
    local names=$(grep -Po '^\[\K[^\]]+' "$CONFIG_FILE" | grep -Ev '^(global|homes|printers|print\$)')

    for name in $names; do
        # Extract path: Use 'head -n1' for the first match only,
        # in case a name appears twice in the file.
        local path=$(sed -n "/\[$name\]/,/^\[/p" "$CONFIG_FILE" | grep "path =" | head -n1 | cut -d'=' -f2 | xargs)

        if [[ -n "$path" ]]; then
            if [ -d "$path" ]; then
                # Check if this name is already in the array (prevents duplicate display)
                if [[ -z "${SAMBA_SHARES[$name]}" ]]; then
                    SAMBA_SHARES["$name"]="$path"
                    SHARE_ORDER+=("$name")

                    # Check if the path is currently mounted
                    if mountpoint -q "$path"; then
                        mounted_shares+=("$name")
                    fi
                fi
            else
                missing_paths+=("Share '$name': $path")
            fi
        fi
    done

    # 2. Evaluation
    if [ ${#SHARE_ORDER[@]} -gt 0 ]; then
       # printf "\n✅ Samba configuration successfully loaded (%s active shares).\n\n\n" "${#SHARE_ORDER[@]}"
         if [[ "$param" != "-sms" ]]; then
         sleep 5
         fi
         clear # Clear screen

        # --- DETAILED STATUS DISPLAY FOR MOUNTED SHARES ---
        if [ ${#mounted_shares[@]} -gt 0 ]; then
            local pi_ip=$(hostname -I | awk '{print $1}')
            local user_line=$(sed -n "/\[$name\]/,/^\[/p" "$CONFIG_FILE" | grep "valid users =" | head -n1)
            local EXTRAUser=$(echo "$user_line" | cut -d'=' -f2 | cut -d',' -f2 -s | xargs)
            printf "\n"
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
            printf "🌐      STATUS - ACTIVE NETWORK SHARES\n"
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
            if [[ -n "$EXTRAUser" && "$EXTRAUser" != "shareuser" ]]; then
                printf " 👤 %-20s : %s or %s\n" "Username" "$SAMBAMAINUSER" "$EXTRAUser"
            else
                printf " 👤 %-20s : %s\n" "Username" "$SAMBAMAINUSER"
            fi
                printf " 🔓 %-20s : %s\n" "Password" "SAMBA Password"
            printf "*******************************************************\n"
            for m_name in "${mounted_shares[@]}"; do
                local mp="${SAMBA_SHARES[$m_name]}"
                # Determine partition/drive for the mount point
                local m_part=$(findmnt -n -o SOURCE --target "$mp")
                printf " 📂 %-20s : %s\n" "Share Name" "$m_name"
                printf " 📍 %-20s : %s\n" "Mount Point" "$mp"
                printf " 💿 %-20s : %s\n" "Drive/Partition" "$m_part"
                printf " 💻 %-20s : \\\\\\\\%s\\\\%s\n" "Windows Path" "$pi_ip" "$m_name"
                printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
            done
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n"
        else
            # --- NOTICE: NO ACTIVE MOUNTS ---
            printf "\n"
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
            printf "🌐                          STATUS - ACTIVE NETWORK SHARES\n"
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
            printf "📍 NOTE: No network drives are currently mounted.\n"
            printf "   (Check physical connection or entries in the file '/etc/fstab')\n"
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n"
        fi

        if [ ${#missing_paths[@]} -gt 0 ]; then
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
            printf "🌐           STATUS - ACTIVE NETWORK SHARES\n"
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
            printf "\n⚠️  WARNING: The following paths are currently unreachable:\n"
            printf "   - %s\n" "${missing_paths[@]}" | sort -u
            printf "   (Is the drive correctly mounted?)\n\n"
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
            printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n"
        fi
        return 0
    else
        checksmbconfig # Check SAMBA configuration
    fi
    return 0 # Samba server is already installed
   else
    #  ******************* Samba server not yet installed ! *********************
    sleep 3
    clear # Clear screen
    getdevices # Start drive analysis
    printf "\n\n\n⌨️ Press any key to continue (Abort with Ctrl+C)...\n\n"
    read -n 1 -s -r
    clear # Clear screen
    # Check if OS version condition is met
    smbcheckosversion || return 1 
    # Check if "Samba" is installed
    checksmbinstall || return 1
    if dpkg -l | grep -q "^ii  samba " >/dev/null 2>&1; then
    printf "\n\n✅ The Samba server is ready.\n\n"
    # CHECK: Is the array empty?
    checksmbconfig || return 1
    fi
   fi
}

mountstatus() {
loadsmbconfig -sms
}

checksmbconfig() {
  # Check if "sudo" is installed
  checksudo || return 1

  # Check if "Samba" is installed
  checksmbinstall -sum || return 1

  # CHECK: Is the array empty?
  if [ ${#SHARE_ORDER[@]} -eq 0 ]; then
    printf "\n⚠️ Warning: No Samba shares have been configured yet.\n\n"
    printf "\n🌐 Please run 'smbconfig' first.\n\n\n"

    read -r -p "❓ Would you like to start the Samba configuration now? (yes/no): " bestaetigung2
    printf "\n"
     if [ "$bestaetigung2" != "yes" ]; then
     printf "\n⚠️ Process aborted by user.\n\n"
     return 1
     else
     smbconfig # Start SAMBA server configuration
     return 1
     fi
  else
     return 0
  fi
}

smbconfig() {
    # Check if "sudo" is installed
    checksudo || return 1

    # Check if "Samba" is installed
    checksmbinstall -sum || return 1

    local sharename1 sharename2 sharename3 share path
    local MAX_LEN=75
    local old_locale=$LC_ALL
    export LC_ALL=C

    clear  # Clear screen

    smballmountsdismount || return 1  # Dismount everything

    printf "\nℹ️ *** Enter the desired share names here (A-Z, 0-9 only) ***\n\n"

    # --- Input & Validation Share 1 ---
    while true; do
        printf "\n🌐 Name for share 1 (required): > "
        read -r sharename1
        [[ -z "$sharename1" ]] && { printf "\n❌ Error: Name cannot be empty.\n\n"; continue; }
        [[ ! "$sharename1" =~ ^[a-zA-Z0-9]+$ ]] && { printf "\n❌ Error: Only letters (A-Z) and numbers (0-9) allowed.\n\n"; continue; }
        [[ ${#sharename1} -gt $MAX_LEN ]] && { printf "\n❌ Error: The name for share 1 is too long (max. $MAX_LEN).\n\n"; continue; }
        break
    done

    # --- Input & Validation Share 2 ---
    while true; do
        printf "\n🌐 Name for share 2 (Enter for 'Freigabe2'): > "
        read -r sharename2
        sharename2=${sharename2:-Freigabe2}
        [[ "$sharename2" == "$sharename1" ]] && { printf "\n❌ Error: Name already taken.\n\n"; continue; }
        [[ ! "$sharename2" =~ ^[a-zA-Z0-9]+$ ]] && { printf "\n❌ Error: Only letters (A-Z) and numbers (0-9) allowed.\n\n"; continue; }
        [[ ${#sharename2} -gt $MAX_LEN ]] && { printf "\n❌ Error: The name for share 2 is too long (max. $MAX_LEN).\n\n"; continue; }
        break
    done

    # --- Input & Validation Share 3 ---
    while true; do
        printf "\n🌐 Name for share 3 (Enter for 'Freigabe3'): > "
        read -r sharename3
        sharename3=${sharename3:-Freigabe3}
        [[ "$sharename3" == "$sharename1" || "$sharename3" == "$sharename2" ]] && { printf "\n❌ Error: Name already taken.\n\n"; continue; }
        [[ ! "$sharename3" =~ ^[a-zA-Z0-9]+$ ]] && { printf "\n❌ Error: Only letters (A-Z) and numbers (0-9) allowed.\n\n"; continue; }
        [[ ${#sharename3} -gt $MAX_LEN ]] && { printf "\n❌ Error: The name for share 3 is too long (max. $MAX_LEN).\n\n"; continue; }
        break
    done

    # --- Input & Validation User ---
    while true; do
        printf "\n"
        printf "\n🌐 Additional user for network share only (Enter → no additional user): > "
        read -r EXTRAUSER
        EXTRAUSER=${EXTRAUSER:-shareuser}
        [[ ! "$EXTRAUSER" =~ ^[a-z0-9]+$ ]] && { printf "\n❌ Error: Only lowercase letters and numbers allowed!\n\n"; continue; }
        [[ ! "$EXTRAUSER" =~ ^[a-z0-9]{3,}$ ]] && { printf "\n❌ Error: Minimum 3 characters, and only a-z and 0-9 allowed.\n\n"; continue; }
        [[ ${#EXTRAUSER} -gt $MAX_LEN ]] && { printf "\n❌ Error: The name for the additional user is too long (max. $MAX_LEN).\n\n"; continue; }
        break
    done

    # Reset language for the rest of the function
    export LC_ALL=$old_locale
    clear # Clear screen

    # Start user manager if an extra network user was specified
    if [[ "$EXTRAUSER" != "shareuser" ]]; then
    smbusermanager "$EXTRAUSER"
    fi

    # 4. Fill global arrays
    SAMBA_SHARES=(
        ["$sharename1"]="/home/${SAMBAMAINUSER}/shared1"
        ["$sharename2"]="/home/${SAMBAMAINUSER}/shared2"
        ["$sharename3"]="/home/${SAMBAMAINUSER}/shared3"
    )
    SHARE_ORDER=("$sharename1" "$sharename2" "$sharename3")

    # 5. Remove old shares from smb.conf
    if grep -q "# >>> SAMBA-SHARES START" "$CONFIG_FILE" 2>/dev/null; then
        printf "\n♻️ Removing old shares from %s...\n\n\n" "$CONFIG_FILE"
        local cmd='/^$/{N;/# >>> SAMBA-SHARES START/D;};'
        cmd+='/# >>> SAMBA-SHARES START/,/# <<< SAMBA-SHARES END/d'
        sudo sed -i "$cmd" "$CONFIG_FILE"
    fi

    echo "" | sudo tee -a "$CONFIG_FILE" > /dev/null
    cat <<EOF | sudo tee -a "$CONFIG_FILE" > /dev/null
# >>> SAMBA-SHARES START
# Last update: $(date '+%d.%m.%Y %H:%M')
EOF

    # 6. Create folders and write to smb.conf
    if [[ "$EXTRAUSER" != "shareuser" ]]; then
    printf "\n💾 Writing additional user [%s] to Samba configuration file %s\n\n" "$EXTRAUSER" "$CONFIG_FILE"
    fi
    for share in "${SHARE_ORDER[@]}"; do
        path="${SAMBA_SHARES[$share]}"
        local valid_users_line="$SAMBAMAINUSER"
        [[ "$EXTRAUSER" != "shareuser" ]] && valid_users_line="$SAMBAMAINUSER, $EXTRAUSER"
        if [ ! -d "$path" ]; then
            printf "\n📂 Creating folder %s...\n" "$path"
            mkdir -p "$path"
            # --- Filesystem check ---
            # Check the mount point of the path
            local fs_type
            fs_type=$(findmnt -n -o FSTYPE --target "$path" 2>/dev/null)

            if [[ "$fs_type" == "exfat" || "$fs_type" == "vfat" || "$fs_type" == "ntfs" ]]; then
                printf "\nℹ️  Filesystem %s detected: Skipping chown/chmod (permissions are controlled via mount options).\n\n" "$fs_type"
            else
                if [[ "$EXTRAUSER" != "shareuser" ]]; then
                printf "\n🔓 Opening write permissions for Samba users (%s) and (%s)\n\n" "$SAMBAMAINUSER" "$EXTRAUSER"
                else
                printf "\n🔓 Opening write permissions for Samba user (%s)\n\n" "$SAMBAMAINUSER"
                fi
                sudo chown "$SAMBAMAINUSER:$SAMBAMAINUSER" "$path"
                sudo chmod 0775 "$path"
            fi
        fi
        printf "💾 Writing share name [%s] to Samba configuration file %s\n\n" "$share" "$CONFIG_FILE"
        cat <<EOF | sudo tee -a "$CONFIG_FILE" > /dev/null

[$share]
   comment = Raspberry Pi Share
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

    printf "\n✅ Samba configuration successfully completed.\n\n"
    printf "\n⌨️ Press any key to continue...\n\n"
    read -n 1 -s -r
    clear # Clear screen

    # 7. fstab query
    printf "\n\n\n"
    read -r -p "❓ Should an entry in 'fstab' be created now? (yes/no): " fstab_antwort
    printf "\n"

    if [[ "$fstab_antwort" == "ja" ]]; then
        clear && echo -e "\n\n" && getdevices
        echo -e "\n\n\n"
        read -r -p "❓ For which drive should the entry be created? (e.g., sdb1): " devchoice
        printf "\n"

        if [[ -n "$devchoice" ]]; then
            printf "\nℹ️ To add further entries, call the function 'setfstab <drive_partition>'.\n\n"
            # *********** Check parameter **************
            checkparameter "$devchoice" || return 1
            # *****************************************
            printf "\n⌨️ Press any key to continue...\n\n"
            read -n 1 -s -r
            setfstab "$devchoice" nowfstab || return 1
        else
            printf "\n⚠️ Abort: No drive specified.\n\n"
            return 1
        fi
    else
     printf "\n🔄 fstab entry will ***not*** be created.\n\n"
     printf "\nℹ️ Note: Run 'setfstab <dev>' or 'smbmount <dev>'.\n\n"  
    fi
}

select_mountpoint() {
  # Check if "sudo" is installed
  checksudo || return 1

  # CHECK: Is the array empty?
  checksmbconfig || return 1

  local param="$1"
  if [[ "$param" != "-smp" ]]; then
  printf "\n\n❌ Invalid parameter specification - Abort !\n\n"
  return 1
  fi

  printf "\n\n"
  printf "✅━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━✅\n"
  printf "🌐       AVAILABLE SAMBA SHARES\n"
  printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

  # Manual display of the menu for perfect column alignment
  local i=1
  for name in "${SHARE_ORDER[@]}"; do
    # %-2s = Index, %-20s = Name (left-aligned), %s = Path
    printf " %s) 📝 %-20s : %s\n" "$i" "$name" "${SAMBA_SHARES[$name]}"
    ((i++))
  done
  printf " %s) ❌ %-20s\n" "$i" "Cancel"
  printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

  # Variable for the selection
  local wahl
  local max_opt=$i

  while true; do
    printf "\n👉 Please choose (1-%s): > " "$max_opt"
    read -r wahl

    # Check: Is the input a number?
    if [[ "$wahl" =~ ^[0-9]+$ ]] && [ "$wahl" -ge 1 ] && [ "$wahl" -le "$max_opt" ]; then
      
      # Choice "Cancel" (last number)
      if [ "$wahl" -eq "$max_opt" ]; then
        printf "\n⚠️ Process aborted by user.\n\n"
        return 1
      fi
      
      # Valid share chosen
      # Calculate index (1 is index 0 in the array)
      local choice_name="${SHARE_ORDER[$((wahl-1))]}"
      MOUNTPOINT="${SAMBA_SHARES[$choice_name]}"
      
      printf "\n✅ The following share was chosen: %s\n" "$choice_name"
      printf "📍 Destination path (Mountpoint): %s\n\n" "$MOUNTPOINT"
      
      printf "⌨️ Press any key to continue...\n"
      read -n 1 -s -r
      clear
      return 0
    else
      # Invalid input (letters or wrong number)
      printf "\n❌ Invalid choice. Please enter a number from 1 to %s.\n" "$max_opt"
    fi
  done
}

checkparameter() {
    # Check if "sudo" is installed
    checksudo || return 1

    if [ "$#" -eq 0 ]; then
        printf "\n${RED}Error:${RESET} A device partition is required (e.g., sdb1)\n\n"
        getdevices # Drive analysis
        printf "\n\n"
        return 1
    fi

    local dev="$1"
    local mode="$2"

    [[ "$dev" != /dev/* ]] && dev="/dev/$dev"

    if [ ! -b "$dev" ]; then
        printf "\n\n${RED}Error:${RESET} %s is not a valid block device or does not exist!\n\n" "$dev"
        sudo lsblk -f | grep --color=always -E "$|^.*$(basename "$dev").*$"
        printf "\n\n"
        return 1
    fi

    # --- SPECIAL OUTPUT FOR MAIN DEVICES (without partition) ---
    if [[ ! "$dev" =~ [0-9]$ ]]; then
        if [[ "$mode" == "format" ]]; then
            printf "\n\n⚠️  ${YELLOW}NOTE:${RESET} You have selected the main device %s.\n" "$dev"
            printf "\n💾  Formatting will completely repartition the drive!\n\n"
        else
            # Does the main device have partitions?
            if lsblk -no NAME "$dev" | grep -q "[0-9]$"; then
                printf "\n\n\n${RED}STOP:${RESET} %s has partitions (see below).\n" "$dev"
                printf "\n⚠️  You must select a specific partition (e.g., ${dev}1)!\n\n\n"
                sudo lsblk -f | grep --color=always -E "$|^.*$(basename "$dev").*$"
                printf "\n\n"
                return 1
            fi
            # Normal mode 
            local fs_type
            fs_type=$(lsblk -no FSTYPE "$dev" | tr -d '[:space:]')
            if [[ -z "$fs_type" ]]; then
                printf "\n\n\n${RED}STOP:${RESET} %s is an entire drive without a filesystem.\n" "$dev"
                printf "\n⚠️ Please select a partition! (e.g., ${dev}1)\n\n\n"
                sudo lsblk -f | grep --color=always -E "$|^.*$(basename "$dev").*$"
                printf "\n\n"
                return 1
            fi
        fi
    fi

    # --- FILESYSTEM CHECK (Only if not format) ---
    if [[ "$mode" != "format" ]]; then
        local fs_type
        fs_type=$(lsblk -no FSTYPE "$dev" | tr -d '[:space:]')
        if [[ -z "$fs_type" ]]; then
            printf "\n${RED}STOP:${RESET} %s does not have a valid filesystem!\n" "$dev"
            printf "ℹ️  The drive must first be prepared with 'format'.\n\n"
            sudo lsblk -f | grep --color=always -E "$|^.*$(basename "$dev").*$"
            printf "\n\n"
            return 1
        fi
    fi

    # --- SYSTEM DRIVE PROTECTION ---
    local root_drive=$(lsblk -no PKNAME $(findmnt -nvo SOURCE /) | tr -d '[:space:]')
    [[ -z "$root_drive" ]] && root_drive=$(lsblk -no NAME $(findmnt -nvo SOURCE /) | tr -d '[:space:]' | sed 's/[0-9]*$//')

    if [[ "$dev" == *"$root_drive"* ]]; then
        printf "\n\n${RED}STOP:${RESET} %s belongs to the system drive (%s)! Access denied.\n\n" "$dev" "$root_drive"
        sudo lsblk -f | grep --color=always -E "$|^.*$(basename "$dev").*$"
        printf "\n\n"
        return 1
    fi
    return 0
}

format() {
  clear # Clear screen

  # Check if "sudo" is installed
  checksudo || return 1

  if [ "$#" -eq 0 ]; then
        printf "\n\n\n⚠️  WARNING: Please select a drive (partition)! (e.g. → 'format sdb' or 'format sdb1')\n\n\n"
        getdevices # Drive analysis
        printf "\n\n"
        return 1
  fi

  # CHECK: Is the array empty? (only if SAMBA server is installed)
  if dpkg -l | grep -q "^ii  samba " >/dev/null 2>&1; then
  checksmbconfig || return 1
  fi

  local dev
  local label="DATA"
  local fs_choice
  local fs_cmd

  # Parameter check with "format" mode specification
  checkparameter "$1" "format" || return 1

  dev="/dev/$(basename "$1")"

  # --- LOGIC: Is it a partition (ends in digit) or a main device? ---
  local is_partition=false
  [[ "$dev" =~ [0-9]$ ]] && is_partition=true

  printf "\nℹ️  Checking for mounted partitions...\n\n"
  smballmountsdismount || return 1  # Dismount everything for safety

  # Display drive configuration
  printf "\n\n"
  sudo lsblk -f | grep --color=always -E "$|^.*$(basename "$dev").*$"
  printf "\n\n"

  # --- Filesystem Menu ---
  printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
  if [ "$is_partition" = true ]; then
  printf "🔄 ${YELLOW}Formatting drive partition %s${RESET} \n" "$dev"
  else
  printf "🔄 ${YELLOW}Formatting entire drive %s${RESET}\n" "$dev"
  fi
  printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
  printf "💿      *** PLEASE SELECT FILESYSTEM ***\n"
  printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
  printf "💾 1) ext4   (Standard Linux - Recommended)\n"
  printf "💾 2) ntfs   (Windows - Good compatibility)\n"
  printf "💾 3) fat32  (Universal - Max. 4GB per file)\n"
  printf "💾 4) exfat  (Modern - Windows/Mac/Linux)\n"
  printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
  printf "\n\n"
  read -r -p "Please choose (1-4): " fs_input

  case "$fs_input" in
    1) fs_choice="ext4";  fs_cmd="mkfs.ext4 -F -L" ;;
    2) fs_choice="ntfs";  fs_cmd="mkfs.ntfs -f -L" ;;
    3) fs_choice="vfat";  fs_cmd="mkfs.vfat -F 32 -n" ;;
    4) fs_choice="exfat"; fs_cmd="mkfs.exfat -n" ;;
    *) printf "\n⚠️  Invalid input by user - Aborting!\n\n"; return 1 ;;
  esac

  # Check if the tool for vfat and ntfs formatting is installed
  local tool_pkg="${fs_choice}"
  [[ "$fs_choice" == "vfat" ]] && tool_pkg="dosfstools"
  [[ "$fs_choice" == "ntfs" ]] && tool_pkg="ntfs-3g"

  if ! command -v ${fs_cmd%% *} &> /dev/null; then
    printf "\n🛠️  The tool for %s formatting is missing. Installing %s...\n\n" "$fs_choice" "$tool_pkg"
    printf "\n🚀 Starting system update - Please wait...\n\n"
    sudo dpkg --configure -a && sudo apt update && sudo apt --assume-yes upgrade && sudo apt --assume-yes dist-upgrade
    sudo apt --assume-yes autoremove
    sudo apt autoclean
    sleep 5
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --reinstall -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" "$tool_pkg"
  fi

  clear # Clear screen content

  # HARD SYNCHRONIZATION
  printf "\nℹ️  Sync + reloading partition table...\n\n"
  sync
  sleep 1
  sudo blockdev --rereadpt "$dev" 2>/dev/null || sudo partprobe "$dev"
  sleep 1

  printf "\nℹ️  Selected drive: %s\n" "$dev"
  printf "\nℹ️  *** Selected formatting: %s ***\n\n" "$fs_choice"
  sudo lsblk -f | grep --color=always -E "$|^.*$(basename "$dev").*$"
  printf "\n"

  # --- DYNAMIC WARNING ---
  if [ "$is_partition" = true ]; then
      printf "\n${YELLOW}WARNING:${RESET} The partition %s will be formatted!\n\n\n" "$dev"
      read -r -p "❓ Final chance: Really delete the data on the selected partition? (yes/no): " bestaetigung2
      [[ "$bestaetigung2" != "yes" ]] && { printf "\n⚠️  Formatting aborted.\n\n"; return 1; }
  else
      printf "\n${YELLOW}WARNING:${RESET} The ENTIRE drive %s (including ALL partitions) will be deleted!\n\n\n" "$dev"
      read -r -p "❓ Final chance: Really delete all data on the selected drive? (yes/no): " bestaetigung2
      [[ "$bestaetigung2" != "yes" ]] && { printf "\n⚠️  Formatting aborted.\n\n"; return 1; }
  fi

  printf "\n🔥 ${RED}Starting formatting...${RESET}\n\n"
  
  # --- EXECUTION: Difference Drive vs. Partition ---
  local target_dev
  if [ "$is_partition" = false ]; then
      # Entire drive: Create new partition table
      sudo wipefs -a "$dev"
      sudo parted -s "$dev" mklabel gpt
      sudo parted -s "$dev" mkpart primary 1MiB 100%
      sudo partprobe "$dev"
      sleep 2
      target_dev="${dev}1"
  else
      # Only one partition: Only wipefs on this partition
      sudo wipefs -a "$dev"
      target_dev="$dev"
  fi

  # The actual formatting
  sudo $fs_cmd "$label" "$target_dev"

  clear # Clear screen content

  printf "\n\n\n✅ Formatting completed: %s (%s) created successfully.\n\n\n" "$target_dev" "$fs_choice"

  # Display drive configuration
  sudo lsblk -f | grep --color=always -E "$|^.*$(basename "$target_dev").*$"

  if dpkg -l | grep -q "^ii  samba " >/dev/null 2>&1; then
  printf "\n\n⌨️  Press any key to continue...\n\n"
  read -n 1 -s -r
  clear # Clear screen
  # fstab question only if SAMBA server is installed
  printf "\n\n\n"
  read -r -p "❓ Should a 'fstab' entry be created now? (yes/no): " fstab_antwort
  if [[ "$fstab_antwort" == "yes" ]]; then
    clear
    setfstab "$target_dev" nowfstab || return 1
  else
    printf "\n🔄 fstab entry will ***not*** be created.\n\n\n"
    # Mount prompt after fstab entry
    read -r -p "❓ Should the drive (\"$target_dev\") be mounted now? (yes/no): " mount_antwort
    printf "\n"
    if [[ "$mount_antwort" == "yes" ]]; then
      clear
      smbmount "$target_dev" || return 1
    else
      printf "\n"
      printf "\nℹ️  No mount performed. (%s remains in security mode 555)\n\n" "$MOUNTPOINT"
      printf "\n⚠️  Attention: %s is ***not*** ready for network connections.\n\n" "$MOUNTPOINT"
    fi
  fi
    fi
}

setfstab() {
  clear # Clear screen

  # Check if "sudo" is installed
  checksudo || return 1

  if [ "$#" -eq 0 ]; then
        printf "\n\n\n⚠️  WARNING: Please select a drive partition! (e.g. → 'setfstab sdb1')\n\n\n"
        getdevices # Drive analysis
        printf "\n\n"
        return 1
  fi

  # CHECK: Is the array empty?
  checksmbconfig || return 1

  # Explicit call → error message VISIBLE
  checkparameter "$1" || return 1

  local dev
  local part
  local uuid
  local fstype

  dev="/dev/$(basename "$1")"

  # Only if the device was not formatted just before
  if [ "$2" != "nowfstab" ]; then
  printf "\nℹ️  Checking if partition is still mounted...\n"
  smbdismount "$dev"
  else
  select_mountpoint -smp || return 1
  fi

  # HARD SYNCHRONIZATION
  printf "\nℹ️  Sync + reloading partition table...\n\n"
  sync
  sleep 2
  sudo blockdev --rereadpt "$dev" 2>/dev/null || sudo partprobe "$dev"
  sleep 2

  # Find partition
  part=$(lsblk -pnlo NAME,FSTYPE "$dev" | awk '$2!="" {print $1; exit}')
  if [ -z "$part" ]; then
    printf "\n❌ No partition with a filesystem found on %s!\n" "$dev"
    sudo lsblk -f | grep --color=always -E "$|^.*$(basename "$dev").*$"
    return 1
  fi

  # blkid -p (prober) forces direct reading from device without cache
  uuid=$(sudo blkid -p -s UUID -o value "$part")
  fstype=$(sudo blkid -p -s TYPE -o value "$part")

  if [ -z "$uuid" ] || [ -z "$fstype" ]; then
    printf "${RED}Error:${RESET} UUID or filesystem could not be determined.\n\n"
    return 1
  fi

  # Standard options for Linux filesystems (ext4)
  mount_options="defaults,noatime,nofail"
  # If exfat, vfat (FAT32) or ntfs is detected:
  if [[ "$fstype" =~ ^(exfat|vfat|ntfs)$ ]]; then
    # We force uid=1000, gid=100 and full permissions (umask=000)
    mount_options="defaults,noatime,nofail,uid=1000,gid=100,umask=000"
    # Special addition for NTFS (prevents invalid characters under Windows)
    [[ "$fstype" == "ntfs" ]] && mount_options+=",windows_names"
  fi

  printf "\nℹ️  For additional entries, call the function 'setfstab <drive_partition>'.\n\n"
  printf "ℹ️  UUID: %s\n" "$uuid"
  printf "ℹ️  Filesystem: %s\n" "$fstype"
  printf "ℹ️  Drive/Partition: %s\n" "$dev"
  printf "ℹ️  Mountpoint: %s\n\n" "$MOUNTPOINT"

  printf "\n\n\n"
  read -r -p "❓ Create 'fstab' entry now? (yes/no): " antwort
  printf "\n"
  if [[ "$antwort" == "yes" || "$antwort" == "ja" ]]; then
  # Remove existing entry for this mountpoint (regardless of which UUID was there)
  if grep -q "[[:space:]]$MOUNTPOINT[[:space:]]" /etc/fstab; then
    printf "\nℹ️  Removing old fstab entry for %s...\n" "$MOUNTPOINT"
    sudo sed -i "\|[[:space:]]$MOUNTPOINT[[:space:]]|d" /etc/fstab
  fi

  # Write new entry into fstab
  echo "UUID=$uuid  $MOUNTPOINT  $fstype  $mount_options  0  2" | sudo tee -a /etc/fstab >/dev/null

  printf "\n✅ fstab entry has been created.\n\n"
  else
   printf "\n🔄 fstab entry will ***not*** be created.\n\n"
  fi

  # After fstab entry: Mount prompt
  read -r -p "❓ Should the partition also be mounted now? ($part → $MOUNTPOINT) (yes/no): " mount_antwort
  printf "\n"
    if [[ "$mount_antwort" == "yes" || "$mount_antwort" == "ja" ]]; then
    clear
    smbmount "$dev" afterfstab || return 1
    else
    printf "\n"
    printf "\nℹ️  No mount performed. (%s remains in security mode 555)\n\n" "$MOUNTPOINT"
    printf "\n⚠️  Attention: %s is ***not*** ready for network connections.\n\n" "$MOUNTPOINT"
    fi
}

smbmount() {
  # Check if "sudo" is installed
  checksudo || return 1

  # CHECK: Is the array empty?
  checksmbconfig || return 1

  # 1. Check if a parameter was provided at all
  if [[ -z "$1" ]]; then
     # Call checkparameter without arguments to show the error message/lsblk
     checkparameter
     return 1
  fi

  checkparameter "$1" || return 1

  local dev="/dev/$(basename "$1")"

  # Only if the dev was not formatted before
  if [ "$2" != "afterfstab" ]; then
  # Prompt for mountpoint selection
  select_mountpoint -smp || return 1
  fi

  # We determine the partition (e.g., /dev/sdb1) if only /dev/sdb was specified
  local part=$(lsblk -pnlo NAME,FSTYPE "$dev" | awk '$2!="" {print $1; exit}')

  if [ -z "$part" ]; then
    printf "${RED}Error:${RESET} No partition with a filesystem found on %s!\n" "$dev"
    return 1
  fi

  # Mount prompt
  local param="$2"
  if [[ "$param" != "afterfstab" ]]; then
  printf "\n\n"
  read -r -p "❓ Mount the selected partition now? ($part → $MOUNTPOINT) (yes/no): " mount_antwort
  printf "\n"
  else
  mount_antwort="yes" # Set to "yes" immediately
  fi

  if [[ "$mount_antwort" == "yes" || "$mount_antwort" == "ja" ]]; then
    # Check if something is already mounted there
    if mountpoint -q "$MOUNTPOINT" > /dev/null 2>&1; then
       printf "\n⚠️  Note: %s is already occupied. Attempting to mount anyway...\n" "$MOUNTPOINT"
    fi
      if sudo mount "$part" "$MOUNTPOINT" > /dev/null 2>&1; then
      # --- Filesystem Check ---
      local current_fs
      current_fs=$(findmnt -n -o FSTYPE --target "$MOUNTPOINT")

      # Determine additional user if present
      local name=$(for n in "${SHARE_ORDER[@]}"; do [[ "${SAMBA_SHARES[$n]}" == "$MOUNTPOINT" ]] && echo "$n" && break; done)
      local user_line=$(sed -n "/\[$name\]/,/^\[/p" "$CONFIG_FILE" | grep "valid users =" | head -n1)
      local EXTRAUser=$(echo "$user_line" | cut -d'=' -f2 | cut -d',' -f2 -s | xargs)
      local display_extra="${EXTRAUser:-$EXTRAUSER}"

      if [[ "$current_fs" =~ ^(exfat|vfat|ntfs)$ ]]; then # <--- NEW
        printf "\nℹ️  The filesystem %s was detected.\n\n" "$current_fs"
        printf "🔓 Permissions are automatically controlled via mount options (fstab).\n\n"
      else
      # Optional: Also adjust subfolders if present (Caution: takes a very long time with many files → Patience)
      # sudo chmod -R 775 "$MOUNTPOINT"  # Only perform chown/chmod for Linux FS (ext4)

          if [ -z "$EXTRAUSER" ]; then
          # Searches for the "valid users" line only within the section of the chosen share [$name]
          # echo "$EXTRAUser"
          if [[ -n "$EXTRAUser" && "$EXTRAUser" != "shareuser" ]]; then
            printf "\n🔓 Opening write permissions for Samba users (%s) and (%s)\n\n" "$SAMBAMAINUSER" "$EXTRAUser"
          else
            printf "\n🔓 Opening write permissions for Samba user (%s)\n\n" "$SAMBAMAINUSER"          
          fi
        else
          if [[ -n "$EXTRAUSER" && "$EXTRAUSER" != "shareuser" ]]; then
          printf "\n🔓 Opening write permissions for Samba users (%s) and (%s)\n\n" "$SAMBAMAINUSER" "$EXTRAUSER" 
          else
          printf "\n🔓 Opening write permissions for Samba user (%s)\n\n" "$SAMBAMAINUSER"
          fi
        fi
        sudo chown "$SAMBAMAINUSER":"$SAMBAMAINUSER" "$MOUNTPOINT"
        sudo chmod 775 "$MOUNTPOINT"
      fi

      # --- Restart Samba server again -----------------------
      smbcontrol restart # Restart Samba server
      # -------------------------------------------------------
      local pi_ip=$(hostname -I | awk '{print $1}') # IP address of the Samba server 
      printf "\n"
      printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
      printf "🌐         NETWORK SHARE SUCCESSFULLY STARTED\n"
      printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
      if [[ -n "$display_extra" && "$display_extra" != "shareuser" ]]; then
      printf " 👤 %-20s : %s or %s\n" "Username" "$SAMBAMAINUSER" "$display_extra"
      else
      printf " 👤 %-20s : %s\n" "Username" "$SAMBAMAINUSER"
      fi
      printf " 🔓 %-20s : %s\n" "Password" "SAMBA password"
      printf "*******************************************************\n"
      printf " 📂 %-20s : %s\n" "Share Name" "$name"
      printf " 📍 %-20s : %s\n" "Mountpoint" "$MOUNTPOINT"
      printf " 💿 %-20s : %s\n" "Drive/Partition" "$part"
      printf " 💻 %-20s : \\\\\\\\%s\\\\%s\n" "Windows Path" "$pi_ip" "$name"
      printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
      printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
      printf "ℹ️  The share is now accessible on the network.\n\n\n"
    else
      printf "\n❌ Mounting of %s failed!\n\n" "$part"
      return 1
    fi
    else
     printf "\nℹ️  No mount performed. (%s remains in security mode 555)\n\n" "$MOUNTPOINT"
  fi
}

smbdismount() {
  # Check if "sudo" is installed
  checksudo || return 1

  # CHECK: Is the array empty?
  checksmbconfig || return 1

  # Parameter check
  checkparameter "$1" || return 1

  local dev="/dev/$(basename "$1")"

  # 1. Ask for selection of the specific mountpoint
  select_mountpoint -smp || return 1

  # 2. Check if EXACTLY this path is currently mounted
  if ! mountpoint -q "$MOUNTPOINT"; then
    printf "\nℹ️  %s is currently not mounted.\n" "$MOUNTPOINT"
    sudo chmod 555 "$MOUNTPOINT" 2>/dev/null
    printf "\n🔒 Security mode: %s is write-protected (555).\n\n" "$MOUNTPOINT"
    return 0
  fi

  # 3. Ask user (also shows which device is attached there)
  local current_source=$(findmnt -no SOURCE "$MOUNTPOINT" | head -n 1)
  printf "\nℹ️  Currently mounted: %s → on %s\n\n" "$MOUNTPOINT" "$current_source"
  printf "\n"
  read -r -p "❓ Dismount this share now? (yes/no): " confirm
  [[ "$confirm" != "yes" ]] && { printf "\n⚠️  Operation canceled by user.\n\n"; return 1; }

  # --- Stop Samba server -------------------------------
  printf "\n🔄 Disconnecting Samba connections...\n\n";
  smbcontrol stop
  # ------------------------------------------------------

  # 4. Targeted dismount of the directory
  printf "\nℹ️  Dismounting %s → Please wait..." "$MOUNTPOINT"

  if sudo umount "$MOUNTPOINT" 2>/dev/null || {
       printf "\n⚠️  Dismount blocked! Terminating processes...\n\n";
       sudo fuser -km "$MOUNTPOINT" 2>/dev/null;
       sleep 1;
       sudo umount -l "$MOUNTPOINT" 2>/dev/null;
     }; then
    printf "\n✅\n"

    # 5. FINAL SECURITY: Lock directory
    sudo chmod 555 "$MOUNTPOINT" 2>/dev/null
    printf "\n🔒 Connection closed. %s is now secure (555).\n\n" "$MOUNTPOINT"
    local success=1
  else
    printf "❌ Dismount of %s failed!\n\n" "$MOUNTPOINT"
    local success=0
  fi

  # --- Restart Samba server -----------------------
  printf "\n🔄 Starting Samba connections...\n\n";
  smbcontrol start
  # -------------------------------------------------------

  # --- load current Samba server config ---
  loadsmbconfig
  # -------------------------------------------

  [[ $success -eq 1 ]] && printf "\n✅ Operation completed successfully.\n\n\n"
  [[ $success -eq 0 ]] && return 1
}

smballmountsdismount() {
  # Check if "sudo" is installed
  checksudo || return 1

  # 1. Find all currently mounted partitions
  # We explicitly exclude all system-critical mount points
  local mounted_parts=($(lsblk -pnlo NAME,MOUNTPOINT | grep -E '^/dev/(sd|nvme|mmcblk)' | \
    awk '$2!="" && $2!="/" && $2!~"^\/boot" && $2!~"^\/etc" {print $1}'))

  # Additional safety check: If the partition belongs to the currently running root
  local root_part=$(findmnt -nvo SOURCE /)

  local final_list=()
  for part in "${mounted_parts[@]}"; do
    # Skip the partition if it is the root partition
    [[ "$part" == "$root_part" ]] && continue
    final_list+=("$part")
  done

  # If nothing is mounted (anymore), abort directly
  if [ ${#final_list[@]} -eq 0 ]; then
    printf "\nℹ️  No partitions found to dismount.\n\n"
    return 0
  fi

  # --- Stop Samba Server ---
  printf "\n🔄 Disconnecting Samba connections...\n\n"
  smbcontrol stop

  # 2. Loop over the filtered list
  local count=0
  for part in "${final_list[@]}"; do
    printf "\n → → → Dismounting %s... " "$part"

    if sudo umount "$part" 2>/dev/null || {
         printf "\n⚠️  Dismount blocked! Terminating processes on %s...\n" "$part"
         sudo fuser -km "$part" 2>/dev/null;
         sleep 2
         sudo umount -l "$part" 2>/dev/null;
       }; then
      printf "✅\n"
      ((count++))
    else
      printf "\n❌ Dismount failed! - A restart is recommended\n\n"
    fi
  done

  # --- Restart Samba Server ---
  printf "\n🔄 Starting Samba connections...\n\n"
  smbcontrol start

  printf "\n✅ %s of %s partition(s) successfully processed.\n\n" "$count" "${#final_list[@]}"
}

smbcontrol() {
  # Check if "sudo" is installed
  checksudo || return 1

  # Check if "Samba" is installed
  checksmbinstall || return 1

  local service=("smbd" "nmbd")
  local action="$1"

  # 1. Parameter check (now including restart)
  if [[ "$action" != "start" && "$action" != "stop" && "$action" != "restart" ]]; then
    printf "\n❌ Invalid parameter - Use 'start', 'stop' or 'restart'\n\n"
    return 1
  fi

  # ------------------------- START ---------------------------------------------
  if [[ "$action" == "start" ]]; then
    if systemctl -q is-active "$service"; then
      printf "\nℹ️ The SAMBA server is already started.\n\n"
      return 0
    fi
    printf "\nℹ️ Starting the Samba server - Please wait ....\n\n"
    sudo systemctl start "$service"

  # ------------------------- STOP ----------------------------------------------
  elif [[ "$action" == "stop" ]]; then
    if ! systemctl -q is-active "$service"; then
      printf "\nℹ️ The SAMBA server is already stopped.\n\n"
      return 0
    fi
    printf "\nℹ️ Stopping the Samba server - Please wait ....\n\n"
    sudo systemctl stop "$service"

  # ------------------------- RESTART -------------------------------------------
  elif [[ "$action" == "restart" ]]; then
    printf "\n🔄 Restarting the Samba server - Please wait ....\n\n"
    sudo systemctl daemon-reload # reload daemon for safety
    sleep 3
    sudo systemctl restart "$service"
  fi

  # Short pause for system initialization
  sleep 3

  # ------------------------- FINAL CHECK ---------------------------------------
  if [[ "$action" == "stop" ]]; then
    if ! systemctl -q is-active "$service"; then
      printf "\n✅ Success: The SAMBA server was successfully stopped.\n\n"
      printf "\n⌨️ Press any key to continue...\n\n"
      read -n 1 -s -r
      clear # clear screen
      return 0
    fi
  else
    # Applies to start and restart
    if systemctl -q is-active "$service"; then
      printf "\n✅ Success: The SAMBA server is active/started.\n\n"
      printf "\n⌨️ Press any key to continue...\n\n"
      read -n 1 -s -r
      clear # clear screen
      return 0
    fi
  fi

  # If the check above was not successful:
  printf "\n${RED}Error:${RESET} The action '%s' for the Samba server could not be executed correctly !!!\n\n" "$action"
  return 1
}

autoupdate() {
    # Check if "sudo" is installed
    checksudo || return 1

    local script_path="/home/$USER/systemupdate.sh"
    local log_path="/home/$USER/systemupdate.log"
    local param="$1"
    # Cron schedule for every Tuesday at 02:00 AM
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
    # --- OPTION: DISABLE (-d) ---
    if [[ "$param" == "-d" ]]; then
        if [[ ! -f "$script_path" ]]; then
            printf "\n⚠️  Abort: No 'autoupdate' file '%s' found.\n\n" "$script_path"
            return 1
        fi

        read -r -p "❓ Should 'autoupdate' really be disabled? (yes/no): " auconfirm
        if [[ "$auconfirm" == "yes" || "$auconfirm" == "ja" ]]; then
            # Delete file
            rm "$script_path" > /dev/null && rm "$log_path" > /dev/null
            # Remove cron job from crontab
            (crontab -l 2>/dev/null | grep -vF "$script_path") | crontab -
            printf "\n✅ Auto-update has been disabled.\n\n"
        else
            printf "\n🔄 The process has been canceled.\n\n"
        fi
        return 0
    fi

    # --- OPTION: CREATE (-c) ---
    if [[ "$param" == "-c" ]]; then
        if [[ -f "$script_path" ]]; then
            printf "\n\n"
            read -r -p "⚠️  'autoupdate' already exists. Overwrite? (yes/no): " overwrite
            [[ "$overwrite" != "yes" ]] && { printf "\n⚠️  The process has been canceled.\n\n"; return 1; }
        fi

        # Create file with Here-Doc (uses $USER dynamically)
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
echo "***Reboot***" >> "$log_path" 2>&1
sudo reboot >> "$log_path" 2>&1
EOF
        # Make executable
        chmod +x "$script_path"

        # --- UPDATE CRONTAB ---
        local current_cron
        current_cron=$(crontab -l 2>/dev/null)

        if [[ -z "$current_cron" ]]; then
            echo "$cron_entry" | crontab -
        else
            (echo "$current_cron" | grep -vF "$script_path"; echo "$cron_entry") | crontab -
        fi
        printf "\n✅ 'autoupdate' '%s' has been created.\n\n" "$script_path"
        printf "\n📅 Schedule: Automatic system update has been set for every Tuesday at 02:00 AM.\n\n"
        return 0
    fi

    # Incorrect or no parameter
    printf "\n⚠️  Invalid parameter: - Usage of 'autoupdate': autoupdate [-c | -d]\n\n"
    printf "🔄  -c : Create & Activate\n"
    printf "🔄  -d : Disable & Delete\n\n"
}

local_lang_gb() {
    # Check if "sudo" is installed
    checksudo || return 1

    # --- CHECK: Is British English (GB) already active? ---
    local kbd_check=0
    local lang_check=0

    # Check for GB keyboard layout
    if grep -q 'XKBLAYOUT="gb"' /etc/default/keyboard 2>/dev/null; then
        kbd_check=1
    fi

    # Check for GB English locale
    if [[ "$LANG" == "en_GB.UTF-8" ]]; then
        lang_check=1
    fi

    if [[ $kbd_check -eq 0 || $lang_check -eq 0 ]]; then
        # Ensure a clean environment for the process
        export LC_ALL=C.UTF-8
        export LANG=C.UTF-8
        export LANGUAGE=C.UTF-8
        printf "\n🌐 Switching system language and keyboard to English (GB) - Please wait...\n\n\n"

        # Write keyboard configuration (UK Layout)
        cat <<-EOF | sudo tee /etc/default/keyboard > /dev/null
XKBMODEL="pc105"
XKBLAYOUT="gb"
XKBVARIANT=""
XKBOPTIONS=""
BACKSPACE="guess"
EOF
        # Disable all other languages (comment them out)
        sudo sed -i 's/^[^#]/# &/g' /etc/locale.gen

        # Add English (GB)
        echo "en_GB.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen > /dev/null

        # Write system locale files
        echo "LANG=en_GB.UTF-8" | sudo tee /etc/default/locale > /dev/null
        echo "LC_ALL=en_GB.UTF-8" | sudo tee -a /etc/default/locale > /dev/null

        # Generate the locale physically
        sudo locale-gen en_GB.UTF-8 > /dev/null 2>&1

        # Officially register in the system
        sudo update-locale LANG=en_GB.UTF-8 LC_ALL=en_GB.UTF-8

        # Activate keyboard for the current session
        sudo loadkeys gb 2>/dev/null

        # Set timezone (Optional: Europe/London for Great Britain)
        if [[ "$(cat /etc/timezone 2>/dev/null)" != "Europe/London" ]]; then
            sudo timedatectl set-timezone Europe/London 2>/dev/null
        fi

        printf "\n✅ System language and keyboard successfully switched to English (GB).\n\n"
        return 1
    else
        printf "\nℹ️ System language and keyboard are already set to English (GB).\n\n"
        return 0
    fi
}

getipv4() {
 clear # Clear screen
 # We retrieve the IPv4 address
 local IPv4
 IPv4=$(hostname -I | awk '{print $1}')
 if [[ -n "$IPv4" ]]; then
 printf "\nℹ️ The IPv4 address is: '%s'\n\n" "$IPv4"
 else
 printf "\n⚠️ No IPv4 address found!\n\n" 
 fi 
}

webmininstall() {
    # Check if "sudo" is installed
    checksudo || return 1

    # Store parameter in variable
    local param="$1"

    local spinner="/|\\-"
    local i=1

    clear # Clear screen
    printf "\n\n\n"
    # Check if "Webmin Manager" is already installed
    printf "\n🔍 Checking installation status of graphical interface 'Webmin Manager'...\n\n"

    # We perform the check in a variable to avoid job messages
    # This is fast enough that we show the spinner manually for a short time
    for j in {1..8}; do
        i=$(( (i % 4) + 1 ))
        printf "\b%s" "${spinner:$i-1:1}"
        sleep 0.1
    done

    # Now the actual check without background process messages
    local check_result=$(dpkg -l 2>/dev/null | grep "webmin")

    if [[ -n "$check_result" ]]; then
        printf "\b✅ Checking installation status - finished...\n"
        printf "\n🚀 The graphical interface 'Webmin Manager' is already installed.\n"
        # Extracts only the version cleanly
        local version=$(echo "$check_result" | awk '{print $3}')
        printf "   -> Version: $version\n\n"
        printf "\n✅ Access via: https://%s:10000\n\n" "$(hostname -I | awk '{print $1}')"
        printf "\b \b"
        printf "\n⌨️ Press any key to continue...\n\n"
        read -n 1 -s -r
        clear # Clear screen
        return 0
    else
        # Remove spinner cleanly
        printf "\b \b" 
    fi

    printf "\n\n"
    read -r -p "❓ Would you like to install the graphical interface 'Webmin Manager' now? (yes/no): " wmconfirm
    if [[ "$wmconfirm" == "yes" ]]; then
        printf "\n\n"
        if [[ "$param" != "-install" ]]; then
        printf "\n🚀 Starting system update - Please wait...\n\n"
        # Install dependencies (curl is required for the script)
        sudo dpkg --configure -a && sudo apt update && sudo apt --assume-yes upgrade && sudo apt --assume-yes dist-upgrade
        sudo apt --assume-yes autoremove
        sudo apt autoclean
        fi
        # (Note: For DEBIAN Linux only !!!)
        sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" curl gnupg2 apt-transport-https
        printf "\n\n🚀 Starting Webmin Manager installation - Please wait...\n\n"
        # Repository direct create
        # echo "deb [signed-by=/usr/share/keyrings/webmin-archive-keyring.gpg] https://download.webmin.com/download/repository sarge contrib" | sudo tee /etc/apt/sources.list.d/webmin.list > /dev/null
        # Download and run official Webmin repository setup script
        # This automatically adds the key and the sources
        sudo curl -o setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh
        sudo sh setup-repos.sh -f  # -f Forces execution without re-confirmation
        # Install Webmin Manager
        sudo apt-get install -y webmin --install-recommends
        # Clean up
        sudo rm -f setup-repos.sh # -f Forces execution without re-confirmation
        # ---------------------------------------------------------------------
        check_result=$(dpkg -l 2>/dev/null | grep "webmin")
        if [[ -z "$check_result" ]]; then
        printf "\n❌ ERROR: 'Webmin Manager' could not be installed!\n\n"
        printf "\n⌨️ Press any key to continue...\n\n"
        read -n 1 -s -r
        return 1
        fi

        # Unlock firewall port 10000 (if UFW is active)
        # if command -v ufw > /dev/null; then
        #    sudo ufw allow 10000/tcp
        #    sudo ufw reload
        # fi

        # Fix for the /tmp RAM disk message
        if [ -f "/etc/webmin/config" ]; then
        printf "\n⚙️ Optimizing Webmin temp directory (RAM disk fix)...\n\n"
        # Create new directory
        sudo mkdir -p /var/webmin_tmp
        sudo chown root:root /var/webmin_tmp
        sudo chmod 777 /var/webmin_tmp
        # Instruct Webmin to use this directory
        sudo sed -i '/^tempdir=/d' /etc/webmin/config
        echo "tempdir=/var/webmin_tmp" | sudo tee -a /etc/webmin/config > /dev/null
    
    # Restart service
    sudo systemctl restart webmin > /dev/null 2>&1
    printf "✅ Webmin temp directory has been moved to /var/webmin_tmp.\n"
fi
            clear # Clear screen
            printf "\n\n\n"
            printf "\n=====================================================\n"
            printf "✅ WEBMIN-MANAGER SUCCESSFULLY INSTALLED\n"
            printf "=====================================================\n"
            printf "🌐 Web Interface:  https://%s:10000\n" "$(hostname -I | awk '{print $1}')"
            printf "👤 Admin User:     %s\n" "$USER"
            printf "🔐 Password:       System password for login.\n"
            printf "=====================================================\n\n"
           
       # Adjust logic for reboot
       if [[ "$param" == "-install" ]]; then
        printf "⌨️ Press any key to continue...\n\n"
        read -n 1 -s -r
        clear # Clear screen
        else
        # Default behavior without the "install" parameter
        printf "\n\n⌨️ Press any key to continue...\n\n"
        read -n 1 -s -r
        clear # Clear screen
        printf "\n🚀 The system must be restarted to activate 'Webmin Manager'.\n\n"
        printf "\n🔄 Restarting in 5 seconds (Cancel with Ctrl+C)...\n\n"
        sleep 5
        sudo reboot
        fi
    else
        printf "\n⏩ The graphical interface 'Webmin Manager' will ***not*** be installed.\n\n"
        printf "\n⌨️ Press any key to continue...\n\n"
        read -n 1 -s -r
        clear # Clear screen
    fi
}

setfail2banjail() {
    printf "\n🛡️ Configuring Fail2Ban protection (dynamic detection)...\n\n"
    
    local my_ip=$(hostname -I | awk '{print $1}')

    # --- Check: What is actually installed and active? ---
    local apache_active="false"
    local lighttpd_active="false"
    local webmin_active="false"
    local ssh_active="false"

    # Check if services/directories exist
    command -v apache2 >/dev/null 2>&1 && apache_active="true"
    command -v lighttpd >/dev/null 2>&1 && lighttpd_active="true"
    [[ -d "/etc/webmin" ]] && webmin_active="true"
    
    # Check if SSH is active in the system
    systemctl is-active --quiet ssh && ssh_active="true"

    # 1. File: fail2ban.local (IPv6 Support - only if IPv6 is enabled)
    if ip -6 addr show 2>/dev/null | grep -q "scope global"; then
      local f2b_conf="/etc/fail2ban/fail2ban.local"
      if ! grep -q "allowipv6 = auto" "$f2b_conf" 2>/dev/null; then
        printf "➕ Configuring IPv6 support...\n"
        echo -e "[DEFAULT]\nallowipv6 = auto" | sudo tee "$f2b_conf" > /dev/null
      fi
    fi

    # 2. File: jail.local (Central Configuration)
    printf "➕ Creating jail file: 'jail.local'...\n"
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

    # 3. Webmin-Manager jail logic (only if Webmin is active)
    if [[ "$webmin_active" == "true" ]]; then
        printf "➕ Creating jail file 'webmin.conf'...\n"
        sudo cat <<-EOF | sudo tee /etc/fail2ban/jail.d/webmin.conf > /dev/null
[webmin-auth]
enabled = $webmin_active
port    = 10000
filter  = webmin-auth
backend = systemd
EOF
    else
        sudo rm -f /etc/fail2ban/jail.d/webmin.conf 2>/dev/null
        printf "\n🧹 The graphical interface 'Webmin-Manager' was not found – removing jail file!\n"
    fi

    # Restart and status output
    printf "\n🔄 Restarting 'Fail2Ban' service...\n\n"
    sudo systemctl restart fail2ban
    sleep 5
    if systemctl is-active --quiet fail2ban; then
        printf "\n✅ 'Fail2Ban' configuration completed:\n"
        printf "👉 - SSH:       $([[ "$ssh_active" == "true" ]] && echo "ACTIVE ✅" || echo "INACTIVE ❌")\n"
        printf "👉 - Webmin:    $([[ "$webmin_active" == "true" ]] && echo "ACTIVE ✅" || echo "INACTIVE ❌")\n"
        printf "👉 - Webserver: $([[ "$apache_active" == "true" || "$lighttpd_active" == "true" ]] && echo "ACTIVE ✅" || echo "INACTIVE ❌")\n\n"
    else
        printf "\n❌ Error starting 'Fail2Ban' - Aborting!\n\n"
    fi
 printf "\n⌨️ Press any key to continue...\n\n"
 read -n 1 -s -r
 clear # Clear screen
}

setiptables() {
if command -v iptables >/dev/null 2>&1; then
     clear # Clear screen
     printf "\n\n🚀 *** Configuring security settings for the installed programs ... ***\n\n"

     printf "\n\n➕ *** Security settings for SAMBA server\n"

     # --- Automation for iptables-persistent (for BOTH v4/v6 cases) ---
     echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
     echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections

     # --- Create custom chains for IPv4 and IPv6 (if not existing) ---
     sudo iptables -N SAMBA_RULES 2>/dev/null
     sudo ip6tables -N SAMBA_RULES 2>/dev/null

     # --- Flush only custom chains (external rules remain active!) ---
     sudo iptables -F SAMBA_RULES
     sudo ip6tables -F SAMBA_RULES

     # --- Link to main firewall (INPUT), if necessary ---
     if ! sudo iptables -C INPUT -j SAMBA_RULES 2>/dev/null; then
          sudo iptables -I INPUT 1 -j SAMBA_RULES
     fi
     if ! sudo ip6tables -C INPUT -j SAMBA_RULES 2>/dev/null; then
          sudo ip6tables -I INPUT 1 -j SAMBA_RULES
     fi

     if ip -6 addr show 2>/dev/null | grep -q "scope global"; then
     # ******** IPv4 & IPv6 ***********
     sudo iptables -A SAMBA_RULES -i lo -j ACCEPT # Loopback IPv4
     sudo iptables -A SAMBA_RULES -m state --state ESTABLISHED,RELATED -j ACCEPT # Existing connections IPv4
     sudo ip6tables -A SAMBA_RULES -i lo -j ACCEPT # Loopback IPv6
     sudo ip6tables -A SAMBA_RULES -m state --state ESTABLISHED,RELATED -j ACCEPT # Existing connections IPv6

     # 1. FIRST: Allow access to the web interface for yourself (IMPORTANT!)
     sudo iptables -A SAMBA_RULES -p tcp --dport 443 -j ACCEPT # for web interface
     sudo ip6tables -A SAMBA_RULES -p tcp --dport 443 -j ACCEPT # for web interface
     
     if dpkg -l | grep -q "^ii  cups "; then
          printf "\n➕ *** Security settings for CUPS print server\n"
          sudo iptables -A SAMBA_RULES -p tcp --dport 631 -j ACCEPT  # For print server
          sudo iptables -A SAMBA_RULES -p udp --dport 631 -j ACCEPT  # For print server 
          sudo ip6tables -A SAMBA_RULES -p tcp --dport 631 -j ACCEPT # For print server 
          sudo ip6tables -A SAMBA_RULES -p udp --dport 631 -j ACCEPT # For print server 
          sudo iptables -A SAMBA_RULES -p udp --dport 5353 -j ACCEPT # For AirPrint/mDNS
          sudo ip6tables -A SAMBA_RULES -p udp --dport 5353 -j ACCEPT # For AirPrint/mDNS
     fi
     
        if dpkg -l | grep -q "^ii  webmin " || [ -d "/etc/webmin" ]; then
          printf "\n➕ *** Security settings for Webmin-Manager\n"
          sudo iptables -A SAMBA_RULES -p tcp --dport 10000 -j ACCEPT # For Webmin-Manager
          sudo ip6tables -A SAMBA_RULES -p tcp --dport 10000 -j ACCEPT # For Webmin-Manager
        fi

     # 2. AFTERWARDS: Block the remaining "trash"
     sudo iptables -A SAMBA_RULES -p tcp --destination-port 80 -j REJECT --reject-with tcp-reset # for Pi-hole
     sudo iptables -A SAMBA_RULES -p tcp --destination-port 8080 -j REJECT --reject-with tcp-reset # for Pi-hole
     sudo iptables -A SAMBA_RULES -p udp --destination-port 80 -j REJECT --reject-with icmp-port-unreachable # for Pi-hole
     sudo iptables -A SAMBA_RULES -p udp --destination-port 8080 -j REJECT --reject-with icmp-port-unreachable # for Pi-hole
     sudo ip6tables -A SAMBA_RULES -p tcp --destination-port 80 -j REJECT --reject-with tcp-reset # for Pi-hole
     sudo ip6tables -A SAMBA_RULES -p tcp --destination-port 8080 -j REJECT --reject-with tcp-reset # for Pi-hole
     sudo iptables -A SAMBA_RULES -p tcp --destination-port 443 -j REJECT --reject-with tcp-reset # for web interface
     sudo ip6tables -A SAMBA_RULES -p tcp --destination-port 443 -j REJECT --reject-with tcp-reset # for web interface
     
     if dpkg -l | grep -q "^ii  cups "; then
          sudo iptables -A SAMBA_RULES -p tcp --destination-port 631 -j REJECT --reject-with tcp-reset  # For print server
          sudo iptables -A SAMBA_RULES -p udp --destination-port 631 -j REJECT --reject-with icmp-port-unreachable # For print server
          sudo ip6tables -A SAMBA_RULES -p tcp --destination-port 631 -j REJECT --reject-with tcp-reset # For print server
          sudo ip6tables -A SAMBA_RULES -p udp --destination-port 631 -j REJECT --reject-with icmp6-port-unreachable # For print server
     fi
     
     if dpkg -l | grep -q "^ii  webmin " || [ -d "/etc/webmin" ]; then
          sudo iptables -A SAMBA_RULES -p tcp --destination-port 10000 -j REJECT --reject-with tcp-reset # For Webmin-Manager
          sudo ip6tables -A SAMBA_RULES -p tcp --destination-port 10000 -j REJECT --reject-with tcp-reset # For Webmin-Manager
     fi
     
     else
     # ******** IPv4 only ***********
     # 1. FIRST: Allow access to the web interface for yourself (IMPORTANT!)
     sudo iptables -A SAMBA_RULES -i lo -j ACCEPT # Loopback IPv4
     sudo iptables -A SAMBA_RULES -m state --state ESTABLISHED,RELATED -j ACCEPT # Existing connections IPv4
    
     sudo iptables -A SAMBA_RULES -p tcp --dport 80 -j ACCEPT # for Pi-hole
     sudo iptables -A SAMBA_RULES -p tcp --dport 8080 -j ACCEPT # for Pi-hole
     sudo iptables -A SAMBA_RULES -p tcp --dport 443 -j ACCEPT # for web interface
     
     if dpkg -l | grep -q "^ii  cups "; then
      printf "\n➕ *** Security settings for CUPS print server\n"
      sudo iptables -A SAMBA_RULES -p tcp --dport 631 -j ACCEPT # for print server
      sudo iptables -A SAMBA_RULES -p udp --dport 631 -j ACCEPT  # for print server
      sudo iptables -A SAMBA_RULES -p udp --dport 5353 -j ACCEPT # For AirPrint/mDNS
     fi
     
     if dpkg -l | grep -q "^ii  webmin " || [ -d "/etc/webmin" ]; then
       printf "\n➕ *** Security settings for Webmin-Manager\n"
       sudo iptables -A SAMBA_RULES -p tcp --dport 10000 -j ACCEPT # for Webmin-Manager
     fi

     # 2. AFTERWARDS: Block the remaining "trash"
     sudo iptables -A SAMBA_RULES -p tcp --destination-port 80 -j REJECT --reject-with tcp-reset # for Pi-hole
     sudo iptables -A SAMBA_RULES -p tcp --destination-port 8080 -j REJECT --reject-with tcp-reset # for Pi-hole
     sudo iptables -A SAMBA_RULES -p tcp --destination-port 443 -j REJECT --reject-with tcp-reset # for web interface
     
     if dpkg -l | grep -q "^ii  cups "; then
          sudo iptables -A SAMBA_RULES -p tcp --destination-port 631 -j REJECT --reject-with tcp-reset # For print server
          sudo iptables -A SAMBA_RULES -p udp --destination-port 631 -j REJECT --reject-with icmp-port-unreachable # For print server
     fi
     
     if dpkg -l | grep -q "^ii  webmin " || [ -d "/etc/webmin" ]; then
          sudo iptables -A SAMBA_RULES -p tcp --destination-port 10000 -j REJECT --reject-with tcp-reset # For Webmin-Manager
     fi
     fi

     # Save IPTables & success message
     sudo netfilter-persistent save > /dev/null 2>&1
     printf "\n\n🎉 *** Security settings for the installed programs have been completed ***\n\n"
     printf "\n\n⌨️ Press any key to continue...\n\n"
     read -n 1 -s -r
else
     printf "\n\n🎉 *** Security settings for the installed programs could ***not*** be completed !\n\n" 
     printf "\n\n⌨️ Press any key to continue...\n\n"
     read -n 1 -s -r
fi
}

printserverinstall() {
     local ip_addr=$(hostname -I | awk '{print $1}')
     local param="$1"

     # 1. CHECK: Is CUPS already installed?
     if dpkg -l | grep -q "^ii  cups "; then
        printf "\n🖨️  The 'CUPS-Printserver' is already installed on this system.\n\n"            
        printf "\n=====================================================\n"
        printf "✅ CUPS PRINT-SERVER ACCESS DATA\n"
        printf "=====================================================\n"
        printf "🌐 Web-Interface:  http://%s:631/admin\n" "$ip_addr"
        printf "👤 Admin-User:     %s\n" "$USER"
        printf "🔐 Password:       System password for login.\n"
        printf "=====================================================\n\n"
        return 0
    fi
    clear # Clear screen
    printf "\n\n" # Insert blank lines
    printf "==================================================\n"
    printf "============= EXTRA Options =====================\n"
    printf "==================================================\n\n\n"
    printf "\n❓ Would you like to install the 'CUPS Print-Server' now? (yes/no): "
    read -r cups_confirm

    if [[ "$cups_confirm" == "yes" || "$cups_confirm" == "ja" ]]; then
    local cups_conf="/etc/cups/cupsd.conf"
        
        # 1. System update beforehand
        if [[ "$param" != "-si" ]]; then
        printf "\n🚀 Starting update of system packages (Update & Upgrade)...\n\n"
        sudo dpkg --configure -a && sudo apt update && sudo apt --assume-yes upgrade && sudo apt --assume-yes dist-upgrade
        sudo apt --assume-yes autoremove
        sudo apt autoclean
        printf "\n\n🔄 System update completed\n\n"
        printf "\n\n⌨️ Press any key to continue...\n\n"
        read -n 1 -s -r
        fi

        # 2. Installation of CUPS
        printf "\n\n🖨️ The 'CUPS-Printserver' packages are being installed - Please wait...\n\n"
        sleep 3
        if sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
            -o Dpkg::Options::="--force-confdef" \
            -o Dpkg::Options::="--force-confold" \
            cups printer-driver-gutenprint; then
            # 3. Configuration for network access
            clear # Clear screen
            printf "\n⚙️ CUPS: Network access and admin rights are being configured - Please wait...\n\n"
            
            # Allows access from other PCs in the network & filesharing via cupsctl
            sudo cupsctl WebInterface=yes --remote-admin --remote-any --share-printers
            
            # Adds the current user to the admin group
            sudo usermod -aG lpadmin "$USER"

            # Optimize CUPS web interface for English
            if [ -f "/etc/cups/cupsd.conf" ]; then
              printf "\n⚙️ Optimizing CUPS language settings for the web interface...\n\n"
             # Set default character set to UTF-8
             sudo sed -i '/^DefaultCharset/d' /etc/cups/cupsd.conf
             echo "DefaultCharset utf-8" | sudo tee -a /etc/cups/cupsd.conf > /dev/null
             # Set default language to English
             sudo sed -i '/^DefaultLanguage/d' /etc/cups/cupsd.conf
             echo "DefaultLanguage en" | sudo tee -a /etc/cups/cupsd.conf > /dev/null
             printf "\n✅ The CUPS web interface language has been optimized.\n\n"
           fi

            # 4. Enable and restart CUPS service
            printf "\n🖨️ The 'CUPS-Printserver' is being activated - Please wait...\n\n"
            sudo systemctl enable --now cups > /dev/null 2>&1
            sudo systemctl restart cups > /dev/null 2>&1
            sleep 5 

            printf "\n=====================================================\n"
            printf "✅ CUPS PRINT-SERVER SUCCESSFULLY INSTALLED\n"
            printf "=====================================================\n"
            printf "🌐 Web-Interface:  https://%s:631/admin\n" "$ip_addr"
            printf "👤 Admin-User:     %s\n" "$USER"
            printf "🔐 Password:       System password for login.\n"
            printf "=====================================================\n\n"
            printf "\n⌨️ Press any key to continue...\n\n"
            read -n 1 -s -r
            clear # Clear screen
        else
            printf "\n❌ Error: The installation of 'CUPS-Printserver' has failed.\n\n"
            return 1
        fi
    else
        printf "\n⏭️ The 'CUPS-Printserver' installation will be skipped.\n\n"
        printf "\n⌨️ Press any key to continue...\n\n"
        read -n 1 -s -r
        clear # Clear screen
    fi
}

# CALL a function when the .bashrc file starts (must be placed at the very bottom)
loadsmbconfig  # Load existing shares
