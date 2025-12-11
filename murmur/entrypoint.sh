#!/bin/bash

# enable bash job control
set -m

if [[ -v MURMUR_PORT ]]; then
    echo "Setting port to ${MURMUR_PORT}"
    sed -i "s/^port=.*/port=${MURMUR_PORT}/" ./prmurmur.ini
fi

if [[ -v MUMO_PORT ]]; then
    echo "Setting port to ${MUMO_PORT}"
    sed -i "s/^ice=\"tcp -h 127.0.0.1 -p .*\"/ice=\"tcp -h 127.0.0.1 -p ${MUMO_PORT}\"/" ./prmurmur.ini
    sed -i "s/^port = .*/port = ${MUMO_PORT}/" ./mumo/mumo.ini
fi

# start the server
./prmurmurd.x64 -fg &

# sleep a few seconds to make sure everything is up
sleep 5

# run the setup script
./setup.sh
# grep "Password for 'SuperUser'" prmurmur.log | cut -d ">" -f 2-

# start the python process
cd mumo
python mumo.py &

fg %1
