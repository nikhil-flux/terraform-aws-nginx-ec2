#!/bin/bash
set -e

# Update package lists
apt-get update

# Install Nginx
apt-get install -y nginx

# Create index.html from template
cat > /var/www/html/index.html << 'EOF'
${index_html}
EOF

# Start Nginx
systemctl start nginx
systemctl enable nginx

echo "Nginx installed and started successfully"