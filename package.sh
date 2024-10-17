#!/bin/bash
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo yum install -y git
git clone "https://github.com/ARAVIND123-mi/ecomm.git"
cd /
sudo mv ecomm/* /var/www/html/

