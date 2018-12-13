#!/bin/bash

# Deploy the new version
image="amitsaha/aspnetcore-demo"
sudo docker run \
      --label "traefik.backend=aspnetcoredemodemo" \
      --label "traefik.frontend.rule=Host:aspnetcoredemo.echorand.me"  \
      --label "traefik.port=80" \
      --label "traefik.backend.healthcheck.path=/" \
      --label "traefik.backend.healthcheck.interval=5s" \
      --label "app=$image" \
      -d $image
