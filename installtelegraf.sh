#!/bin/bash

#Change the username and group where telegraf is going to be used.  This is optional.

USER=telegraf

GROUP=telegraf

#Add the user from a non persistent reboot

echo "Adding user"

egrep -i "^$USER:" /etc/passwd;

 if [ $? -eq 0 ]; then

    echo "User Exists"

else

    groupadd $USER

    usermod -a -G $GROUP $USER

fi

echo "Installing telegraf"

#Move to flash and install the .rpm for any version of telegraf. 

cd /mnt/flash

ls -1 *.rpm | grep tele | while read PKG; do rpm -ivh "${PKG}"; done

if [ -f /mnt/flash/telegraf.conf ]; then

 telegraf -config /mnt/flash/telegraf.conf &

else

 echo "Using the default telegraf configuration file."

 telegraf -config /mnt/flash/telegraf.conf &

fi

exit