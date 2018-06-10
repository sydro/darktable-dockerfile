# Docker Darktable

Docker image for [Darktable](https://www.darktable.org/).

## Starting a Darktable container

```
docker run -d \
  --cpuset-cpus 0 \
  -v /etc/localtime:/etc/localtime:ro \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $HOME/Immagini:/home/darktable/Immagini \
  -e DISPLAY=unix$DISPLAY \
  -e GDK_SCALE \
  -e GDK_DPI_SCALE \
  --device /dev/dri \
  --name darktable \
  sydro/darktable:latest /opt/darktable/bin/darktable

```
