#!/usr/bin/env bash

set -xeuo pipefail
trap "echo [ComfyUISetup] script encountered an error. exiting without restart; exit 0" ERR

: "[ComfyUISetup] setup script starting..."

COMFY_DIR=/workspace/ComfyUI
COMFY_ENV_DIR=/workspace/comfyenv

if [ ! -d $COMFY_ENV_DIR ]; then
  : "[ComfyUISetup] No Conda environment found, creating..."
  conda create -y -p $COMFY_ENV_DIR python=3.12 
  conda install -y -p $COMFY_ENV_DIR pytorch=2.7.* cuda-toolkit=12.6 torchvision torchaudio -c pytorch -c nvidia
fi

if [ ! -d $COMFY_DIR ]; then
  : "[ComfyUISetup] No ComfyUI found, creating..."
  git clone --depth 1 https://github.com/comfyanonymous/ComfyUI.git $COMFY_DIR
  cd $COMFY_DIR
  conda run -p $COMFY_ENV_DIR pip install -r requirements.txt
fi

COMFY_MGR_DIR=$COMFY_DIR/custom_nodes/comfyui-manager
if [ ! -d $COMFY_MGR_DIR ]; then
  : "[ComfyUISetup] No ComfyUI Manager found, creating..."
  git clone --depth 1 https://github.com/ltdrdata/ComfyUI-Manager.git $COMFY_MGR_DIR
fi

MODEL_MGR_DIR=$COMFY_DIR/custom_nodes/ComfyUI-Model-Manager
if [ ! -d $MODEL_MGR_DIR ]; then
  : "[ComfyUISetup] No ComfyUI-Model-Manager found, creating..."
  git clone --depth 1 https://github.com/hayden-fr/ComfyUI-Model-Manager.git $MODEL_MGR_DIR
fi

CRYSTOOLS_DIR=$COMFY_DIR/custom_nodes/ComfyUI-Crystools
if [ ! -d $CRYSTOOLS_DIR ]; then
  : "[ComfyUISetup] No ComfyUI-Crystools found, creating..."
  git clone --depth 1 https://github.com/crystian/ComfyUI-Crystools.git $CRYSTOOLS_DIR
  cd $CRYSTOOLS_DIR
  conda run -p $COMFY_ENV_DIR pip install -r requirements.txt
fi

OUTPUT_DIR="/workspace/output"
if [ ! -d $OUTPUT_DIR ]; then
  mkdir $OUTPUT_DIR
fi

: "[ComfyUISetup] finished"
