# stable-diffusion-webui-dockerimage

docker build -t a1111-webui .

docker run --gpus all -it --rm -p 7860:7860 -v "$(pwd)/models:/app/models" a1111-webui

or

docker compose up --build
(to build through docker compose)
