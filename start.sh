#!/bin/bash -e

##https://stackoverflow.com/questions/47519309/mount-an-empty-folder-in-host-to-a-non-empty-folder-in-docker

echo "Docker RUN dir is $XDG_RUNTIME_DIR"
echo "PWD is $PWD"
echo "HOME is $HOME"
now=$(date +"%Y_%m_%d_%H_%M_%S")
echo $now

## Create in advance one of the Bind mount points
mkdir -p $PWD/test1-run-bind/test3
echo -e "Written by start.sh at $now" >> $PWD/test1-run-bind/test3/file3.txt
## The above should be viewable within the Container

docker container rm -f test1-run 
docker volume create test1-run.test1

docker run -p3080:80 \
    --name=test1-run \
    -v test1-run-vol.test1:/root/test1 \
    -v test1-run-vol.test2:/root/test2 \
    -v $PWD/test1-run-bind/test3:/root/test3 \
    -v $PWD/test1-run-bind/test4:/root/test4 \
    test1:latest

exit 0

#docker run -v /home/docker/fred1/vol1:/var/log --name fred -it test1 bash
#docker run -p3080:80 --name fred -v /home/docker/fred1/logs:/var/log -it test1 bash
##mkdir -p /home/docker/test2-run/logs/nginx
##    -v $XDG_RUNTIME_DIR:/var/run/docker.sock \
##    --user 1003:1004 \
#rm -rf /home/docker/test2-run
#mkdir -p /home/docker/test2-run

##mkdir -p "$(pwd)"/test2-run/mydata
##--opt device="$(pwd)"/test2-run/mydata \
##rm -rf   $HOME/testdata/test2-run
##docker volume rm test2-run-vol
#mkdir -p $PWD/testdata/test2-run/mydata

#docker volume create --driver local \
#    --opt type=none \
#    --opt device=$PWD/testdata/test2-run/mydata \
#    --opt o=bind \
#    test2-run-vol
    
#docker run -d -p3080:80 \
#    --name=test2-run \
#    -v "$(pwd)"/target:/test4 \
#    test1:latest

#docker run -d -p3080:80 \
#    --name=test2-run \
#    -v test2-run-vol:/test4 \
#    test1:latest

##THESE VOLUMES COULD BE PRUNED AWAY!!
##docker volume create test2-run.logs
