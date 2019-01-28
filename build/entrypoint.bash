#!/bin/bash -e

#. /usr/local/bin/docker-php-entrypoint
set -e

if [ "$HOST_USER" ]; then
  OWNER=$(echo $HOST_USER | cut -d: -f1)
  GROUP=$(echo $HOST_USER | cut -d: -f2)
else
  OWNER=$(stat -c '%u' $PROJECTMAPPINGFOLDER)
  GROUP=$(stat -c '%g' $PROJECTMAPPINGFOLDER)
fi

if [ "$OWNER" != "0" ]; then
  usermod -o -u $OWNER www-data
  groupmod -o -g $GROUP www-data
fi

#usermod -u 1000 www-data
#groupmod -g 1000 www-data

#ORIGPASSWD=$(cat /etc/passwd | grep www-data)
#ORIG_UID=$(echo "$ORIGPASSWD" | cut -f3 -d:)
#ORIG_GID=$(echo "$ORIGPASSWD" | cut -f4 -d:)
#ORIG_HOME=$(echo "$ORIGPASSWD" | cut -f6 -d:)
#DEV_UID=${DEV_UID:=$ORIG_UID}
#DEV_GID=${DEV_GID:=$ORIG_GID}

#if [ "$DEV_UID" -ne "$ORIG_UID" ] || [ "$DEV_GID" -ne "$ORIG_GID" ]; then
#    groupmod -g "$DEV_GID" www-data
#    usermod -u "$DEV_UID" -g "$DEV_GID" www-data
#fi

# Create .composer in advance and set the permissions
mkdir -p /var/www/.composer && chown www-data:www-data /var/www/.composer
#chown www-data:www-data $PROJECTMAPPINGFOLDER

# give the good permissions to www-data in the container and remove the cache on start
# 2.x
if [ -d "$PROJECTMAPPINGFOLDER/var" ]; then
    chown -R www-data:www-data "$PROJECTMAPPINGFOLDER/var"
fi

if [ -d "$PROJECTMAPPINGFOLDER/var/cache" ]; then
    rm -rf "$PROJECTMAPPINGFOLDER/var/cache/*"
fi

if [ -d "$PROJECTMAPPINGFOLDER/var/site_var/cache" ]; then
    rm -rf "$PROJECTMAPPINGFOLDER/var/site_var/cache/*"
fi

exec "$@"
