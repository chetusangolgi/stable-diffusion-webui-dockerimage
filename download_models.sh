#!/bin/bash

# Set model paths
MODEL_DIR="/app/models/Stable-diffusion"
mkdir -p "$MODEL_DIR"

# Download DreamShaper 3.3 if not already present
if [ ! -f "$MODEL_DIR/DreamShaper_3.3.safetensors" ]; then
  echo "Downloading DreamShaper_3.3..."
  curl -L -o "$MODEL_DIR/DreamShaper_3.3.safetensors" \
    https://huggingface.co/Lykon/DreamShaper/resolve/main/DreamShaper_3.3.safetensors
fi

# ControlNet model path
CONTROLNET_DIR="/app/models/ControlNet"
mkdir -p "$CONTROLNET_DIR"

# Download control_scribble-fp16 model if not already present
if [ ! -f "$CONTROLNET_DIR/control_scribble-fp16.safetensor" ]; then
  echo "Downloading control_scribble-fp16..."
  curl -L -o "$CONTROLNET_DIR/control_scribble-fp16.safetensor" \
    https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_scribble-fp16.safetensors?download=true
fi
