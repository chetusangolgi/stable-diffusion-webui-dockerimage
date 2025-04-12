FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    git wget curl unzip bzip2 ca-certificates libglib2.0-0 libsm6 libxext6 libxrender-dev libgl1 \
    python3 python3-venv python3-pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create user directory
WORKDIR /app

# Clone A1111 repo
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui .

# Set up virtual environment
RUN python3 -m venv venv && \
    . venv/bin/activate && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

COPY models /app/models


# Expose the port
EXPOSE 7860

# Run WebUI
CMD ["bash", "-c", ". venv/bin/activate && python launch.py --listen --xformers --enable-insecure-extension-access"]
