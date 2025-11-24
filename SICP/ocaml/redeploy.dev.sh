#!/bin/bash
set -e

docker compose down
docker compose up -d
docker compose exec -it ocaml-dev /bin/bash
