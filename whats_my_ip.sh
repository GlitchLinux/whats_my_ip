#!/bin/bash

# Function to get IP and location
display_info() {
    TOR_PROXY="--socks5-hostname 127.0.0.1:9050"
    TOR_CHECK_URL="https://check.torproject.org/api/ip"
    IP_API="https://ipapi.co"
    
    # Check if using Tor
    if curl -s $TOR_PROXY $TOR_CHECK_URL > /dev/null 2>&1; then
        # Using Tor
        PUBLIC_IP=$(curl -s $TOR_PROXY $TOR_CHECK_URL | jq -r .IP)
        if [[ -z "$PUBLIC_IP" || "$PUBLIC_IP" == "null" ]]; then
            PUBLIC_IP=$(curl -s $TOR_PROXY https://ifconfig.me)
        fi
        
        # Use ipapi.co with Tor (which works with Tor exit nodes)
        LOCATION_INFO=$(curl -s $TOR_PROXY "$IP_API/$PUBLIC_IP/json/")
        CITY=$(echo "$LOCATION_INFO" | jq -r '.city')
        REGION=$(echo "$LOCATION_INFO" | jq -r '.region')
        COUNTRY=$(echo "$LOCATION_INFO" | jq -r '.country_name')
    else
        # Not using Tor
        PUBLIC_IP=$(curl -s https://ifconfig.me)
        LOCATION_INFO=$(curl -s "$IP_API/$PUBLIC_IP/json/")
        CITY=$(echo "$LOCATION_INFO" | jq -r '.city')
        REGION=$(echo "$LOCATION_INFO" | jq -r '.region')
        COUNTRY=$(echo "$LOCATION_INFO" | jq -r '.country_name')
    fi
    
    # Format location
    LOCATION=""
    [[ -n "$CITY" && "$CITY" != "null" ]] && LOCATION="$CITY"
    [[ -n "$REGION" && "$REGION" != "null" ]] && LOCATION="${LOCATION:+$LOCATION, }$REGION"
    [[ -n "$COUNTRY" && "$COUNTRY" != "null" ]] && LOCATION="${LOCATION:+$LOCATION, }$COUNTRY"
    
    # Fallbacks if empty
    [[ -z "$LOCATION" ]] && LOCATION="Unknown"
    [[ -z "$PUBLIC_IP" || "$PUBLIC_IP" == "null" ]] && PUBLIC_IP="Unknown"
    
    zenity --info \
        --title="Public IP & Location" \
        --text="Public IP: $PUBLIC_IP\nLocation: $LOCATION" \
        --ok-label="Refresh" --extra-button="Exit"
}

# Initial display loop
while true; do
    display_info
    
    # Check if user clicked Exit
    if [[ "$?" -ne 0 ]]; then
        exit 0
    fi
done
