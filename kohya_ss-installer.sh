#!/bin/bash

# Get the current desktop path
desktop_path="$HOME/Desktop"

# Check for Python 3.8 and install if not found
if ! command -v python3.8 &> /dev/null; then
    echo "Python 3.8 not found. Installing Python 3.8..."
    apt update
    apt install -y python3.8
fi

# Update the package repository
sudo apt update

# Install required packages
sudo apt install -y python3-tk python3.8-venv firefox git

# Clone the repository
git clone https://github.com/bmaltais/kohya_ss.git "$desktop_path/kohya_ss"

# Check for successful cloning and change directory
if [ ! -d "$desktop_path/kohya_ss" ]; then
    echo "Error cloning the repository. Please check your internet connection and try again."
    exit 1
fi

cd "$desktop_path/kohya_ss"

# Install dependencies
python3.8 -m venv venv
source venv/bin/activate
pip install torch==1.12.1+cu116 torchvision==0.13.1+cu116 --extra-index-url https://download.pytorch.org/whl/cu116
pip install xformers
pip install --use-pep517 --upgrade -r requirements.txt

# Create a launcher script for the app
launcher_script="$desktop_path/kohya_launcher.sh"
echo "#!/bin/bash" > $launcher_script
echo "cd \"$desktop_path/kohya_ss\"" >> $launcher_script
echo "source venv/bin/activate" >> $launcher_script
echo "python3 kohya_gui.py" >> $launcher_script
chmod +x $launcher_script

# Print a message to the user indicating the installation is complete
echo "Kohya SS has been installed. To launch the app, run the kohya_launcher.sh script on your Desktop."

# Exit the script
exit 0
