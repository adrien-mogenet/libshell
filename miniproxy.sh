#!/bin/sh

# Description:
#   Creates a mini proxy with `nc`.
#   Link: http://notes.tweakblogs.net/blog/7955/using-netcat-to-build-a-simple-tcp-proxy-in-linux.html

INCOMING_PORT=8080
INCOMING_LOG_FILE="/tmp/miniproxy-input.log"
OUTGOING_SERVER="google.com"
OUTGOING_PORT=4242
OUTGOING_LOG_FILE="/tmp/miniproxy-output.log"
PIPE_FILE="/tmp/miniproxy.pipe"
NC=`which nc`
ENABLE_LOGGING="true"

test -z "$NC" && (echo "Unable to find nc."; exit 3)

test -p $PIPE_FILE || mkfifo $PIPE_FILE
echo "Listening on $INCOMING_PORT"
if [ "$ENABLE_LOGGING" == "true" ]; then
  echo "Log input to $INCOMING_LOG_FILE."
  echo "Log output to $OUTGOING_LOG_FILE."
  $NC -l -p $INCOMING_PORT < $PIPE_FILE \
    | tee $OUTGOING_LOG_FILE \
    | nc $OUTGOING_SERVER $OUTGOING_PORT \
    | tee $PIPE_FILE $INCOMING_LOG_FILE
else
  echo "Disabled logging."
  $NC -l -p $INCOMING_PORT < $PIPE_FILE \
    | $NC $OUTGOING_SERVER $OUTGOING_PORT > $PIPE_FILE
fi

rm -f $PIPE_FILE
