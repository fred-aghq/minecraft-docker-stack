#!/usr/bin/env sh
rm -rf /target/minecraft-server
rm -rf /target/overviewer-web
mkdir -p /target/minecraft-server && mkdir /target/overviewer-web
rsync -azvh --progress /source/minecraft-server/. /target/minecraft-server/.
rsync -azvh --progress /source/overviewer-web/. /target/overviewer-web/.
exit 0