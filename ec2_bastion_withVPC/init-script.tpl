#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl enable httpd
sudo systemctl start httpd

# Get instance ID
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
# Use the last 4 characters as a short identifier
INSTANCE_SHORT_ID=$(echo $INSTANCE_ID | tail -c 5)

# Get the private IP address
PRIVATE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

echo "<h1>Hello from ${name_prefix}-Webapp-$INSTANCE_SHORT_ID</h1>" | sudo tee /var/www/html/index.html

# loads index.html on all paths
echo 'RewriteEngine On' >> /etc/httpd/conf.d/custom.conf
echo 'RewriteRule ^/[a-zA-Z0-9]+[/]?$ /index.html [QSA,L]' >> /etc/httpd/conf.d/custom.conf
systemctl restart httpd

