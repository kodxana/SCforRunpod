#!/bin/bash

# Get the current desktop path
desktop_path="$HOME/Desktop"

# Check for Python 3.10 and install if not found
if ! command -v python3.10 &> /dev/null; then
    echo "Python 3.10 not found. Installing Python 3.10..."
    apt update || { echo "Error updating package repository. Please check your internet connection and try again."; exit 1; }
    apt install -y software-properties-common || { echo "Error installing software-properties-common. Please check your permissions and try again."; exit 1; }
    add-apt-repository -y ppa:deadsnakes/ppa || { echo "Error adding the deadsnakes PPA repository. Please check your internet connection and try again."; exit 1; }
    apt update || { echo "Error updating package repository. Please check your internet connection and try again."; exit 1; }
    apt install -y python3.10 python3.10-venv || { echo "Error installing Python 3.10. Please check your permissions and try again."; exit 1; }
fi

# Update the package repository
sudo apt update || { echo "Error updating package repository. Please check your internet connection and try again."; exit 1; }

# Install required packages
sudo apt install -y python3-tk firefox git || { echo "Error installing required packages. Please check your permissions and try again."; exit 1; }

# Clone the repository
git clone https://github.com/bmaltais/kohya_ss.git "$desktop_path/kohya_ss" || { echo "Error cloning the repository. Please check your internet connection and try again."; exit 1; }

# Change directory
cd "$desktop_path/kohya_ss" || { echo "Error changing directory. Please check your permissions and try again."; exit 1; }

# Install dependencies
python3.10 -m venv venv || { echo "Error creating virtual environment. Please check your permissions and try again."; exit 1; }
source venv/bin/activate
pip install torch==1.12.1+cu116 torchvision==0.13.1+cu116 --extra-index-url https://download.pytorch.org/whl/cu116 || { echo "Error installing PyTorch packages. Please check your internet connection and try again."; exit 1; }
pip install xformers || { echo "Error installing xformers package. Please check your internet connection and try again."; exit 1; }
pip install --use-pep517 --upgrade -r requirements.txt || { echo "Error installing requirements from the requirements.txt file. Please check your internet connection and try again."; exit 1; }

# Create a launcher script for the app
launcher_script="$desktop_path/kohya_launcher.sh"
echo "#!/bin/bash" > $launcher_script
echo "cd \"$desktop_path/kohya_ss\"" >> $launcher_script
echo "source venv/bin/activate" >> $launcher_script
echo "python3 kohya_gui.py" >> $launcher_script
chmod +x $launcher_script || { echo "Error making the launcher script executable. Please check your permissions and try again."; exit 1; }

# Print a message to the user indicating the installation is complete
echo "Kohya SS has been installed. To launch the app, run the kohya_launcher.sh script on your Desktop."

# Exit the script
exit 0
