#!/usr/bin/env bash
set -euo pipefail

COMFY_DIR="/workspace/ComfyUI"

# ── one-time setup ────────────────────────────────────────
if [ ! -d "$COMFY_DIR" ]; then
  echo "$COMFY_DIR not found, installing ComfyUI..."
  git clone --depth 1 https://github.com/comfyanonymous/ComfyUI "$COMFY_DIR"
  python -m venv "$COMFY_DIR/venv"
  "$COMFY_DIR/venv/bin/pip" install -U pip wheel
  "$COMFY_DIR/venv/bin/pip" install -r "$COMFY_DIR/requirements.txt"
fi

# ── launch comfy ────────────────────────────────────────────────
cd "$COMFY_DIR"
source venv/bin/activate
exec python main.py --listen 0.0.0.0 --port 8188
