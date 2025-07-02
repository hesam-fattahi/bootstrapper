set -e

echo "strapping your system..."

# Load config
source config/setup.conf

# Update & upgrade
sudo apt update && sudo apt upgrade -y

# Install APT packages
while read -r pkg; do
  sudo apt install -y "$pkg"
done < config/packages.txt

# Install Snap packages (optional)
if [ -f config/snap.txt ]; then
  while read -r snap; do
    sudo snap install "$snap"
  done < config/snap.txt
fi

# Run post-install script
[ -f scripts/post_install.sh ] && bash scripts/post_install.sh

echo "Done setting up!"
