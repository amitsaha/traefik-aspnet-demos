#!/bin/bash

sudo docker run -d -p 80:80 -p 443:443 \
        -v $PWD/traefik.toml:/etc/traefik/traefik.toml \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v $PWD/acme.json:/acme.json \
        traefik
