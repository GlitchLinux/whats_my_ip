#!/bin/bash

# Function to get IP and location
display_info() {
    TOR_PROXY="--socks5-hostname 127.0.0.1:9050"
    
    # Check if using Tor
    if curl -s $TOR_PROXY https://check.torproject.org/api/ip > /dev/null 2>&1; then
        PUBLIC_IP=$(curl -s $TOR_PROXY https://check.torproject.org/api/ip | jq -r .IP)
        IP_INFO=$(curl -s $TOR_PROXY https://ipwhois.app/json/$PUBLIC_IP)
    else
        PUBLIC_IP=$(curl -s https://ifconfig.me)
        IP_INFO=$(curl -s https://ipwhois.app/json/$PUBLIC_IP)
    fi
    
    LOCATION=$(echo "$IP_INFO" | jq -r '.city + ", " + .region + ", " + .country')
    
    if [[ "$PUBLIC_IP" == "null" || -z "$PUBLIC_IP" ]]; then
        PUBLIC_IP="Unknown (Tor may be blocking queries)"
    fi
    if [[ "$LOCATION" == "null" || -z "$LOCATION" ]]; then
        LOCATION="Unknown"
    fi
    
    zenity --info \
        --title="Public IP & Location" \
        --text="Public IP: $PUBLIC_IP\nLocation: $LOCATION" \
        --ok-label="Refresh" --extra-button="Exit"
}

# Initial display loop
while true; do
    RESPONSE=$(display_info)
    
    if [[ "$?" -ne 0 ]]; then
        exit 0
    fi

done
