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

# Function to clone a GitHub repo if its target directory doesn’t exist,
# and optionally run pip install.
#
# Args:
#   1) name     : display name of the component (for logging)
#   2) dest     : full path to the destination folder
#   3) url      : GitHub URL to clone
#   4) do_pip   : “true” or “false” – whether to run pip install after cloning
setup_component() {
  local name="$1"
  local dest="$2"
  local url="$3"
  local do_pip="$4"

  if [ ! -d "$dest" ]; then
    echo "[ComfyUISetup] No $name found, creating..."
    git clone --depth 1 "$url" "$dest"

    if [ "$do_pip" = "true" ]; then
      # Enter the newly cloned directory, install requirements, then return
      cd "$dest"
      conda run -p "$COMFY_ENV_DIR" pip install -r requirements.txt
      cd - > /dev/null
    fi
  fi
}

setup_component "ComfyUI" \
                "$COMFY_DIR" \
                "https://github.com/comfyanonymous/ComfyUI.git" \
                true


setup_component "ComfyUI Manager" \
                "$COMFY_DIR/custom_nodes/comfyui-manager" \
                "https://github.com/ltdrdata/ComfyUI-Manager.git" \
                false

setup_component "ComfyUI Model Manager" \
                "$COMFY_DIR/custom_nodes/ComfyUI-Model-Manager" \
                "https://github.com/hayden-fr/ComfyUI-Model-Manager.git" \
                false

setup_component "ComfyUI-Crystools" \
                "$COMFY_DIR/custom_nodes/ComfyUI-Crystools" \
                "https://github.com/crystian/ComfyUI-Crystools.git" \
                true

OUTPUT_DIR="/workspace/output"
if [ ! -d $OUTPUT_DIR ]; then
  mkdir $OUTPUT_DIR
fi

: "[ComfyUISetup] finished"
