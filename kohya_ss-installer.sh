#!/bin/bash

# Update the package repository
sudo apt update

# Add deadsnakes PPA for installing Python 3.10
sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt update

# Install required packages
sudo apt install -y python3.10 python3.10-tk python3.10-distutils python3.10-dev firefox git chromium-browser

# Set Python 3.10 as the default Python interpreter
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

# Update pip
curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10

# Add the pip script location to PATH
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
export PATH="$HOME/.local/bin:$PATH"

# Clone the repository
git clone https://github.com/bmaltais/kohya_ss.git

# Install dependencies
cd kohya_ss
python3.10 -m pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu116
python3.10 -m pip install --use-pep517 --upgrade -r requirements.txt
python3.10 -m pip install xformers

# Check if the system has an NVIDIA A5000 GPU
if nvidia-smi --query-gpu=name --format=csv,noheader | grep -q "A5000"; then
  echo "NVIDIA A5000 GPU detected. Applying necessary fixes."

  # Install libjpeg and libpng
  sudo apt-get install -y libjpeg-dev libpng-dev

  # Reinstall torchvision
  python3.10 -m pip install --no-cache-dir --force-reinstall torchvision
  python3.10 -m pip install xformers

  # Adjust TensorFlow, CUDA, and cuDNN installation if needed
fi

# Create a launcher script for the app
launcher_script="../kohya_launcher.sh"
echo "#!/bin/bash" > $launcher_script
echo "cd $(pwd)" >> $launcher_script
echo "python3.10 kohya_gui.py" >> $launcher_script
chmod +x $launcher_script

# Uninstall the system psutil package
sudo apt remove -y python3-psutil

# Install the psutil package for the local Python environment
python3.10 -m pip install --upgrade psutil

# Print a message to the user indicating the installation is complete
echo "Kohya SS has been installed. To launch the app, close this window and open terminal then run accelerate config."
echo "Accelerate config answers: this machine, no distributed training, NO, NO, NO, all, fp16."
echo "Then run app using kohya_launcher.sh script."

# Exit the script
exit 0
