#!/bin/bash
apache2-foreground &
sleep 15
IS_INSTALLED=$(curl --silent localhost | grep -E "<h3>Delete the install folder</h3>")
if [ "$IS_INSTALLED" ]; 
then
rm -rf /var/www/html/install
echo "folder removed"
else
echo "everything is ok."
fi
wait
exec "$@"