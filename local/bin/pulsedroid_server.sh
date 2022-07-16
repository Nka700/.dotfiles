#!/bin/bash -
#===============================================================================
#
#          FILE: pulsedroid_server.sh
#
#         USAGE: ./pulsedroid_server.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 07/16/2022 10:54:10 PM
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error

pactl load-module module-null-sink sink_name=TCP_output
pacmd update-sink-proplist TCP_output device.description=TCP_output
pactl load-module module-simple-protocol-tcp \
  rate=48000 format=s16le channels=2 source=TCP_output.monitor record=true port=37564 listen=0.0.0.0
