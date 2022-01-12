#!/bin/sh

if [ ! -d "/data" ]; then
  ln -s /data_save /data
elif [ -z "$(ls -A /data)" ]; then
  cp -a /data_save/. /data/
fi
exec "$@"
