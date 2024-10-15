#!/bin/bash
yum update –y
yum –y install httpd
systemctl start httpd
systemctl enable httpd
sudo yum -y install git
git clone "https://github.com/ARAVIND123-mi/Mario.git"
cd Mario/
sudo mv * /var/www/html/
