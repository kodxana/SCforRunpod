#!/bin/bash

# Clone the repository
git clone https://github.com/d8ahazard/sd_dreambooth_extension /workspace/sd/stable-diffusion-webui/extensions

# Install pip requirements
cd /workspace/sd/stable-diffusion-webui/extensions/sd_dreambooth_extension
pip install -r requirements.txt
