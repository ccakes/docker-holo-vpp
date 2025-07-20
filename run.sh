#!/bin/bash

# Start VPP & holod
/usr/bin/vpp -c /etc/vpp/startup.conf &
/usr/bin/holod &

wait -n
exit $?
