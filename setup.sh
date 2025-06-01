#!/usr/bin/env bash

set -xeuo pipefail
trap "echo [ComfyUISetup] script encountered an error. exiting without restart; exit 0" ERR

: "[ComfyUISetup] setup script starting..."

COMFY_DIR="/workspace/ComfyUI"
CONDA_ENV_DIR="/workspace/comfyenv"

# One-time setup ────────────────────────────────────────
if [ ! -d $CONDA_ENV_DIR ]; then
  : "[ComfyUISetup] No Conda environment found, creating..."
  conda create -y -p $CONDA_ENV_DIR python=3.12 
  conda install -y -p $CONDA_ENV_DIR pytorch=2.7.* torchvision torchaudio -c pytorch -c nvidia -c conda-forge
fi

if [ ! -d "$COMFY_DIR" ]; then
  : "[ComfyUISetup] No ComfyUI found, creating..."
  git clone --depth 1 https://github.com/comfyanonymous/ComfyUI.git $COMFY_DIR
  cd $COMFY_DIR
  conda run -p $CONDA_ENV_DIR pip install -r requirements.txt
fi

: "[ComfyUISetup] finished"
