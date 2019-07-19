# ROOT with python-3 support dockerfile

Build ROOT with support for python-3 instead of the default python3
of the pre-compiled images on 
[root-download page](https://root.cern.ch/downloading-root).


## Installation
Assuming ```docker``` is installed on your system (host-computer), 
you can either:
 *  Download the automated build from the dockerhub (**Recommended**): 
 ```bash
 $ docker pull duartej/rootpython3:6.18.0
 ```
 * Alternativelly you can build the image from the [Dockerfile](Dockerfile)
   * Directly from the github repository
   ```bash
   # Using the docker from the repository (no downloading the repo)
   $ docker build github.com/duartej/dockerfiles-rootpython3#master
   ```
   * Downloading this repo and building the image:
   ```bash
   $ git clone https://github.com/duartej/dockerfiles-rootpython3.git
   $ cd dockerfiles-rootpython3/
   $ docker-compose build rootpython3:6.18.0
   ```

## Usage
Run the container as 
```bash
$ docker run --rm -i \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=unix${DISPLAY} \
    duartej/rootpython3:6.18.0
```
If you built the image using a different name, subtitute it there.

Don't forget to allow the docker group to use the X-server if you need to use 
the X-windows:
```bash
xhost +local:docker
```


