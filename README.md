# Minecraft Docker Stack

This is a combination of other developers' much harder work.
It's designed to provide a super simple containerised experience using mostly defaults and entirely vanilla.

I intend to expand this stack in the future to make it mod-friendly, as the underlying (and very excellent) server docker
image `itzg/minecraft-server` supports mods.

Hopefully as the project goes it will remain a quick and smooth experience to set up for beginners and more advanced users alike. 

Hope you enjoy :)


## What does it do?
Out of the box, with a couple of commands you get:
- A vanilla minecraft java server (container name: `minecraft-server`), running the version of your choice, with various configurable options.
- A container running [Overviewer](https://overviewer.org/) on demand (`overviewer`), capable of generating a google maps style HTML static site render of the 
minecraft server's overworld.
- An Nginx container (`overviewer-web`) pre-configured to serve the overviewer-rendered map over HTTP.

> **PLEASE NOTE: At present, the server world and all associated data is stored in docker volumes. If the volumes are 
pruned or reset (in Docker Desktop for example) the world, everything will be lost. You can probably copy the world data from the 
server container with `docker cp`. There is an issue raised for the developer to alleviate this risk: https://github.com/fred-aghq/minecraft-docker-stack/issues/1**

## What do I need?
- Docker installed on your intended host system(s).
- Docker Compose installed on your intended host system(s).
 
## (The) Quick(est) Start (that I could come up with)
1. Copy `.env.example` to `.env`
> More detailed information on each available variable can be found in the `.env` file you just copied.
2. Modify `.env` variables to taste. You'll likely want to double-check the minecraft version.

3. Bring the server and nginx containers online.
```
docker-compose up -d minecraft-server overviewer-web
```
> - You may have to wait a while for the images to build.
>
> - Don't run `overviewer` just yet (see below), you need to at least let the world generate and spawn in the server for 
a first time. Don't worry if you DO bring overviewer online (i.e. if you didn't specify the web and minecraft containers 
on the `up` command). It'll just error out and can be run again later.

4. You will likely need to wait for the `minecraft-server` container to finish its initial startup and generate the world.
It's progress can be monitored by tailing the container logs: 

```
docker-compose logs -f minecraft-server
```
At the bottom of the logs you should expect to see something along the lines of:

```
minecraft-server_1  | [14:53:47] [Server-Worker-2/INFO]: Preparing spawn area: 86%
minecraft-server_1  | [14:53:48] [Server-Worker-1/INFO]: Preparing spawn area: 92%
minecraft-server_1  | [14:53:48] [Server-Worker-5/INFO]: Preparing spawn area: 99%
minecraft-server_1  | [14:53:48] [Server thread/INFO]: Time elapsed: 10528 ms
minecraft-server_1  | [14:53:48] [Server thread/INFO]: Done (22.440s)! For help, type "help"
minecraft-server_1  | [14:53:48] [Server thread/INFO]: Starting remote control listener
minecraft-server_1  | [14:53:48] [RCON Listener #1/INFO]: RCON running on 0.0.0.0:25575
```

5. Connect to the server from Minecraft Java Version! 
> - If you're testing out this stack on the same machine as a machine that can run 
Minecraft Java Version, you can connect via `localhost`, otherwise find out the host machine's IP address. 
>
> - The port is whatever you set in `.env`. (default `25565` which is Minecraft's default).

Click **Multiplayer**, **Direct Connect**, and enter the host and port. Let's say I just fired this up on my laptop. 
I would type:

```
localhost:25565
```
...and hit enter.

You should momentarily be connected to a docker-driven minecraft server!

6. Check the `overviewer-web` container is running

By default, you can find the overviewer map in a browser at `localhost:8080` (or using the host machine's IP instead of `localhost`).

You should expect to see a `403 Forbidden` as the web directory is initially empty, but this means the web server is 
running. 

## Running Overviewer
Once you've connected to the minecraft server at least once in-game, the file(s) required by overviewer will have been 
generated and you can now run `overviewer`.

```
docker-compose run overviewer
```

> This takes a while.

Once that's done running, you can open a browser and navigate to `localhost:8080` (or your host's IP and/or port you 
specified in `.env`).
