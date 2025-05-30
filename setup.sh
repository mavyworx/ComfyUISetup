#!/usr/bin/env bash
set -euo pipefail

echo "ComfyUI Setup Script starting..."

COMFY_DIR="/workspace/ComfyUI"
CONDA_ENV_DIR="/workspace/comfyenv"

# One-time setup ────────────────────────────────────────
if [ ! -d "$COMFY_DIR" ]; then
  echo "$COMFY_DIR not found, installing ComfyUI..."

  # System packages
  apt update
  apt install -y wget curl git ca-certificates

  # Conda environment
  create -y -p $CONDA_ENV_DIR python=3.12 pytorch=2.6.* pytorch-cuda=12.4 -c pytorch -c nvidia -c conda-forge
fi
