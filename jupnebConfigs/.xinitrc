#!/bin/bash

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

nvidia-settings --load-config-only --assign "CurrentMetaMode=DPY-6: nvidia-auto-select @3440x1440 +1920+0 {ViewPortIn=3440x1440, ViewPortOut=3440x1440+0+0}, DPY-1: nvidia-auto-select @1920x1080 +0+644 {ViewPortIn=1920x1080, ViewPortOut=1920x1080+0+0}" 
seq 0 1 | xargs -l1 -I@ compton -b -d :0.@ &

exec i3
