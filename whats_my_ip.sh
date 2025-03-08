#!/bin/bash

# Function to get IP and location
display_info() {
    # Check if connected to Tor by using torsocks
    if torsocks curl -s https://check.torproject.org/api/ip > /dev/null 2>&1; then
        IP_INFO=$(torsocks curl -s https://ipinfo.io/json)
    else
        IP_INFO=$(curl -s https://ipinfo.io/json)
    fi
    
    PUBLIC_IP=$(echo "$IP_INFO" | jq -r .ip)
    LOCATION=$(echo "$IP_INFO" | jq -r '.city + ", " + .region + ", " + .country')
    
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
