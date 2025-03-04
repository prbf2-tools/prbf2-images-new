#!/bin/bash


if [[ -f ".murmursetup" ]]; then
    echo "Skipping Setup - already configured"
else
    cd mumo/tools

    python prbf2setup.py -s prmurmurpassword -i "../../PRMurmur.ice"

    if [[ -v MURMUR_SECRET ]]; then
        if [ ! -f /murmur/mumo/modules-enabled/prbf2.ini ]; then
            echo "Inserting pre-defined MURMUR_SECRET into mumo config"
            mkdir /murmur/mumo/modules-enabled
            echo "[prbf2]
gamecount = 0
secret = ${MURMUR_SECRET}" > /murmur/mumo/modules-enabled/prbf2.ini
        fi
    fi

    python prbf2man.py -c $CHANNEL_ID -n "$SERVER_NAME" -f $GAMESERVER_IP -b 1 -o "../modules-enabled/prbf2.ini" -s prmurmurpassword -i "../../PRMurmur.ice"

    if [[ -v MURMUR_SU_PASS ]]; then
        ./prmurmurd.x64 -supw $MURMUR_SU_PASS
    fi

    touch .murmursetup
fi
