#!/bin/bash

# Disable mouse acceleration
xset m 1 0

# Set the pointer speed: -1.0 (slow), 0 (default), 1(fast)
xinput set-prop 8 "libinput Accel Speed" -0.5
