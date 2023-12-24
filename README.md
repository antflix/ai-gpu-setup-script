# ai-gpu-setup-script

This repo contains a script `setup.sh` to set up GPU anaconda environments for PyTorch and Tenspoflow (tested on Ubuntu). Additionally there is a `Dockerfile` for building a container that is set up with the environments created in the setup script. It can be found on [Docker Hub](https://hub.docker.com/repository/docker/slandl/conda-cuda/general).

The point of this script is to quickly set up environments for machine learning. I use the docker image from this repository as a development environment running on my server, which I can remote into to have a consistent environment and a GPU available.
