#!/bin/bash

dockervols=$HOME/.local/share/docker/volumes

echo -e ""
dir1="test1-run-vol.test1/_data/"
echo -e "$dir1"
ls -al $dockervols/$dir1

echo -e ""
dir2="test1-run-vol.test2/_data/"
echo -e "$dir2"
ls -al $dockervols/$dir2

exit 0
