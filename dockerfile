FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y \
    git wget curl unzip bzip2 ca-certificates libglib2.0-0 libsm6 libxext6 libxrender-dev libgl1 \
    python3 python3-venv python3-pip ninja-build cmake && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Clone A1111 repo
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui .

# Create and activate virtual environment
RUN python3 -m venv venv && \
    . venv/bin/activate && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

# Install PyTorch 2.6.0 with CUDA 11.8
RUN . venv/bin/activate && \
    pip install torch==2.6.0 torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

# Install xFormers compatible with PyTorch 2.6.0 and CUDA 11.8
RUN . venv/bin/activate && \
    pip install xformers --index-url https://download.pytorch.org/whl/cu118

RUN mkdir -p /app/extensions && \
    git clone https://github.com/ahgsql/StyleSelectorXL /app/extensions/StyleSelectorXL && \
    git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui-nsfw-censor /app/extensions/stable-diffusion-webui-nsfw-censor

# Copy the model downloader script
COPY download_models.sh /app/download_models.sh
RUN chmod +x /app/download_models.sh

# Expose WebUI port
EXPOSE 7860

# Run WebUI with xformers
CMD ["bash", "-c", "/app/download_models.sh && . venv/bin/activate && python launch.py --listen --xformers --enable-insecure-extension-access --ckpt-dir /app/models/Stable-diffusion"]
