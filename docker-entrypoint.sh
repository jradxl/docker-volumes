#!/bin/sh
# vim:sw=4:ts=4:et

set -e

if [ -z "${NGINX_ENTRYPOINT_QUIET_LOGS:-}" ]; then
    exec 3>&1
else
    exec 3>/dev/null
fi

echo >&3 "$0: In docker-entrypoint.sh"

## These are correctly written to their respective directories
## because all the mounts are valid at this point
echo -e "Written by docker-entrypoint.sh 1" >> /root/test1/internal1.txt
echo -e "Written by docker-entrypoint.sh 2" >> /root/test2/internal2.txt
echo -e "Written by docker-entrypoint.sh 3" >> /root/test3/internal3.txt
echo -e "Written by docker-entrypoint.sh 4" >> /root/test4/internal4.txt

echo >&3 "$0: Parameters are: <$1, $2> if any"

exec "$@"
