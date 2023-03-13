#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root or with sudo"
  exit
fi

# Update the package repository
apt update

# Install required packages
apt install -y python3-tk python3.8-venv firefox

# Clone the repository
git clone https://github.com/bmaltais/kohya_ss.git

# Change ownership of the kohya_ss directory to kasm-user
chown -R kasm-user:kasm-user kohya_ss

# Install dependencies
cd kohya_ss
python3.8 -m venv venv
source venv/bin/activate
pip3 install torch==1.12.1+cu116 torchvision==0.13.1+cu116 --extra-index-url https://download.pytorch.org/whl/cu116
pip3 install xformers
pip3 install --use-pep517 --upgrade -r requirements.txt

# Create a launcher script for the app
echo "#!/bin/bash" > ../kohya_launcher.sh
echo "cd $(pwd)" >> ../kohya_launcher.sh
echo "source venv/bin/activate" >> ../kohya_launcher.sh
echo "python3 kohya_gui.py" >> ../kohya_launcher.sh
chmod +x ../kohya_launcher.sh

# Change ownership of the launcher script to kasm-user
chown kasm-user:kasm-user ../kohya_launcher.sh

# Print a message to the user indicating the installation is complete
echo "Kohya SS has been installed. To launch the app, run the kohya_launcher.sh script in the directory above kohya_ss."

# Exit the script
exit 0
