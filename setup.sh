#!/usr/bin/env bash
set PS4=''

echo "ComfyUI Setup Script starting..."

set -xeuo pipefail

COMFY_DIR="/workspace/ComfyUI"
CONDA_ENV_DIR="/workspace/comfyenv"

# One-time setup ────────────────────────────────────────
if [ ! -d "$COMFY_DIR" ]; then
  echo "$COMFY_DIR not found, installing ComfyUI..."
  
  # Conda environment
  conda create -y -p $CONDA_ENV_DIR python=3.12 
  conda install pytorch=2.6.* pytorch-cuda=12.4 torchvision torchaudio -c pytorch -c nvidia -c conda-forge

  # ComfyUI
  git clone --depth 1 https://github.com/comfyanonymous/ComfyUI.git $COMFY_DIR
  cd $COMFY_DIR
  conda run -p $CONDA_ENV_DIR pip install -r requirements.txt

  sleep infinity
fi

cd $COMFY_DIR
conda run -p $CONDA_ENV_DIR python main.py
