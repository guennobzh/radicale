# Radicale image

This is an image to create a [radicale server](https://github.com/Kozea/Radicale)
container based on env vars configuration.

## Create container

With docker:

    $ docker start -d -p 5232:5232 -v /srv/radicale/config:/config -v /srv/radicale/data:/data exoslpm/radicale

# Build

    $ git clone https://github.com/exos/docker-radicale.git 
    $ cd docker-radicale
    $ docker build -t radicale .
