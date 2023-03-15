#!/bin/bash

# Update the package repository
sudo apt update

# Add deadsnakes PPA for installing Python 3.10
sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt update

# Install required packages
sudo apt install -y python3.10 python3.10-tk python3.10-distutils firefox git

# Set Python 3.10 as the default Python interpreter
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

# Add the pip script location to PATH
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Clone the repository
git clone https://github.com/bmaltais/kohya_ss.git

# Install dependencies
cd kohya_ss
python3.10 -m pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu116
python3.10 -m pip install --use-pep517 --upgrade -r requirements.txt
python3.10 -m pip install xformers

# Create a launcher script for the app
launcher_script="../kohya_launcher.sh"
echo "#!/bin/bash" > $launcher_script
echo "cd $(pwd)" >> $launcher_script
echo "python3.10 kohya_gui.py" >> $launcher_script
chmod +x $launcher_script

# Print a message to the user indicating the installation is complete
echo "Kohya SS has been installed. To launch the app, run the kohya_launcher.sh script in the directory above kohya_ss."

# Exit the script
exit 0
