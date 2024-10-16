#!/bin/bash
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo yum install -y git
git clone "https://github.com/ARAVIND123-mi/food.git"
cd /
sudo mv food/* /var/www/html/

