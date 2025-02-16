# Octoprint rootless
My take of rootless octoprint container. Probably best to use official octoprint/octoprint:minimal image instead but I needed to some things differenty to make this work with https://github.com/jarpatus/docker-octocam/ .

# Compose file

## Example
```
services:
  octoprint:
    container_name: octoprint
    build:
      context: src
      args:
        - UID=5000
        - GID=5000
    restart: always
    group_add:
      - dialout
    devices:
      - /dev/ttyUSB0:/dev/ttyUSB0
    volumes:
     - ./config:/home/octoprint/config
     - ./plugins:/home/octoprint/plugins
     - /opt/podman/octocam/run:/run/octocam
    ports:
      - 5000:5000
```
