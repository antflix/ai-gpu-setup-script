#!/bin/bash

PYTORCH_VERSION="2.0.1"
PYTORCH_CUDA_VERSION="11.7"

#TENSORFLOW_VERSION="2.13.*"
#CUDA_VERSION_TENSORFLOW="11.7.1"
#CUDNN_VERSION_TENSORFLOW="11==8.6.0.163"

HISTSIZE="250000"

set -e # cancel script upon single failure

# General setup
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt install git nano sed wget net-tools python3 python3-pip -y

# edit .bashrc for convenience
echo "alias update='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y'" >> .bashrc
sed -i "s/HISTSIZE=.*/HISTSIZE=$HISTSIZE/" .bashrc
sed -i "s/HISTFILESIZE=.*/HISTFILESIZE=$HISTSIZE/" .bashrc

# install Miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $HOME/miniconda.sh
bash $HOME/miniconda.sh -b -p $HOME/miniconda
eval "$($HOME/miniconda/bin/conda shell.bash hook)"
conda init

# set up pytorch environment
conda create --name pytorch python=3.11 -y
conda activate pytorch
conda install pytorch=$PYTORCH_VERSION torchvision torchaudio pytorch-cuda=$PYTORCH_CUDA_VERSION -c pytorch -c nvidia -y
python pytorch-gpu-test.py

# set up tensorflow environment
#conda create --name tensorflow python=3.11 -y
#conda activate tensorflow
#conda install -c conda-forge cudatoolkit=$CUDA_VERSION_TENSORFLOW -y
#pip install nvidia-cudnn-cu$CUDNN_VERSION_TENSORFLOW tensorflow==$TENSORFLOW_VERSION
#mkdir -p $CONDA_PREFIX/etc/conda/activate.d
#echo 'CUDNN_PATH=$(dirname $(python -c "import nvidia.cudnn;print(nvidia.cudnn.__file__)"))' >> $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh
#echo 'export LD_LIBRARY_PATH=$CONDA_PREFIX/lib/:$CUDNN_PATH/lib:$LD_LIBRARY_PATH' >> $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh
#source $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh
#python tensorflow-gpu-test.py

echo "Installed python and tensorflow environments with the following versions:"
echo ""
echo "PYTORCH_VERSION=$PYTORCH_VERSION"
echo "PYTORCH_CUDA_VERSION=$PYTORCH_CUDA_VERSION"
echo ""
echo "TENSORFLOW_VERSION=$TENSORFLOW_VERSION"
echo "CUDA_VERSION_TENSORFLOW=$CUDA_VERSION_TENSORFLOW"
echo "CUDNN_VERSION_TENSORFLOW=$CUDNN_VERSION_TENSORFLOW"
