#!/usr/bin/env bash

set -xeuo pipefail
trap "echo [ComfyUISetup] script encountered an error. exiting without restart; exit 0" ERR

: "[ComfyUISetup] setup script starting..."

COMFY_DIR="/workspace/ComfyUI"
COMFY_MGR_DIR="/workspace/ComfyUI/custom_nodes/comfyui-manager"
COMFY_ENV_DIR="/workspace/comfyenv"
NOTEBOOK_ENV_DIR="/workspace/notebookenv"
OUTPUT_DIR="/workspace/output"

if [ ! -d $COMFY_ENV_DIR ]; then
  : "[ComfyUISetup] No Conda environment found, creating..."
  conda create -y -p $COMFY_ENV_DIR python=3.12 
  conda install -y -p $COMFY_ENV_DIR pytorch=2.7.* torchvision torchaudio -c pytorch -c nvidia -c conda-forge
fi

if [ ! -d $COMFY_DIR ]; then
  : "[ComfyUISetup] No ComfyUI found, creating..."
  git clone --depth 1 https://github.com/comfyanonymous/ComfyUI.git $COMFY_DIR
  cd $COMFY_DIR
  conda run -p $COMFY_ENV_DIR pip install -r requirements.txt
fi

if [ ! -d $COMFY_MGR_DIR ]; then
  : "[ComfyUISetup] No ComfyUI Manager found, creating..."
  git clone --depth 1 https://github.com/ltdrdata/ComfyUI-Manager $COMFY_MGR_DIR
fi

if [ ! -d $OUTPUT_DIR ]; then
  mkdir $OUTPUT_DIR
fi

if [ ! -d $NOTEBOOK_ENV_DIR ]; then
  conda create -y -p $NOTEBOOK_ENV_DIR python=3.11
  conda install -y -p $NOTEBOOK_ENV_DIR pytorch=2.7.* jupyterlab=4.* -c conda-forge
fi

: "[ComfyUISetup] finished"
