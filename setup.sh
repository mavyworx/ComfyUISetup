#!/usr/bin/env bash
set -euo pipefail

echo "ComfyUI Setup Script starting..."

COMFY_DIR="/workspace/ComfyUI"

# One-time setup ────────────────────────────────────────
if [ ! -d "$COMFY_DIR" ]; then
  echo "$COMFY_DIR not found, installing ComfyUI..."
  
  apt update
  apt install -y wget curl git ca-certificates

  MINICONDA_DIR=/workspace/miniconda
  mkdir -p $MINICONDA_DIR
  wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $MINICONDA_DIR/miniconda.sh
  bash $MINICONDA_DIR/miniconda.sh -b -u -p $MINICONDA_DIR
  rm $MINICONDA_DIR/miniconda.sh
  source $MINICONDA_DIR/bin/activate
  conda create -y -n comfyenv python=3.12 pytorch=2.7.* pytorch-cuda=12.4 -c pytorch -c nvidia -c conda-forge
fi
