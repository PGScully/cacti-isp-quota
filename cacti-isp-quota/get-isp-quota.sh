#!/bin/sh

# Get usage information from Internode's web page.  
#
# Setup to run once every half hour.
#
# Thanks to Troy Dack (troy @ tkdack.com) for the command to query the
# Internode server and parse the information returned.
#

config_file="/etc/cacti/ISP_Quota.conf"

isp_index=$1

temp=( `grep $isp_index $config_file | grep -v ^#` )
isp_name=${temp[1]}
username=${temp[2]}
password=${temp[3]}

case $isp_name in
    (Internode|internode)
        temp=( `wget -q -O - --post-data "username=${username}&password=${password}" https://accounts.internode.on.net/cgi-bin/padsl-usage` ) 
        usage=${temp[0]}
        limit=${temp[1]}
        unmetered=0
        echo "usage:$usage limit:$limit unmetered:$unmetered"
        ;;
esac

