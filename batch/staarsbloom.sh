#!/bin/bash




#Update Server
sudo apt update


#install wget and zip
sudo apt install wget zip -y


#install apache2 and check firewall status
sudo apt install apache2 -y
sudo ufw app list




#restart Apache
sudo systemctl restart apache2


echo
echo "####################################"
echo "Apache Server installed successfully"
echo "####################################"






#Pull project from gits
sudo wget https://github.com/Aledoy-Developers/starsandbloom/archive/refs/heads/main.zip


unzip main.zip


#remove default index.html in server directory
sudo rm -rf /var/www/html/index.html


#copy project to server directory
sudo cp -r starsandbloom-main/* /var/www/html/


echo
echo "###############################################"
echo "Website files downloaded to server successfully"
echo "###############################################"




#install mysql
sudo apt install mysql-server -y






#create database
sudo mysql -u root -e 'CREATE DATABASE starsandbloom;'


#create a user
sudo mysql -u root -e "CREATE USER 'starsandbloom'@'localhost' IDENTIFIED BY 'valentine';"


#grant user all privileges to database
sudo mysql -u root -e "GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER ON starsandbloom.* TO 'starsandbloom'@'localhost';"
sudo mysql -u root -e 'FLUSH PRIVILEGES;'




#import database from project folder
sudo mysql -u root starsandbloom < /var/www/html/starsandbloom_starsbloom.sql




echo
echo "################################"
echo "MYSQL installed with DB imported"
echo "################################"




#install php
sudo apt install php libapache2-mod-php php-mysql -y
php -v


echo
echo "################################"
echo "PHP installed successfully"
echo "################################"


#restart Apache
sudo systemctl restart apache2


echo
echo "#########################################"
echo "Server Restarted and Everything Live!!!!!"
echo "#########################################"