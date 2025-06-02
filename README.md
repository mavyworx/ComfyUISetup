Use this as container start command:

```
bash -c 'set -Eeuo pipefail ; \
apt-get update -qq && \
apt-get install -y --no-install-recommends curl wget git ca-certificates && \
curl -fsSL https://raw.githubusercontent.com/mavyworx/ComfyUISetup/main/setup.sh | bash && \
cd /workspace/ComfyUI && \
exec conda run -p /workspace/comfyenv python main.py --listen 0.0.0.0 --port 8188 --output-directory /workspace/output'
```
