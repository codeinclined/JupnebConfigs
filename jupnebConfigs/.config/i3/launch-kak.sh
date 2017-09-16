#!/bin/sh

kak -l | grep "kak-i3"

if [ $? -ne 0 ]; then
  exec kak -s "kak-i3" 
else
  exec kak -c "kak-i3"
fi
