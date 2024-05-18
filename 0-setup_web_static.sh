#!/usr/bin/env bash
# script that sets up your web servers for the deployment of web_static
# Installs Nginx if it is not already installed
if ! command -v nginx &> /dev/null
then
    sudo apt-get update
    sudo apt-get install -y nginx
fi

# Creates the required directories
sudo mkdir -p /data/web_static/releases/test/
sudo mkdir -p /data/web_static/shared/

# Creates a fake HTML file with simple content
echo "<html>
  <head>
  </head>
  <body>
    Web Static Deployment
  </body>
</html>" | sudo tee /data/web_static/releases/test/index.html

# Creates  a symbolic link, recreate it if it already exists
if [ -L /data/web_static/current ]; then
    sudo rm /data/web_static/current
fi
sudo ln -s /data/web_static/releases/test/ /data/web_static/current

# Gives ownership of the /data/ folder to the ubuntu user and group
sudo chown -R ubuntu:ubuntu /data/

# Updates the Nginx configuration
sudo sed -i '/server_name _;/a \\
    location /hbnb_static {\\
        alias /data/web_static/current/;\\
    }' /etc/nginx/sites-available/default

# Restarts Nginx to apply the changes
sudo service nginx restart

echo "Web static deployment setup completed."
