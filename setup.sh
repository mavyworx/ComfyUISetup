#!/usr/bin/env bash
set -euo pipefail

echo "ComfyUI Setup Script starting..."

COMFY_DIR="/workspace/ComfyUI"
CONDA_ENV_DIR="/workspace/comfyenv"

# One-time setup ────────────────────────────────────────
if [ ! -d "$COMFY_DIR" ]; then
  echo "$COMFY_DIR not found, installing ComfyUI..."
  
  # Conda environment
  conda create -y -p $CONDA_ENV_DIR python=3.12 pytorch=2.6.* pytorch-cuda=12.4 -c pytorch -c nvidia -c conda-forge
  conda activate $CONDA_ENV_DIR
fi
