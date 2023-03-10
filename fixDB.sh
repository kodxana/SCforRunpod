#!/bin/bash

# Check if the directory exists, and if it doesn't, create it
if [ ! -d "/workspace/sd/stable-diffusion-webui/extensions" ]; then
  mkdir -p /workspace/sd/stable-diffusion-webui/extensions
fi

# Clone the repository
cd /workspace/sd/stable-diffusion-webui/extensions
git clone https://github.com/d8ahazard/sd_dreambooth_extension

# Install pip requirements
cd /workspace/sd/stable-diffusion-webui/extensions/sd_dreambooth_extension
pip install --upgrade pip
pip install -r requirements.txt
