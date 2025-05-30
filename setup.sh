#!/usr/bin/env bash
set -euo pipefail

echo "ComfyUI Setup Script starting..."

COMFY_DIR="/workspace/ComfyUI"

# One-time setup ────────────────────────────────────────
if [ ! -d "$COMFY_DIR" ]; then
  echo "$COMFY_DIR not found, installing ComfyUI..."
  
  apt update
  apt install -y wget curl git ca-certificates
fi
