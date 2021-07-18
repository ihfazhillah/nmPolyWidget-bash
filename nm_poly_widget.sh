#!/bin/bash

if [ -z $1 ]
then
    echo usage: $0 YOUR_DEVICE
    exit 1
fi

device=$1

DEVICE_STATUS="nmcli -t device status"
FILTER_BY_DEVICE="grep $device"

function getIpAddress(){
    nmcli -t device show $device | grep -i IP4.ADDRESS | awk '{split($0, array, /[:\/]/); print array[2]}' 
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

status=$(getStatus)

if [[ $status == *"connecting"* ]]
then
    echo ! ---- $device Connecting...
elif [[ $status == "connected" ]]
then
    echo $(getIntensity) $(getSSID)  ↑↓ $(getIpAddress)
else
    echo ! ---- $device Offline
fi