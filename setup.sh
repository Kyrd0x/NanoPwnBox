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

LOG_FILE="/var/log/pwnbox_setup.log"
exec > >(tee -i $LOG_FILE) 2>&1

# --------------------------------------

install_default_packages() {
    echo "Installing default packages..."
    apt-get update
    apt-get install -y sudo git curl wget vim iproute2 net-tools iputils-ping
    echo "Default packages installation complete."
}

setup_port_mirroring() {
    echo "Setting up port mirroring..."
    apt-get install -y ifupdown bridge-utils isc-dhcp-client

    cat <<EOF > /etc/network/interfaces
auto lo br0
iface lo inet loopback

iface enp1s0 inet manual
iface end0 inet manual

iface br0 inet dhcp
    bridge_ports enp1s0 end0
    bridge_stp off
    bridge_fd 0
    bridge_maxwait 0
EOF
    systemctl stop systemd-networkd
    systemctl disable systemd-networkd
    systemctl stop systemd-networkd systemd-networkd.socket
    systemctl disable systemd-networkd systemd-networkd.socket

    systemctl enable --now networking

    # Setup IPv4 / IPv6 forwarding
    echo 'net.ipv4.ip_forward=1' | tee -a /etc/sysctl.d/99-tailscale.conf
    echo 'net.ipv6.conf.all.forwarding=1' | tee -a /etc/sysctl.d/99-tailscale.conf
    sysctl -p /etc/sysctl.d/99-tailscale.conf

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
}

# test functions todo later

# --------------------------------------

install_default_packages
setup_port_mirroring
setup_hardening
install_tailscale

echo "Setup complete!"
echo "Don't forget to configure Tailscale on your PwnBox as per the README instructions."