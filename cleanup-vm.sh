#!/bin/bash
echo "=== COMPLETE CLEANUP OF VM2 ==="

# 1. STOP ALL SERVICES
echo "Stopping services..."
sudo systemctl stop keepalived 2>/dev/null || true
sudo systemctl stop docker 2>/dev/null || true
sudo systemctl stop docker.socket 2>/dev/null || true
sudo systemctl stop containerd 2>/dev/null || true

# 2. DISABLE SERVICES
echo "Disabling services..."
sudo systemctl disable keepalived 2>/dev/null || true
sudo systemctl disable docker 2>/dev/null || true

# 3. KILL ALL DOCKER PROCESSES
echo "Killing Docker processes..."
sudo pkill -9 -f docker 2>/dev/null || true
sudo pkill -9 -f containerd 2>/dev/null || true
sudo pkill -9 -f keepalived 2>/dev/null || true

# 4. REMOVE ALL CONTAINERS (FORCE)
echo "Removing all containers..."
docker stop $(docker ps -aq) 2>/dev/null || true
docker rm -f $(docker ps -aq) 2>/dev/null || true

# 5. REMOVE ALL DOCKER NETWORKS, VOLUMES, IMAGES
echo "Cleaning Docker system..."
docker system prune -af --volumes 2>/dev/null || true

# 6. REMOVE PROJECT DIRECTORY
echo "Removing project files..."
cd ~
rm -rf ~/grafana-ha

# 7. UNINSTALL PACKAGES
echo "Uninstalling packages..."
sudo apt remove --purge -y docker.io docker-compose keepalived containerd 2>/dev/null || true
sudo apt autoremove -y
sudo apt autoclean

# 8. REMOVE CONFIGURATION FILES
echo "Removing configuration files..."
sudo rm -rf /etc/keepalived 2>/dev/null || true
sudo rm -rf /etc/docker 2>/dev/null || true
sudo rm -rf /var/lib/docker 2>/dev/null || true
sudo rm -rf /var/lib/keepalived 2>/dev/null || true

# 9. CLEAN IPTABLES
echo "Cleaning iptables..."
sudo iptables -F
sudo iptables -X
sudo iptables -t nat -F
sudo iptables -t nat -X

# 10. VERIFY CLEANUP
echo ""
echo "=== VERIFICATION ==="
echo "Docker installed?"
which docker || echo "  - Docker: NOT FOUND (GOOD)"

echo "Keepalived installed?"
which keepalived || echo "  - Keepalived: NOT FOUND (GOOD)"

echo "Port 3000 in use?"
sudo netstat -tlnp | grep 3000 || echo "  - Port 3000: FREE (GOOD)"

echo ""
echo "=== VM2 IS CLEAN ==="
echo "You can now run the deploy script again"