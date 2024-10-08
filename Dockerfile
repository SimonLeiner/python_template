# If you have a Mac with an M1 (Apple Silicon) processor, you should use the ARM64 version of Docker images.
# arm64
# linux/amd64

# install python 3.12 for platform linux/amd64
FROM python:3.12-slim

# install git 
RUN apt-get update && apt-get install --no-install-recommends  -y \
    # github
    git \
    # for installing packages
    curl \
    # for interacting with remote servers
    openssh-client\
    # for psutil
    gcc python3-dev\
    # clean up
    && apt-get clean\
    && rm -rf /var/lib/apt/lists/*

# copy and install requirments
COPY requirements.txt requirements.txt
RUN pip install -U -r requirements.txt

# setting up pre commit hooks
COPY .pre-commit-config.yaml .
RUN git init . && pre-commit install

# set working directory
WORKDIR /workspace
