#!/bin/sh

# Get usage information from Internode's web page.  
#

name=$1
password=$2

wget -q -O - --post-data "username=$name&password=$password" https://accounts.internode.on.net/cgi-bin/padsl-usage | gawk '{print "usage:"$1" limit:"$2}'

