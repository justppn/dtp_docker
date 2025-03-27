#!/bin/bash

export LOG_KEY=/var/log/datareon
export LOGS_FOLDER=/var/log/datareon

LOCK_FILE=/var/datareon/init.lock
if [ ! -f "$LOCK_FILE" ]; then
  /usr/bin/platformmanager init
  /usr/bin/platformmanager initenvironment -n LOGS_FOLDER -v /var/log/datareon
  sleep 120
  # Create the lock file
  echo "Init complete. Do not delete this file!" > "$LOCK_FILE"
fi

/usr/bin/platformmanager start

while :; do
  sleep 300
done
