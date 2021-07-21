#!/bin/bash

if [ -z "$1" ]
then
    echo usage: "$0" YOUR_DEVICE
    exit 1
fi

device=$1

DEVICE_STATUS="nmcli -t device status"
FILTER_BY_DEVICE="grep $device"

function getIpAddress(){
    nmcli -t device show "$device" | grep -i IP4.ADDRESS | awk '{split($0, array, /[:\/]/); print array[2]}' 
}

function getSSID(){
    $DEVICE_STATUS | $FILTER_BY_DEVICE | awk '{split($0, array, ":"); print array[4]}'
}

function getStatus(){
    $DEVICE_STATUS | $FILTER_BY_DEVICE | awk '{split($0, array, ":"); print array[3]}'
}

function getMode(){
    $DEVICE_STATUS | $FILTER_BY_DEVICE | awk '{split($0, array, ":"); print array[2]}'
}

function getIntensity(){
    nmcli -t device wifi list | awk '{n=split($0, array, ":"); print array[n-1]}'
}

function formatUpDown(){
    down=$(ifstat -i "$device" 1 1 | awk 'NR%3==0 {print $1}')
    up=$(ifstat -i "$device" 1 1 | awk 'NR%3==0 {print $2}')
    echo ↑"$up" ↓"$down"
}

status=$(getStatus)

if [[ $status == *"connecting"* ]]
then
    echo ! ---- "$device" Connecting...
elif [[ $status == "connected" ]]
then
    if [[ $(command -v ifstat 2> /dev/null | wc -l) -gt 0 ]] 
    then
        echo "$(getIntensity) $(formatUpDown) $(getSSID) - $(getIpAddress)"
    else
        echo "$(getIntensity) $(getSSID)  ↑↓ $(getIpAddress)"
    fi
else
    echo ! ---- "$device" Offline
fi