# stable-diffusion-webui-dockerimage
create a folder named models and add models in it

docker build -t a1111-webui .

docker run --gpus all -it --rm -p 7860:7860 -v "$(pwd)/models:/app/models" a1111-webui
