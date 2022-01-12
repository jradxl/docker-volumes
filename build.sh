#!/bin/bash -e

##https://faun.pub/set-current-host-user-for-docker-container-4e521cef9ffc 

echo "Docker RUN dir is $XDG_RUNTIME_DIR"
echo "PWD is $PWD"
echo "HOME is $HOME"

export DUID=$(id -u)
export DGID=$(id -g)
echo "User, UserID and GroupID are: $USER, $DUID, $DGID"

docker container rm -f test1-run 
docker image rm -f test1

docker build --build-arg DUSER=$USER \
             --build-arg DUID=$DUID \
             --build-arg DGID=$DGID \
             -t test1 \
             .

exit 0
