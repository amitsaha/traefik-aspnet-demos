#!/bin/bash

sudo docker run -d -p 8080:8080 -p 80:80 \
        -v $PWD/traefik.toml:/etc/traefik/traefik.toml \
        -v /var/run/docker.sock:/var/run/docker.sock \
        traefik
