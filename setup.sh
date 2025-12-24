#!/bin/sh

# check if run as privileged user
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

# check if debian based
if [ -f /etc/debian_version ]; then
    echo "Debian based system detected"
else
    echo "This script only supports Debian based systems"
    exit 1
fi

# --------------------------------------

install_default_packages() {
    echo "Installing default packages..."
    apt-get update
    apt-get install -y git curl wget vim net-tools iputils-ping
    echo "Default packages installation complete."
}

setup_port_mirroring() {
    echo "Setting up port mirroring..."
    # Placeholder for port mirroring setup commands
    echo "Port mirroring setup complete."
}

setup_hardening() {
    echo "Setting up system hardening..."
    # Placeholder for hardening commands
    echo "System hardening complete."
}

install_tailscale() {
    echo "Installing Tailscale..."
    curl -fsSL https://tailscale.com/install.sh | sh
    sudo tailscale up
}

# test functions todo later

# --------------------------------------

install_default_packages
setup_port_mirroring
setup_hardening
install_tailscale
