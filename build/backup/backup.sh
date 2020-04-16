#!/usr/bin/env sh
echo "hello"
ls -al /source/minecraft-server
rm -rf /target/minecraft-server/*
rsync -azvh --progress /source/minecraft-server/. /target/minecraft-server/.